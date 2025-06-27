-- Users
INSERT INTO users (user_id, name, email, phone_number, password) VALUES
  (gen_random_uuid(), 'Faith Nduta', 'faith.nduta@gmail.com', '0712345678', 'hashed_123'),
  (gen_random_uuid(), 'Kevin Otieno', 'kevin.oti@gmail.com', '0722233344', 'hashed_234'),
  (gen_random_uuid(), 'Sandra Mburu', 'sandra.mburu@gmail.com', '0733112233', 'hashed_345');

--  Properties
INSERT INTO properties (property_id, title, description, location, price, host_id) VALUES
  (gen_random_uuid(), 'Modern Nairobi Loft', 'Loft with rooftop view and fast WiFi.', 'Nairobi', 85.00,
   (SELECT user_id FROM users ORDER BY RANDOM() LIMIT 1)),
  (gen_random_uuid(), 'Rustic Cottage in Limuru', 'Cozy wooden cottage surrounded by tea farms.', 'Limuru', 60.00,
   (SELECT user_id FROM users ORDER BY RANDOM() LIMIT 1));

--  Bookings
INSERT INTO bookings (booking_id, user_id, property_id, start_date, end_date, status, total_price) VALUES
  (gen_random_uuid(),
   (SELECT user_id FROM users ORDER BY RANDOM() LIMIT 1),
   (SELECT property_id FROM properties ORDER BY RANDOM() LIMIT 1),
   CURRENT_DATE + INTERVAL '7 days',
   CURRENT_DATE + INTERVAL '10 days',
   'confirmed', 255.00);

-- Payments
INSERT INTO payments (payment_id, booking_id, amount) VALUES
  (gen_random_uuid(),
   (SELECT booking_id FROM bookings ORDER BY RANDOM() LIMIT 1),
   255.00);

-- Reviews
INSERT INTO reviews (review_id, user_id, property_id, rating, comment) VALUES
  (gen_random_uuid(),
   (SELECT user_id FROM users ORDER BY RANDOM() LIMIT 1),
   (SELECT property_id FROM properties ORDER BY RANDOM() LIMIT 1),
   5, 'Absolutely lovely! Clean and well-furnished.');

--  Messages
INSERT INTO messages (message_id, sender_id, receiver_id, content) VALUES
  (gen_random_uuid(),
   (SELECT user_id FROM users ORDER BY RANDOM() LIMIT 1),
   (SELECT user_id FROM users ORDER BY RANDOM() LIMIT 1),
   'Hello, is this place pet-friendly?');
