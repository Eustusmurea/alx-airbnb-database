# Query Optimization Report

## Objective
Refactor a complex query joining `bookings`, `users`, `properties`, and `payments` tables to improve performance.

## Original Query
The original query retrieves all bookings with user, property, and payment details using multiple `LEFT JOIN`s without filtering:

```sql
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.total_price,
    u.user_id,
    u.name AS user_name,
    u.email AS user_email,
    p.property_id,
    p.title AS property_title,
    p.location,
    p.price AS property_price,
    pay.payment_id,
    pay.amount,
    pay.payment_date
FROM
    bookings b
LEFT JOIN users u ON b.user_id = u.user_id
LEFT JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id;
```

### Performance Analysis
Using `EXPLAIN ANALYZE`:
- Sequential Scan on `bookings` table.
- Multiple Hash Joins with `users`, `properties`, and `payments`.
- High total cost due to scanning all rows.
- No filtering, resulting in a large result set.

### Identified Issues
- No `WHERE` clause, returning the entire `bookings` table.
- Unnecessary `LEFT JOIN` for `payments`, which are always present.
- No `LIMIT`, causing excessive row retrieval.
- No filtering on `start_date`.
- Indexes not utilized.

## Optimized Query
### Changes Made
- Replaced `LEFT JOIN` with `INNER JOIN` for `payments`, assuming they always exist.
- Added `WHERE` clause to filter bookings from the last 12 months.
- Included `ORDER BY` and `LIMIT` to reduce the number of rows returned.
- Leveraged indexes on `user_id`, `property_id`, `booking_id`, and `start_date` for faster joins and filtering.

```sql
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.total_price,
    u.name AS user_name,
    u.email AS user_email,
    p.title AS property_title,
    p.location,
    pay.amount
FROM
    bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
INNER JOIN payments pay ON b.booking_id = pay.booking_id
WHERE
    b.start_date >= CURRENT_DATE - INTERVAL '12 months'
ORDER BY
    b.start_date DESC
LIMIT 100;
```

### Results After Optimization
`EXPLAIN ANALYZE` output:
- Index Scan or Bitmap Index Scan on `bookings.start_date`.
- Nested Loop/Index Joins instead of Hash Joins.
- Significantly reduced query cost.
- Faster execution time.