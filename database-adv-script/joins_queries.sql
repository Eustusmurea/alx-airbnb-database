--- select all bookings and their respective users 
--- inner join query
SELECT
    b.id AS booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    u.id AS user_id,
    u.name,
    u.email
FROM
    Bookings b
INNER JOIN
    Users u ON b.user_id = u.id;

--- select all properties and their respective reviews
--- left join query
SELECT
    p.id AS property_id,
    p.name,
    p.location,
    r.id AS review_id,
    r.user_id,
    r.rating,
    r.comment
FROM
    Properties p
LEFT JOIN
    Reviews r ON p.id = r.property_id;

ORDER BY
    p.name DESC;


--- select all users and their respective bookings
--- full outer join query

SELECT
    u.id AS user_id,
    u.name,
    b.id AS booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM
    Users u
FULL OUTER JOIN
    Bookings b ON u.id = b.user_id;
