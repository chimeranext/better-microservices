# Design — Stripe adapter (P0)

## File layout

```
src/adapters/outbound/stripe/
├── index.ts
├── stripe-client-factory.ts              single `new Stripe(...)` call
├── stripe-adapter.ts                     implements PaymentGatewayPort
├── stripe-subscription-adapter.ts        implements SubscriptionPort
├── stripe-webhook-verifier.ts            implements WebhookVerifierPort
├── stripe-payout-adapter.ts              implements PayoutPort
├── stripe-reconciliation-reader.ts       implements ReconciliationReaderPort
├── stripe-error-mapper.ts
├── stripe-event-translator.ts
└── types.ts                               narrow Stripe SDK types we actually use
```

## `stripe-client-factory.ts` (the pinned-SDK factory pattern)

```ts
import Stripe from 'stripe';

export interface StripeClientConfig {
  readonly secretKey: string;                   // sk_live_* or sk_test_*
  readonly apiVersion: Stripe.LatestApiVersion; // exactly one, matched to SDK 18.5.0
  readonly maxNetworkRetries: number;
  readonly timeoutMs: number;
  readonly appInfo: Stripe.AppInfo;
}

// Intentionally the ONLY place in the repo that constructs a Stripe client.
export function createStripeClient(config: StripeClientConfig): Stripe {
  return new Stripe(config.secretKey, {
    apiVersion: config.apiVersion,
    maxNetworkRetries: config.maxNetworkRetries,
    timeout: config.timeoutMs,
    appInfo: config.appInfo,
  });
}

// The version string the adapter uses everywhere. Bumping this is its own OpenSpec change.
export const STRIPE_API_VERSION: Stripe.LatestApiVersion = '2024-10-28.acacia';
```

ESLint rule block added in this change (extending the one from `repo-bootstrap`):

```js
'no-restricted-syntax': ['error', {
  selector: "NewExpression[callee.name='Stripe']",
  message: 'Construct Stripe only via stripe-client-factory.createStripeClient().',
}],
```

The rule is scoped so the `stripe-client-factory.ts` file itself is exempt via an `eslint-disable-next-line` comment on its single `new Stripe()` call, with a cross-reference to this design doc.

## `stripe-adapter.ts` shape

```ts
export class StripeAdapter implements PaymentGatewayPort {
  readonly gateway = 'stripe' as const;

  constructor(
    private readonly client: Stripe,
    private readonly errorMapper: StripeErrorMapper,
    private readonly logger: Logger,
  ) {}

  async initiate(input: InitiatePaymentInput): Promise<InitiatePaymentResult> {
    try {
      const intent = await this.client.paymentIntents.create(
        {
          amount: Number(input.amount.amountMinor),
          currency: input.amount.currency.toLowerCase(),
          metadata: { ...input.metadata, consumer: input.consumer },
          capture_method: 'automatic',
          confirmation_method: 'automatic',
          ...(input.returnUrl ? { return_url: input.returnUrl } : {}),
        },
        { idempotencyKey: input.idempotencyKey.toString() },
      );
      return {
        gatewayRef: { kind: 'stripe', paymentIntentId: intent.id },
        requiresAction: intent.status === 'requires_action',
        challenge: intent.status === 'requires_action'
          ? { gateway: 'stripe', payload: Buffer.from(intent.client_secret ?? '') }
          : undefined,
        checkoutUrl: undefined,  // no redirect model with PaymentIntents
      };
    } catch (err) {
      throw this.errorMapper.map(err);
    }
  }

  // confirm(), refund() — same pattern.
}
```

Note the `Number()` cast: the domain carries `bigint`, Stripe's TS SDK expects `number`. Safe for amounts under `Number.MAX_SAFE_INTEGER` (well above any realistic single-transaction amount). The adapter rejects amounts above `9_007_199_254_740_991n` with an explicit error rather than letting the cast silently lose precision.

## Webhook verifier

```ts
export class StripeWebhookVerifier implements WebhookVerifierPort {
  readonly source = 'stripe' as const;

  constructor(
    private readonly client: Stripe,
    private readonly signingSecret: string,
    private readonly translator: StripeEventTranslator,
  ) {}

  async verify(headers: Record<string, string>, rawBody: Buffer): Promise<DomainEvent> {
    const sig = headers['stripe-signature'];
    if (!sig) throw new WebhookSignatureError('missing stripe-signature');

    const event = this.client.webhooks.constructEvent(rawBody, sig, this.signingSecret);
    return this.translator.translate(event);
  }
}
```

