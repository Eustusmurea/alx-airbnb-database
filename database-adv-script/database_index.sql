-- Index for bookings.user_id to speed up user-based lookups
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Index for properties.price to speed up price-range filtering
CREATE INDEX idx_properties_price ON properties(price);

-- Index for bookings.start_date to improve date filtering
CREATE INDEX idx_bookings_start_date ON bookings(start_date);


-- EXPLAIN ANALYZE before indexing (example query on bookings by user)
-- Note: run this before creating the index to see Seq Scan
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE user_id = 'some-uuid';


-- EXPLAIN ANALYZE after indexing (expected to use Index Scan)
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE user_id = 'some-uuid';


-- EXPLAIN ANALYZE before indexing (price filter)
-- Note: run before creating price index to see Seq Scan
EXPLAIN ANALYZE
SELECT * FROM properties WHERE price BETWEEN 100 AND 300;


-- EXPLAIN ANALYZE after indexing (expected to use Bitmap Index Scan)
EXPLAIN ANALYZE
SELECT * FROM properties WHERE price BETWEEN 100 AND 300;


-- EXPLAIN ANALYZE before indexing (date filter)
-- Note: run before creating start_date index to see Seq Scan
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';


-- EXPLAIN ANALYZE after indexing (expected to use Index Scan or Partition Pruning)
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';
