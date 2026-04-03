import "@typespec/http";

using TypeSpec.Http;

namespace CalendarBooking;

// ============== Error Models ==============

@error
model NotFoundError {
  @statusCode _: 404;
  code: "NotFound";
  message: string;
}

@error
model SlotAlreadyBookedError {
  @statusCode _: 409;
  code: "SlotAlreadyBooked";
  message: string;
  conflictingBookingId: string;
}

@error
model InvalidDateError {
  @statusCode _: 400;
  code: "InvalidDate";
  message: string;
  field: string;
}

@error
model ValidationError {
  @statusCode _: 422;
  code: "ValidationError";
  field: string;
  message: string;
}

@error
model EventTypeHasBookingsError {
  @statusCode _: 409;
  code: "EventTypeHasBookings";
  message: string;
}
