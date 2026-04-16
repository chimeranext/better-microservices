export abstract class DomainError extends Error {
  abstract readonly code: string;

  constructor(
    message: string,
    readonly context?: Record<string, unknown>,
  ) {
    super(message);
    this.name = this.constructor.name;
  }
}

export class InvariantViolationError extends DomainError {
  readonly code = "DOMAIN.INVARIANT_VIOLATION";
}

export class ValidationError extends DomainError {
  readonly code = "DOMAIN.VALIDATION";

  constructor(
    message: string,
    readonly fieldErrors: Array<{ field: string; message: string }>,
    context?: Record<string, unknown>,
  ) {
    super(message, context);
  }
}

export class NotFoundError extends DomainError {
  readonly code = "DOMAIN.NOT_FOUND";
}

export class ConflictError extends DomainError {
  readonly code = "DOMAIN.CONFLICT";
}
