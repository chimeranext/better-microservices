# ReputationPort -- Generic Reputation Interface for marketplace-core

**Status:** Draft
**Date:** 2026-04-12
**Author:** Architecture Team

---

## 1. Problem Statement

Six projects across the ChimeraNext portfolio require reputation/trust scoring, each with different domain semantics but overlapping structural patterns:

| Project | Who gets rated | Who rates | What drives reputation |
|---------|---------------|-----------|----------------------|
| **Keiko** | Tutor | Learner (implicitly, via outcomes) | Session completion, learning outcomes, interaction quality |
| **AduaNext** | Vetted Sourcer | Platform + pyme buyers | 7 weighted compliance signals, KYC tier, delivery history |
| **HabitaNexus** | Propietario / Inquilino (mutual) | Counterpart at contract end | 1-5 stars + comment after lease termination |
| **AltruPets** | Pet shop / vendor | Buyer | Product quality, delivery timeliness, customer service |
| **MeshCommerce** | Store | Buyer | Order fulfillment, product accuracy, response time |
| **VertivoLatam** | Agricultor | Buyer / distributor | Produce quality, freshness, volume consistency |

A generic `ReputationPort` lets each project plug in its own scoring logic, storage backend, and domain events without reimplementing the structural plumbing.

---

## 2. Research Inputs

### 2.1 Keiko -- Cairo Contracts (Madara Appchain)

Keiko's on-chain contracts (`ProofOfHumanity` + `LearningInteractions`) do **not** contain an explicit reputation contract. Reputation is implicit -- derived from:

- **Interaction history:** `interactions: Map<felt252, Vec<Interaction>>` stores every question, answer, exercise, discussion, and evaluation per user.
- **Tutorial sessions:** `tutorial_sessions: Map<felt252, Vec<TutorialSession>>` tracks session count, duration, tutor identity, and interaction density.
- **Session types:** `HumanTutor`, `AITutor`, `GroupStudy`, `IndividualStudy`.
- **Interaction types:** `Question`, `Answer`, `Exercise`, `Discussion`, `Evaluation`, `Individual`.
- **Events emitted:** `InteractionCreated`, `TutorialSessionStarted`, `TutorialSessionEnded`.

**Key insight:** Keiko computes reputation off-chain by aggregating on-chain interaction data. The "reputation score" is a read model, not an on-chain state variable. This is a pattern we should support in the port.

### 2.2 AduaNext -- Vetted Sourcer Trust Score

From the SRD (J06 journey):

- Trust score has **4 tiers:** `Unverified -> Basic -> Verified -> Trusted`
- Calculated from **7 weighted signals** (defined in Spike 004, not yet implemented):
  - KYC document completion
  - HS code validation accuracy
  - Delivery fulfillment rate
  - Pyme satisfaction ratings
  - Time on platform
  - Certification completion (origin certificates)
  - Volume of successful transactions
- Trust score lifecycle: `45 (Basic) -> 72 (Verified, post-KYC) -> 88 (Trusted, 10+ successful dispatches)`
- Score influences marketplace visibility and eligibility for blanket certificates.

### 2.3 HabitaNexus -- Mutual Ratings

From the SOP (Fase 7.2 Terminacion Ordinaria):

- Both parties rate each other: **1-5 stars + comment**
- Ratings happen at two points: contract termination (ordinary or early)
- Negative ratings auto-generated when reclamos escalate without response (`ESCALADO -> CALIFICACION_NEGATIVA`)
- No-show behavior tracked in inquilino profile (visit without cancellation)
- Ratings are **bilateral and symmetric** -- both propietario and inquilino rate simultaneously.

---

## 3. Port Interface

