import { describe, expect, it } from "vitest";
import { AggregateRoot } from "../../src/shared-kernel/aggregate-root.js";
import type { DomainEvent } from "../../src/shared-kernel/events.js";

class TestAggregate extends AggregateRoot {
  emit(event: DomainEvent): void {
    this.recordEvent(event);
  }
}

const mkEvent = (id: string, aggregateId: string): DomainEvent => ({
  eventId: id,
  eventType: "Test",
  aggregateId,
  timestamp: new Date().toISOString(),
  metadata: {},
});

describe("AggregateRoot", () => {
  it("stores id + starts with no events", () => {
    const a = new TestAggregate("agg-1");
    expect(a.id).toBe("agg-1");
    expect(a.peekEvents()).toEqual([]);
  });

  it("recordEvent + peekEvents reveals but does not drain", () => {
    const a = new TestAggregate("agg-1");
    a.emit(mkEvent("e1", "agg-1"));
    a.emit(mkEvent("e2", "agg-1"));
    expect(a.peekEvents().length).toBe(2);
    expect(a.peekEvents().length).toBe(2);
  });

  it("pullEvents returns and clears the queue", () => {
    const a = new TestAggregate("agg-1");
    a.emit(mkEvent("e1", "agg-1"));
    const pulled = a.pullEvents();
    expect(pulled.length).toBe(1);
    expect(a.peekEvents()).toEqual([]);
    expect(a.pullEvents()).toEqual([]);
  });
});
