import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

@service({
  title: "Calendar Booking API",
  version: "1.0.0",
})
@server("https://api.example.com", "Production server")
namespace CalendarBooking;

// Import other files
import "./models.tsp";
import "./errors.tsp";
import "./operations.tsp";
