PRAGMA foreign_keys = ON;


CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY,
    user_name TEXT NOT NULL,
    user_email TEXT UNIQUE
);


CREATE TABLE Movies (
    movie_id INTEGER PRIMARY KEY,
    movie_name TEXT NOT NULL
);


CREATE TABLE Theatres (
    theatre_id INTEGER PRIMARY KEY,
    theatre_name TEXT NOT NULL,
    theatre_location TEXT NOT NULL
);


CREATE TABLE Shows (
    show_id INTEGER PRIMARY KEY,
    movie_id INTEGER,
    theatre_id INTEGER,
    show_time TEXT,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (theatre_id) REFERENCES Theatres(theatre_id)
);

CREATE TABLE Bookings (
    booking_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    show_id INTEGER,
    total_price REAL,
    payment_status TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);


CREATE TABLE Seats (
    seat_id INTEGER PRIMARY KEY,
    seat_number TEXT,
    booking_id INTEGER,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);
