--- aggregations
SELECT
    u.user_id,
    u.name,
    u.email,
    COUNT(b.booking_id) AS total_bookings
FROM
    users u
JOIN
    bookings b ON u.user_id = b.user_id
GROUP BY
    u.user_id, u.name, u.email;


--- window function with RANK()
SELECT
    property_id,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank
FROM (
    SELECT
        property_id,
        COUNT(*) AS total_bookings
    FROM
        bookings
    GROUP BY
        property_id
) AS property_counts;


--- window function with ROW_NUMBER()
SELECT
    property_id,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS booking_row_number
FROM (
    SELECT
        property_id,
        COUNT(*) AS total_bookings
    FROM
        bookings
    GROUP BY
        property_id
) AS property_counts;
