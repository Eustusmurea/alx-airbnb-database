--- Subqury to find properties with +4 ratings
--- non correlated subquery outer query selects properties while subquery selects property_id from reviews table
-- --- where the average rating is greater than 4.0
-- --- this query will return all properties that have an average rating greater than 4.0
SELECT *
FROM properties
WHERE property_id IN (
    SELECT property_id
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

--- Subquery to find users with more than 3 bookings
--- non correlated subquery outer query selects users while subquery counts bookings for each user

SELECT u.user_id, u.name, u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3;