```python
"""
marketplace_core.domain.ports.reputation_port
"""
from __future__ import annotations

from abc import ABC, abstractmethod
from typing import Optional, Sequence
from uuid import UUID

from marketplace_core.domain.value_objects.reputation import (
    Rating,
    ReputationScore,
    ReputationTier,
    ReviewSummary,
    SignalWeight,
)


class ReputationPort(ABC):
    """
    Driven port for reputation scoring across all marketplace projects.

    Each project provides its own adapter that implements this interface.
    The adapter decides whether data lives on-chain (Madara/Starknet),
    in PostgreSQL, or in a hybrid read-model.
    """

    # ── Commands ──────────────────────────────────────────────

    @abstractmethod
    async def submit_rating(
        self,
        rating: Rating,
    ) -> UUID:
        """
        Record a rating from one entity to another.

        Returns the persisted rating ID.

        Raises:
            DuplicateRatingError: if this rater already rated this subject
                                  for this context_id.
            InvalidRatingError: if score is outside the allowed range.
        """
        ...

    @abstractmethod
    async def submit_signal(
        self,
        subject_id: UUID,
        signal_name: str,
        signal_value: float,
        context_id: Optional[UUID] = None,
    ) -> None:
        """
        Record a non-star reputation signal (e.g., KYC completion,
        delivery success, session duration).

        Used by projects where reputation is computed from weighted
        signals rather than explicit star ratings.
        """
        ...

    @abstractmethod
    async def recalculate_score(
        self,
        subject_id: UUID,
    ) -> ReputationScore:
        """
        Recompute the aggregate reputation score for a subject.

        The implementation decides the algorithm:
        - Simple average (HabitaNexus)
        - Weighted signals (AduaNext)
        - Interaction-derived metrics (Keiko)
        - Bayesian average (MeshCommerce, AltruPets)

        Returns the updated ReputationScore.
        """
        ...

    @abstractmethod
    async def apply_penalty(
        self,
        subject_id: UUID,
        reason: str,
        penalty_points: float,
        context_id: Optional[UUID] = None,
    ) -> ReputationScore:
        """
        Apply a negative adjustment (e.g., escalated complaint
        without response in HabitaNexus, failed compliance check
        in AduaNext).

        Returns the updated ReputationScore after penalty.
        """
        ...

    # ── Queries ───────────────────────────────────────────────

    @abstractmethod
    async def get_score(
        self,
        subject_id: UUID,
    ) -> Optional[ReputationScore]:
        """Return the current aggregate score for a subject."""
        ...

    @abstractmethod
    async def get_ratings(
        self,
        subject_id: UUID,
        limit: int = 20,
        offset: int = 0,
    ) -> Sequence[Rating]:
        """Return paginated ratings received by a subject."""
        ...

    @abstractmethod
    async def get_review_summary(
        self,
        subject_id: UUID,
    ) -> ReviewSummary:
        """
        Return an aggregate summary: total ratings, average score,
        score distribution, and tier.
        """
        ...

    @abstractmethod
    async def get_tier(
        self,
        subject_id: UUID,
    ) -> ReputationTier:
        """
        Return the current reputation tier for a subject.

        Tier thresholds are project-specific (configured in the adapter).
        """
        ...
```

---

## 4. Value Objects

