SELECT 
    u.user_name,
    m.movie_name,
    t.theatre_name,
    s.show_time,
    COUNT(se.seat_id) AS seats_booked
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Shows s ON b.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id
JOIN Theatres t ON s.theatre_id = t.theatre_id
JOIN Seats se ON b.booking_id = se.booking_id
WHERE b.user_id = 1   -- given user_id
AND s.show_time BETWEEN '2026-04-01' AND '2026-04-30'
GROUP BY b.booking_id, u.user_name, m.movie_name, t.theatre_name, s.show_time;
SELECT 
    m.movie_name,
    COUNT(b.booking_id) AS total_bookings
FROM Bookings b
JOIN Shows s ON b.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id
GROUP BY m.movie_name
ORDER BY total_bookings DESC
LIMIT 1;
SELECT 
    s.show_id,
    m.movie_name,
    s.show_time,
    COUNT(se.seat_id) AS booked_seats,
    (100 - COUNT(se.seat_id)) AS available_seats
FROM Shows s
JOIN Movies m ON s.movie_id = m.movie_id
LEFT JOIN Bookings b ON s.show_id = b.show_id
LEFT JOIN Seats se ON b.booking_id = se.booking_id
WHERE s.theatre_id = 1
AND DATE(s.show_time) = '2026-04-29'
GROUP BY s.show_id, m.movie_name, s.show_time;
START TRANSACTION;


SELECT (100 - COUNT(se.seat_id)) INTO @available_seats
FROM Shows s
LEFT JOIN Bookings b ON s.show_id = b.show_id
LEFT JOIN Seats se ON b.booking_id = se.booking_id
WHERE s.show_id = 1;


IF @available_seats >= 3 THEN   

   
    INSERT INTO Bookings (user_id, show_id, total_price, payment_status)
    VALUES (1, 1, 600, 'SUCCESS');

   
    SET @Booking_id = LAST_INSERT_ID();

    INSERT INTO Seats (seat_number, booking_id) VALUES
    ('A1', @booking_id),
    ('A2', @booking_id),
    ('A3', @booking_id);

 
    COMMIT;

ELSE
    
    ROLLBACK;
END IF;
