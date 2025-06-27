# Normalization of Airbnb Database Schema (Up to 3NF)

## First Normal Form (1NF)
- All tables have **atomic** columns — no multivalued or repeating groups.
- Example: `User.name`, `Property.title`, `Review.rating` are all atomic values.

✅ All tables satisfy 1NF.

---

## Second Normal Form (2NF)
- All non-key attributes are fully functionally dependent on the **entire** primary key.
- Since all tables have **single-column primary keys**, 2NF is inherently satisfied.

✅ All tables satisfy 2NF.

---

## Third Normal Form (3NF)
- No transitive dependencies — i.e., non-key attributes do not depend on other non-key attributes.
  - In `Booking`, fields like `status` and `total_price` depend **only** on `booking_id`.
  - In `Property`, `host_id` is a foreign key but not causing redundancy.

# All tables satisfy 3NF.

## 1. User Table
All attributes are atomic.

All non-key attributes (name, email, phone_number, etc.) depend only on user_id.
:3NF compliant.

## 2. Property Table
Atomic attributes.

host_id references user_id (good normalization).

No derived values or transitive dependencies.
:3NF compliant.

## 3. Booking Table
Attributes like start_date, end_date, status, total_price are directly tied to the booking.

user_id and property_id are foreign keys — not storing redundant user or property data.
:3NF compliant.

## 4. Payment Table
Only holds the booking_id and payment-specific data (amount, payment_date).

No redundancy or transitive dependencies.
:3NF compliant.

## 5. Review Table
Holds atomic attributes (rating, comment, etc.).

Depends on both user_id and property_id, but they’re FKs and not part of a composite PK.
:3NF compliant.

## 6. Message Table
sender_id, receiver_id → references to user_id.

Atomic content, and sent_at — no derived or redundant info.
:3NF compliant.