```python
"""
marketplace_core.domain.value_objects.reputation
"""
from __future__ import annotations

from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum
from typing import Dict, Optional, Sequence
from uuid import UUID, uuid4


class ReputationTier(str, Enum):
    """
    Universal tier system. Projects map their domain-specific
    tiers onto these levels.
    """
    UNRATED = "unrated"        # No data yet
    BASIC = "basic"            # Minimal activity
    VERIFIED = "verified"      # Identity/KYC confirmed or sufficient history
    TRUSTED = "trusted"        # Strong track record
    EXEMPLARY = "exemplary"    # Top percentile


@dataclass(frozen=True)
class Rating:
    """
    A single rating from one entity to another.

    Covers both explicit star ratings (HabitaNexus, AltruPets,
    MeshCommerce, VertivoLatam) and structured evaluations (Keiko).
    """
    id: UUID = field(default_factory=uuid4)

    # Who is being rated
    subject_id: UUID = field(default=None)

    # Who is rating (None for system-generated ratings)
    rater_id: Optional[UUID] = None

    # The rating score (1-5 for stars, 0-100 for weighted scores)
    score: float = 0.0

    # Maximum possible score (5 for stars, 100 for weighted)
    max_score: float = 5.0

    # Free-text comment (optional)
    comment: Optional[str] = None

    # What this rating is about -- links to a transaction, contract,
    # session, order, etc.
    context_id: Optional[UUID] = None

    # Project-specific rating category
    # e.g., "overall", "communication", "quality", "timeliness",
    #       "freshness", "compliance"
    dimension: str = "overall"

    # When the rating was submitted
    created_at: datetime = field(default_factory=datetime.utcnow)

    def normalized_score(self) -> float:
        """Return score normalized to 0.0-1.0 range."""
        if self.max_score == 0:
            return 0.0
        return self.score / self.max_score


@dataclass(frozen=True)
class SignalWeight:
    """
    Defines a weighted signal for composite reputation scoring.

    Used by AduaNext (7 signals) and Keiko (interaction metrics).
    """
    signal_name: str
    weight: float          # 0.0 to 1.0, all weights should sum to 1.0
    current_value: float   # 0.0 to 1.0 (normalized)
    description: str = ""


@dataclass(frozen=True)
class ReputationScore:
    """
    The aggregate reputation for a subject at a point in time.
    """
    subject_id: UUID

    # Aggregate score (0.0 to 1.0, normalized)
    overall_score: float

    # Current tier
    tier: ReputationTier

    # Total number of ratings/signals that contributed
    total_ratings: int

    # Per-dimension breakdown (optional)
    # e.g., {"quality": 0.85, "timeliness": 0.92, "communication": 0.78}
    dimension_scores: Dict[str, float] = field(default_factory=dict)

    # For signal-based systems: the individual signal values
    signal_weights: Sequence[SignalWeight] = field(default_factory=list)

    # When this score was last computed
    computed_at: datetime = field(default_factory=datetime.utcnow)

    def star_rating(self, max_stars: int = 5) -> float:
        """Convert normalized score to star rating."""
        return round(self.overall_score * max_stars, 1)


@dataclass(frozen=True)
class ReviewSummary:
    """
    Aggregated view of all ratings for a subject.
    Suitable for display in search results and profile pages.
    """
    subject_id: UUID
    total_ratings: int
    average_score: float         # 0.0 to 1.0
    tier: ReputationTier

    # Distribution: how many ratings at each star level
    # e.g., {1: 2, 2: 5, 3: 12, 4: 30, 5: 51}
    score_distribution: Dict[int, int] = field(default_factory=dict)

    # Most recent ratings (for preview)
    recent_ratings: Sequence[Rating] = field(default_factory=list)

    # Number of penalties applied
    penalty_count: int = 0

    def star_rating(self, max_stars: int = 5) -> float:
        """Convert normalized average to star rating."""
        return round(self.average_score * max_stars, 1)
```

---

## 5. Domain Events

