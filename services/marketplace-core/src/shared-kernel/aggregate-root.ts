import type { DomainEvent } from "./events.js";

export abstract class AggregateRoot<TId extends string = string> {
  private readonly pendingEvents: DomainEvent[] = [];

  constructor(readonly id: TId) {}

  protected recordEvent(event: DomainEvent): void {
    this.pendingEvents.push(event);
  }

  pullEvents(): DomainEvent[] {
    const events = [...this.pendingEvents];
    this.pendingEvents.length = 0;
    return events;
  }

  peekEvents(): readonly DomainEvent[] {
    return [...this.pendingEvents];
  }
}