`rawBody` is preserved by the inbound gRPC adapter: `ProcessWebhookRequest` has a `bytes raw_body` field; we never JSON-parse before signature verification.

## Event translator

Maps Stripe event types to domain events:

| Stripe type | Domain event |
|---|---|
| `payment_intent.succeeded` | `PaymentSucceeded` |
| `payment_intent.payment_failed` | `PaymentFailed` |
| `charge.refunded` | `PaymentRefunded` |
| `charge.dispute.created` | `PaymentDisputed` |
| `customer.subscription.created` | `SubscriptionActivated` |
| `customer.subscription.updated` (status → past_due) | `SubscriptionPastDue` |
| `customer.subscription.deleted` | `SubscriptionCanceled` |
| `payout.paid` | `PayoutIssued` |
| `payout.failed` | `PayoutFailed` |

Events Stripe fires that we don't translate (e.g. `invoice.*`, `customer.*`) are logged and dropped; translation is opt-in.

## Error mapper

```ts
map(err: unknown): ApplicationError {
  if (err instanceof Stripe.errors.StripeCardError)
    return new ApplicationError('GATEWAY_CARD_DECLINED', err.message);
  if (err instanceof Stripe.errors.StripeRateLimitError)
    return new ApplicationError('GATEWAY_RATE_LIMITED', err.message);
  if (err instanceof Stripe.errors.StripeAuthenticationError)
    return new ApplicationError('GATEWAY_AUTH_FAILED', err.message);
  if (err instanceof Stripe.errors.StripeConnectionError)
    return new ApplicationError('GATEWAY_UNAVAILABLE', err.message);
  if (err instanceof Stripe.errors.StripeInvalidRequestError)
    return new ApplicationError('GATEWAY_INVALID_REQUEST', err.message);
  // Fall-through: log with full context, return an internal error.
  this.logger.error({ err }, 'unmapped stripe error');
  return new ApplicationError('GATEWAY_INTERNAL', 'stripe internal error');
}
```

New application code `GATEWAY_CARD_DECLINED` and `GATEWAY_INVALID_REQUEST` are added to the mapping table; `grpc-server-inbound`'s `error-mapper.ts` gets the corresponding entries in this PR.

## Connect fee handling

`InitiatePaymentInput.metadata` carries (optionally) `application_fee_minor` and `transfer_destination`. The adapter, when either is present, adds `application_fee_amount` and `transfer_data.destination` to the `paymentIntents.create` call. Amounts over the principal currency are rejected client-side by the application layer; the adapter trusts the input.

Full Connect onboarding (Express account creation) is NOT in this change. Consumer apps onboard sub-accounts through Stripe's hosted flow and pass the resulting `acct_*` id as `transfer_destination`.

## Environment

Env vars declared by this change (reflected in `.env.example`):

```
STRIPE_SECRET_KEY=                 # sk_live_* or sk_test_*
STRIPE_WEBHOOK_SIGNING_SECRET=     # whsec_*
STRIPE_API_VERSION=2024-10-28.acacia  # override only if you know why
STRIPE_MAX_NETWORK_RETRIES=2
STRIPE_TIMEOUT_MS=15000
```

The composition root validates these via Zod and fails to start if `STRIPE_SECRET_KEY` is missing.

## Risks

- **SDK version drift via Dependabot** — the root cause of the SDK-drift incident. Mitigation: exact pin `"stripe": "18.5.0"` (no `^`, no `~`), plus a repo-wide CI check that verifies the exact version matches the constant in `stripe-client-factory.ts`.
- **Webhook body tampering** — mitigated by verifying on the raw bytes before any JSON parse.
- **Amount casts losing precision** — covered by the `bigint → number` guard. Documented in-code.
- **Test-mode vs live-mode key mix-up** — mitigated by the Stripe SDK itself (it refuses cross-mode operations). We also log the key prefix (`sk_live_` vs `sk_test_`) at startup for visibility.
- **Event translator gaps** — if Stripe fires an unmapped event type we need later, we log it and drop. Adding a translation is an additive change to the table above.

## Rollback

Revert the merge. Stripe flows stop working against `payments-core`; learning-platform's existing Edge Functions (until their deprecation PR merges) remain the fallback. Other gateways are unaffected. The factory pattern and error mapping can be re-applied when re-landing.