```python
"""
marketplace_core.domain.events.reputation_events
"""
from __future__ import annotations

from dataclasses import dataclass, field
from datetime import datetime
from typing import Optional
from uuid import UUID, uuid4

from marketplace_core.domain.value_objects.reputation import (
    ReputationTier,
)


@dataclass(frozen=True)
class RatingSubmitted:
    """
    Emitted when a new rating is recorded.

    Subscribers:
    - ReputationRecalculationHandler (triggers score recomputation)
    - NotificationService (notifies the subject)
    - AnalyticsService (tracks rating trends)
    """
    event_id: UUID = field(default_factory=uuid4)
    rating_id: UUID = field(default=None)
    subject_id: UUID = field(default=None)
    rater_id: Optional[UUID] = None
    score: float = 0.0
    max_score: float = 5.0
    dimension: str = "overall"
    context_id: Optional[UUID] = None
    occurred_at: datetime = field(default_factory=datetime.utcnow)


@dataclass(frozen=True)
class ReputationUpdated:
    """
    Emitted after a reputation score is recalculated.

    Subscribers:
    - SearchIndexService (updates marketplace ranking)
    - TierChangeHandler (checks if tier changed)
    - On-chain sync (Keiko/AduaNext: writes summary to Madara)
    """
    event_id: UUID = field(default_factory=uuid4)
    subject_id: UUID = field(default=None)
    previous_score: float = 0.0
    new_score: float = 0.0
    previous_tier: ReputationTier = ReputationTier.UNRATED
    new_tier: ReputationTier = ReputationTier.UNRATED
    total_ratings: int = 0
    occurred_at: datetime = field(default_factory=datetime.utcnow)

    @property
    def tier_changed(self) -> bool:
        return self.previous_tier != self.new_tier


@dataclass(frozen=True)
class ReputationPenaltyApplied:
    """
    Emitted when a penalty is applied to a subject's reputation.

    Subscribers:
    - ReputationRecalculationHandler
    - NotificationService (warns the subject)
    - ComplianceAuditLog (AduaNext)
    """
    event_id: UUID = field(default_factory=uuid4)
    subject_id: UUID = field(default=None)
    reason: str = ""
    penalty_points: float = 0.0
    context_id: Optional[UUID] = None
    occurred_at: datetime = field(default_factory=datetime.utcnow)


@dataclass(frozen=True)
class TierPromoted:
    """
    Emitted when a subject moves up a tier.

    Subscribers:
    - BadgeService (awards achievement)
    - FeatureGateService (unlocks capabilities -- e.g., AduaNext
      blanket certificates at Trusted tier)
    - NotificationService (congratulates the subject)
    """
    event_id: UUID = field(default_factory=uuid4)
    subject_id: UUID = field(default=None)
    previous_tier: ReputationTier = ReputationTier.UNRATED
    new_tier: ReputationTier = ReputationTier.UNRATED
    occurred_at: datetime = field(default_factory=datetime.utcnow)


@dataclass(frozen=True)
class TierDemoted:
    """
    Emitted when a subject drops a tier.

    Subscribers:
    - FeatureGateService (revokes capabilities)
    - NotificationService (warns the subject)
    - ComplianceAuditLog
    """
    event_id: UUID = field(default_factory=uuid4)
    subject_id: UUID = field(default=None)
    previous_tier: ReputationTier = ReputationTier.UNRATED
    new_tier: ReputationTier = ReputationTier.UNRATED
    reason: str = ""
    occurred_at: datetime = field(default_factory=datetime.utcnow)
```

---

## 6. Project Implementation Mapping

### 6.1 How Each Project Implements the Port

| Aspect | Keiko | AduaNext | HabitaNexus | AltruPets | MeshCommerce | VertivoLatam |
|--------|-------|----------|-------------|-----------|--------------|--------------|
| **Subject entity** | Tutor (human or AI) | Vetted Sourcer | Propietario + Inquilino | Pet shop / vendor | Store | Agricultor |
| **Rater entity** | Learner (implicit) | Platform + pyme | Counterpart tenant/owner | Buyer | Buyer | Buyer / distributor |
| **Rating model** | Signal-based (interactions) | 7 weighted signals | 1-5 stars + comment | 1-5 stars + comment | 1-5 stars + comment | 1-5 stars + multi-dimension |
| **Dimensions** | session_count, completion_rate, interaction_density, learner_outcomes | kyc, hs_accuracy, delivery, satisfaction, tenure, certifications, volume | overall (single dimension) | quality, service, delivery | fulfillment, accuracy, response_time | quality, freshness, consistency |
| **Tier mapping** | Unrated/Basic/Verified/Trusted | Unverified/Basic/Verified/Trusted | Unrated/Basic/Trusted | Unrated/Basic/Trusted | Unrated/Basic/Trusted/Exemplary | Unrated/Basic/Verified/Trusted |
| **Tier thresholds** | Session count + outcomes | 0-30: Basic, 31-70: Verified, 71-100: Trusted | Avg >= 3.0: Basic, >= 4.0: Trusted | Avg >= 3.5: Basic, >= 4.5: Trusted | Avg >= 3.5: Basic, >= 4.0: Trusted, >= 4.8: Exemplary | Avg >= 3.0: Basic, >= 4.0: Verified, >= 4.5: Trusted |
| **Mutual rating** | No (unidirectional) | No (marketplace rates sourcer) | **Yes** (both parties rate each other) | No (buyer rates vendor) | No (buyer rates store) | No (buyer rates agricultor) |
| **Auto-penalties** | None | Failed compliance check | Escalated reclamo, no-show | None | Order cancellation | Spoilage complaints |
| **Scoring algorithm** | Weighted signal aggregation | 7-signal weighted average | Arithmetic mean of stars | Bayesian average | Bayesian average | Weighted multi-dimension average |
| **`submit_rating` used** | Rarely (end-of-course eval) | No (uses `submit_signal`) | Primary method | Primary method | Primary method | Primary method |
| **`submit_signal` used** | Primary method | Primary method | Rarely (auto-penalty) | Rarely (auto-penalty) | Rarely (auto-penalty) | Secondary (freshness metrics) |

