--1.Retrieve all bookings for a given user within a specified date range, including movie name, theatre, show time, and seats booked.

SELECT 
    u.user_name,
    m.movie_name,
    t.theatre_name,
    s.show_time,
    COUNT(se.seat_id) AS seats_booked
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN shows s ON b.show_id = s.show_id
JOIN movies m ON s.movie_id = m.movie_id
JOIN theatres t ON s.theatre_id = t.theatre_id
JOIN seats se ON b.booking_id = se.booking_id
WHERE u.user_id = 1
AND s.show_time BETWEEN '2026-04-01' AND '2026-04-30'
GROUP BY b.booking_id;


--2.Identify the most frequently booked movie along with total bookings count.

SELECT 
    m.movie_name,
    COUNT(b.booking_id) AS total_bookings
FROM bookings b
JOIN shows s ON b.show_id = s.show_id
JOIN movies m ON s.movie_id = m.movie_id
GROUP BY m.movie_id
ORDER BY total_bookings DESC
LIMIT 1;

--3.For a given theatre and date, list all shows along with total seats booked and available seats.
SELECT 
    s.show_id,
    m.movie_name,
    s.show_time,
    COUNT(se.seat_id) AS booked_seats,
    (s.total_seats - COUNT(se.seat_id)) AS available_seats
FROM shows s
JOIN movies m ON s.movie_id = m.movie_id
JOIN theatres t ON s.theatre_id = t.theatre_id
LEFT JOIN bookings b ON s.show_id = b.show_id
LEFT JOIN seats se ON b.booking_id = se.booking_id
WHERE t.theatre_id = 1
AND DATE(s.show_time) = '2026-04-30'
GROUP BY s.show_id;

--4.Write a transaction to handle a booking operation:
--Check seat availability for a show
--Insert booking record
--Insert associated seat records
--Update seat availability
--Ensure the operation fails safely if seats are not available

BEGIN TRANSACTION;
SELECT total_seats - COUNT(se.seat_id) AS available_seats
FROM shows s
LEFT JOIN bookings b ON s.show_id = b.show_id
LEFT JOIN seats se ON b.booking_id = se.booking_id
WHERE s.show_id = 1
GROUP BY s.show_id;

INSERT INTO bookings (booking_id, user_id, show_id, total_price, payment_status)
VALUES (101, 1, 1, 600, 'SUCCESS');

INSERT INTO seats (seat_id, seat_number, booking_id) VALUES (1, 'A1', 101);
INSERT INTO seats (seat_id, seat_number, booking_id) VALUES (2, 'A2', 101);
INSERT INTO seats (seat_id, seat_number, booking_id) VALUES (3, 'A3', 101);

COMMIT;


  
