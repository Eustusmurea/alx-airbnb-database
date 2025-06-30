-- Initial query
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


-- Optimized version of the query to improve performance
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
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.booking_id = pay.booking_id
WHERE
    b.start_date >= CURRENT_DATE - INTERVAL '12 months'
    AND b.status = 'confirmed'
ORDER BY
    b.start_date DESC
LIMIT 100;