### 6.2 Adapter Class Names (Proposed)

| Project | Adapter class | Module path |
|---------|--------------|-------------|
| Keiko | `MadaraReputationAdapter` | `keiko.adapters.reputation.madara_reputation` |
| AduaNext | `PostgresReputationAdapter` | `aduanext.adapters.reputation.postgres_reputation` |
| HabitaNexus | `PostgresReputationAdapter` | `habitanexus.adapters.reputation.postgres_reputation` |
| AltruPets | `PostgresReputationAdapter` | `altrupets.adapters.reputation.postgres_reputation` |
| MeshCommerce | `PostgresReputationAdapter` | `meshcommerce.adapters.reputation.postgres_reputation` |
| VertivoLatam | `PostgresReputationAdapter` | `vertivolatam.adapters.reputation.postgres_reputation` |

---

## 7. Storage Decision: On-Chain vs Off-Chain

### Decision Matrix

| Factor | On-chain (Madara/Starknet) | Off-chain (PostgreSQL) |
|--------|--------------------------|----------------------|
| **Immutability** | Ratings cannot be tampered with | Requires audit log discipline |
| **Latency** | ~2-5s block confirmation | ~5-50ms query |
| **Cost** | Gas per write (even on appchain) | Negligible |
| **Query flexibility** | Very limited (no JOINs, no full-text) | Full SQL, aggregations, JSONB |
| **Privacy** | Public by default (even on appchain) | Access-controlled |
| **Throughput** | ~100 TPS (Madara) | ~10,000+ TPS |
| **Dispute resolution** | Transparent, verifiable | Requires separate audit trail |

### Per-Project Recommendation

| Project | Storage | Rationale |
|---------|---------|-----------|
| **Keiko** | **Hybrid** -- interactions on-chain (already there), reputation score as off-chain read model | Interactions are already stored in `LearningInteractions` Cairo contract. Reputation score is a derived computation -- no need to pay gas for what is essentially a materialized view. Off-chain read model synced via indexer (Apibara or custom). |
| **AduaNext** | **Off-chain (PostgreSQL)** | Trust score involves PII-adjacent data (KYC status, compliance records). Regulatory requirement to control data access. 7-signal computation needs flexible queries. Append-only event log in PostgreSQL provides auditability. |
| **HabitaNexus** | **Off-chain (PostgreSQL)** | Simple star ratings with comments. High query frequency (search results show ratings). Privacy-sensitive (tenant/landlord relationship). No blockchain integration planned. |
| **AltruPets** | **Off-chain (PostgreSQL)** | Standard e-commerce ratings. No blockchain requirement. Needs fast aggregation for search ranking. |
| **MeshCommerce** | **Off-chain (PostgreSQL)** | Same as AltruPets. Store reputation needs to be queryable with complex filters (category, location, etc.). |
| **VertivoLatam** | **Off-chain (PostgreSQL)** with optional on-chain hash | Freshness and quality scores could benefit from tamper-proof audit trail. Recommended: store ratings in PostgreSQL, periodically anchor a Merkle root on-chain for verifiability. |

