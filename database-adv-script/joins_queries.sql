-- Retrievr bookings and the respective users who made bookings
-- ============INNER JOIN =================
SELECT booking_id, start_date, end_date, users.first_name
FROM booking
INNER JOIN users ON booking.user_id = users.id;


-- All properties and their reviews, including properties that have no reviews
-- ============= LEFT JOIN ================
SELECT property.name, review.rating
FROM property
LEFT JOIN review ON property.property_id = review.property_id
ORDER BY review.rating;

-- All users and all bookings even if the user has no booking 
-- ================FULL OUTER JOIN ================
SELECT users.first_name, users.last_name, booking.booking_id
FROM users
LEFT JOIN booking ON users.id = booking.user_id

UNION

SELECT users.first_name, users.last_name, booking.booking_id
FROM booking
RIGHT JOIN users ON users.id = booking.user_id;
