
### ENTITIES AND ATTRIBUTES

---

#### **User**

* `user_id` (PK)
* `name`
* `email` (UNIQUE, NOT NULL)
* `phone_number`
* `password`
* `created_at` (DEFAULT CURRENT\_TIMESTAMP)

---

#### **Property**

* `property_id` (PK)
* `title`
* `description`
* `location`
* `price`
* `host_id` (FK → User)
* `created_at`

---

#### **Booking**

* `booking_id` (PK)
* `user_id` (FK → User)
* `property_id` (FK → Property)
* `start_date`
* `end_date`
* `status`
* `total_price`
* `created_at`

---

#### **Payment**

* `payment_id` (PK)
* `booking_id` (FK → Booking)
* `amount`
* `payment_date`

---

#### **Review**

* `review_id` (PK)
* `user_id` (FK → User)
* `property_id` (FK → Property)
* `rating` (1–5)
* `comment`
* `created_at`

---

#### **Message**

* `message_id` (PK)
* `sender_id` (FK → User)
* `receiver_id` (FK → User)
* `content`
* `sent_at`

---

### RELATIONSHIPS

| Relationship                               | Type           | Description                               |
| ------------------------------------------ | -------------- | ----------------------------------------- |
| User → Property                            | 1-to-Many      | A host can list multiple properties.      |
| User → Booking                             | 1-to-Many      | A user can make multiple bookings.        |
| User → Review                              | 1-to-Many      | A user can leave multiple reviews.        |
| Property → Booking                         | 1-to-Many      | A property can be booked many times.      |
| Property → Review                          | 1-to-Many      | A property can have many reviews.         |
| Booking → Payment                          | 1-to-1         | Each booking has a corresponding payment. |
| User → Message (sender\_id & receiver\_id) | 1-to-Many (2x) | Messages are between users.               |