### Hybrid Pattern (Keiko)

```
[LearningInteractions.cairo]     [Apibara Indexer]     [PostgreSQL]
        |                               |                    |
   emit events ──────────────> index events ──────> reputation_scores table
   (on-chain)                  (off-chain)          (materialized view)
                                                         |
                                                    ReputationPort
                                                    (query layer)
```

### Pure Off-Chain Pattern (HabitaNexus, AduaNext, etc.)

```
[Application Layer]
        |
   submit_rating() ──> ReputationPort ──> PostgresReputationAdapter
        |                                        |
   emit RatingSubmitted                   INSERT INTO ratings
        |                                        |
   recalculate_score()                    UPDATE reputation_scores
        |                                 (materialized aggregate)
   emit ReputationUpdated
```

---

## 8. Schema Sketch (PostgreSQL Adapter)

```sql
-- Shared schema, project-isolated via tenant_id or schema-per-project

CREATE TABLE ratings (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subject_id      UUID NOT NULL,
    rater_id        UUID,               -- NULL for system-generated
    score           NUMERIC(5,2) NOT NULL,
    max_score       NUMERIC(5,2) NOT NULL DEFAULT 5.0,
    dimension       VARCHAR(50) NOT NULL DEFAULT 'overall',
    comment         TEXT,
    context_id      UUID,               -- links to order, contract, session
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT valid_score CHECK (score >= 0 AND score <= max_score)
);

CREATE TABLE reputation_signals (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subject_id      UUID NOT NULL,
    signal_name     VARCHAR(100) NOT NULL,
    signal_value    NUMERIC(5,4) NOT NULL,  -- 0.0000 to 1.0000
    context_id      UUID,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE reputation_scores (
    subject_id      UUID PRIMARY KEY,
    overall_score   NUMERIC(5,4) NOT NULL DEFAULT 0.0,
    tier            VARCHAR(20) NOT NULL DEFAULT 'unrated',
    total_ratings   INTEGER NOT NULL DEFAULT 0,
    dimension_scores JSONB DEFAULT '{}',
    computed_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE reputation_penalties (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subject_id      UUID NOT NULL,
    reason          TEXT NOT NULL,
    penalty_points  NUMERIC(5,4) NOT NULL,
    context_id      UUID,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Indexes for common queries
CREATE INDEX idx_ratings_subject ON ratings(subject_id, created_at DESC);
CREATE INDEX idx_ratings_context ON ratings(context_id);
CREATE INDEX idx_scores_tier ON reputation_scores(tier, overall_score DESC);
CREATE INDEX idx_signals_subject ON reputation_signals(subject_id, signal_name);
```

---

## 9. Open Questions

1. **Should `recalculate_score` be synchronous or eventually consistent?** For high-throughput projects (MeshCommerce), async recalculation via event handler may be preferable. For low-volume projects (HabitaNexus), synchronous is simpler.

2. **Rating edit/delete policy.** The current design treats ratings as append-only. Should there be a `revise_rating()` method for correcting mistakes within a grace period (e.g., 24 hours)?

3. **Cross-project reputation portability.** If a sourcer on AduaNext is also a vendor on MeshCommerce, should reputation be portable? Deferred -- likely needs a separate `ReputationFederationPort`.

4. **Anonymity.** Should raters be anonymized in some contexts? HabitaNexus mutual ratings are by definition non-anonymous. AltruPets/MeshCommerce buyer reviews could be pseudonymous.

5. **Fraud detection.** Fake review detection is out of scope for the port but should be addressed in the adapter layer (e.g., requiring a verified transaction before allowing a rating).
