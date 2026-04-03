# Call Booking Service (Запись на звонок)

Simplified Cal.com-inspired meeting booking API. Single owner publishes available slots, guests book without registration.

## Quick Context for AI Agents

**What this is:** REST API for calendar booking with two roles - Owner (predefined profile) and Guests (no auth).

**Core Flow:**
1. Owner creates event types (name, description, duration in minutes)
2. Guest browses public event types
3. Guest checks availability (30-min slots shown)
4. Guest books a slot (email only, no account)
5. Owner views upcoming bookings in unified list

**Key Constraints:**
- NO authentication/authorization
- NO external calendar integrations
- NO user registration
- Single predefined owner profile
- No double-booking: same timestamp cannot have two bookings, even different event types
- Slots default to 30-minute intervals

## API Structure

See `typespec/` directory for TypeSpec definitions that generate OpenAPI spec:
- `main.tsp` - Service definition
- `models.tsp` - Owner, EventType, Booking, TimeSlot models
- `operations.tsp` - REST endpoints split by role (owner vs public)
- `errors.tsp` - Error responses (404, 409 conflict, 400 invalid date)

**Roles & Endpoints:**
- Owner: manage event types, view all bookings
- Public (guests): view event types, check availability, create bookings

### Hexlet tests and linter status:
[![Actions Status](https://github.com/Nikitakun/ai-for-developers-project-386/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Nikitakun/ai-for-developers-project-386/actions)