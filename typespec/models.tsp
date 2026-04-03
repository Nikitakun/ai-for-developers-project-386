import "@typespec/http";

using TypeSpec.Http;

namespace CalendarBooking;

// ============== Core Models ==============

model Owner {
  @key
  @visibility(Lifecycle.Read)
  id: string;

  @visibility(Lifecycle.Read)
  name: string;

  @visibility(Lifecycle.Read)
  email: string;

  @visibility(Lifecycle.Read)
  avatarUrl?: string;
}

model EventType {
  @key
  @visibility(Lifecycle.Read)
  id: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minValue(1)
  durationMinutes: int32;

  @visibility(Lifecycle.Read)
  ownerId: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  color?: string;
}

model Booking {
  @key
  @visibility(Lifecycle.Read)
  id: string;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  eventTypeId: string;

  @visibility(Lifecycle.Read)
  @encode("unixTimestamp", int32)
  startTime: utcDateTime;

  @visibility(Lifecycle.Read)
  @encode("unixTimestamp", int32)
  endTime: utcDateTime;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @format("email")
  guestEmail: string;

  @visibility(Lifecycle.Read)
  @encode("unixTimestamp", int32)
  createdAt: utcDateTime;

  // Include event type details in response
  @visibility(Lifecycle.Read)
  eventType?: EventTypeSummary;
}

model EventTypeSummary {
  id: string;
  name: string;
  durationMinutes: int32;
}

model TimeSlot {
  @encode("unixTimestamp", int32)
  startTime: utcDateTime;

  @encode("unixTimestamp", int32)
  endTime: utcDateTime;

  status: SlotStatus;
}

enum SlotStatus {
  available,
  busy,
}

// ============== Request/Response Models ==============

model CreateEventTypeRequest {
  name: string;
  description?: string;
  @minValue(1)
  durationMinutes: int32;
  color?: string;
}

model UpdateEventTypeRequest {
  name?: string;
  description?: string;
  @minValue(1)
  durationMinutes?: int32;
  color?: string;
}

model CreateBookingRequest {
  eventTypeId: string;
  @encode("unixTimestamp", int32)
  startTime: utcDateTime;
  @format("email")
  guestEmail: string;
}

model ListBookingsParams {
  @query
  @encode("unixTimestamp", int32)
  from?: utcDateTime;

  @query
  @encode("unixTimestamp", int32)
  to?: utcDateTime;
}

model AvailabilityParams {
  @query
  date: plainDate;

  @query
  eventTypeId: string;
}
