# Airbnb Database Schema


## 🧱 Tables & Relationships

### 1. `users`
Stores user profile and authentication details.

| Column        | Type          | Constraints             |
|---------------|---------------|--------------------------|
| user_id       | UUID          | Primary Key              |
| name          | VARCHAR(255)  | NOT NULL                 |
| email         | VARCHAR(255)  | NOT NULL, UNIQUE         |
| phone_number  | VARCHAR(20)   |                          |
| password      | TEXT          | NOT NULL                 |
| created_at    | TIMESTAMP     | DEFAULT CURRENT_TIMESTAMP |

🔗 **Relationships**:
- One-to-many with `properties`, `bookings`, `reviews`, and `messages`.

---

### 2. `properties`
Represents properties listed by users (hosts).

| Column       | Type          | Constraints             |
|--------------|---------------|--------------------------|
| property_id  | UUID          | Primary Key              |
| title        | VARCHAR(255)  | NOT NULL                 |
| description  | TEXT          |                          |
| location     | VARCHAR(255)  | NOT NULL                 |
| price        | NUMERIC(10,2) | NOT NULL                 |
| host_id      | UUID          | Foreign Key → `users`    |
| created_at   | TIMESTAMP     | DEFAULT CURRENT_TIMESTAMP |

🔗 **Relationships**:
- One-to-many with `bookings` and `reviews`.

---

### 3. `bookings`
Captures property reservations by users.

| Column       | Type          | Constraints             |
|--------------|---------------|--------------------------|
| booking_id   | UUID          | Primary Key              |
| user_id      | UUID          | Foreign Key → `users`    |
| property_id  | UUID          | Foreign Key → `properties` |
| start_date   | DATE          | NOT NULL                 |
| end_date     | DATE          | NOT NULL                 |
| status       | VARCHAR(50)   | DEFAULT 'pending'        |
| total_price  | NUMERIC(10,2) | NOT NULL                 |
| created_at   | TIMESTAMP     | DEFAULT CURRENT_TIMESTAMP |

🔗 **Relationships**:
- One-to-one with `payments`.

---

### 4. `payments`
Stores payment transactions for bookings.

| Column       | Type          | Constraints             |
|--------------|---------------|--------------------------|
| payment_id   | UUID          | Primary Key              |
| booking_id   | UUID          | Foreign Key → `bookings` |
| amount       | NUMERIC(10,2) | NOT NULL                 |
| payment_date | TIMESTAMP     | DEFAULT CURRENT_TIMESTAMP |

---

### 5. `reviews`
Captures feedback left by users for properties.

| Column       | Type          | Constraints             |
|--------------|---------------|--------------------------|
| review_id    | UUID          | Primary Key              |
| user_id      | UUID          | Foreign Key → `users`    |
| property_id  | UUID          | Foreign Key → `properties` |
| rating       | INT           | CHECK 1–5                |
| comment      | TEXT          |                          |
| created_at   | TIMESTAMP     | DEFAULT CURRENT_TIMESTAMP |

---

### 6. `messages`
Allows users to send messages to each other.

| Column       | Type          | Constraints             |
|--------------|---------------|--------------------------|
| message_id   | UUID          | Primary Key              |
| sender_id    | UUID          | Foreign Key → `users`    |
| receiver_id  | UUID          | Foreign Key → `users`    |
| content      | TEXT          | NOT NULL                 |
| sent_at      | TIMESTAMP     | DEFAULT CURRENT_TIMESTAMP |

---

## 🔒 Data Integrity & Constraints

- All primary keys are UUIDs (using `gen_random_uuid()`).
- Foreign key constraints enforce referential integrity.
- Unique constraints on `email`.
- `CHECK` constraint on `reviews.rating` (1 to 5).

---

## 🚀 Indexing Strategy

Indexes created on:
- Primary Keys (automatic)
- Foreign Key columns: `host_id`, `user_id`, `property_id`, `booking_id`, `sender_id`, `receiver_id`
- `email` for fast user lookup

---

## 📐 Normalization

The database is normalized to **Third Normal Form (3NF)**:
- All attributes are atomic (1NF)
- All attributes depend on the whole primary key (2NF)
- No transitive dependencies (3NF)

