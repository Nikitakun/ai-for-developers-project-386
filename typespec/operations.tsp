import "@typespec/http";

using TypeSpec.Http;

namespace CalendarBooking;

// ============== Owner Profile ==============

@route("/owner")
interface OwnerOperations {
  @get
  @summary("Get owner profile")
  get(): Owner;
}

// ============== Event Type Management (Owner) ==============

@route("/event-types")
interface EventTypeOperations {
  @get
  @summary("List all event types")
  list(): EventType[];

  @post
  @summary("Create new event type")
  @returnsCreatedResource(EventType)
  create(@body body: CreateEventTypeRequest): EventType;

  @put
  @summary("Update event type")
  @route("/{id}")
  update(
    @path id: string,
    @body body: UpdateEventTypeRequest
  ): EventType | NotFoundError;

  @delete
  @summary("Delete event type")
  @route("/{id}")
  delete(@path id: string): void | NotFoundError | EventTypeHasBookingsError;
}

// ============== Public Event Types (Guest) ==============

@route("/public/event-types")
interface PublicEventTypeOperations {
  @get
  @summary("List available event types")
  list(): EventType[];

  @get
  @summary("Get event type details")
  @route("/{id}")
  get(@path id: string): EventType | NotFoundError;
}

// ============== Availability (Guest) ==============

@route("/availability")
interface AvailabilityOperations {
  @get
  @summary("Get available time slots")
  getSlots(@query params: AvailabilityParams): TimeSlot[] | InvalidDateError;
}

// ============== Bookings Management (Owner) ==============

@route("/bookings")
interface BookingOperations {
  @get
  @summary("List upcoming bookings")
  list(@query params?: ListBookingsParams): Booking[];

  @get
  @summary("Get booking details")
  @route("/{id}")
  get(@path id: string): Booking | NotFoundError;

  @delete
  @summary("Cancel booking")
  @route("/{id}")
  cancel(@path id: string): void | NotFoundError;
}

// ============== Public Bookings (Guest) ==============

@route("/public/bookings")
interface PublicBookingOperations {
  @post
  @summary("Create new booking")
  @returnsCreatedResource(Booking)
  create(@body body: CreateBookingRequest): 
    | Booking 
    | NotFoundError 
    | SlotAlreadyBookedError 
    | InvalidDateError;
}
