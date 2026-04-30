PRAGMA foreign_keys = ON;
CREATE TABLE Users (
   user_id INTEGER PRIMARY KEY AUTOINCREMENT,
   name TEXT NOT NULL,
   email TEXT UNIQUE NOT NULL,
   phone TEXT
);
CREATE TABLE Movies (
   movie_id INTEGER PRIMARY KEY AUTOINCREMENT,
   title TEXT NOT NULL,
   duration INTEGER,
   release_date DATE
);
CREATE TABLE MovieLanguages (
   movie_id INTEGER,
   language TEXT,
   PRIMARY KEY (movie_id, language),
   FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);
CREATE TABLE MovieGenres (
   movie_id INTEGER,
   genre TEXT,
   PRIMARY KEY (movie_id, genre),
   FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);
CREATE TABLE Cities (
   city_id INTEGER PRIMARY KEY AUTOINCREMENT,
   city_name TEXT NOT NULL
);
CREATE TABLE Theatres (
   theatre_id INTEGER PRIMARY KEY AUTOINCREMENT,
   theatre_name TEXT NOT NULL,
   city_id INTEGER,
   FOREIGN KEY (city_id) REFERENCES Cities(city_id)
);
CREATE TABLE Screens (
   screen_id INTEGER PRIMARY KEY AUTOINCREMENT,
   theatre_id INTEGER,
   screen_name TEXT,
   capacity INTEGER,
   FOREIGN KEY (theatre_id) REFERENCES Theatres(theatre_id)
);
CREATE TABLE Seats (
   seat_id INTEGER PRIMARY KEY AUTOINCREMENT,
   screen_id INTEGER,
   seat_number TEXT,
   seat_type TEXT,
   FOREIGN KEY (screen_id) REFERENCES Screens(screen_id)
);
CREATE TABLE Shows (
   show_id INTEGER PRIMARY KEY AUTOINCREMENT,
   movie_id INTEGER,
   screen_id INTEGER,
   show_date DATE,
   show_time TIME,
   FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
   FOREIGN KEY (screen_id) REFERENCES Screens(screen_id)
);
CREATE TABLE ShowPricing (
   pricing_id INTEGER PRIMARY KEY AUTOINCREMENT,
   show_id INTEGER,
   seat_type TEXT,
   price REAL,
   FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);
CREATE TABLE Bookings (
   booking_id INTEGER PRIMARY KEY AUTOINCREMENT,
   user_id INTEGER,
   show_id INTEGER,
   booking_time DATETIME DEFAULT CURRENT_TIMESTAMP,
   status TEXT,
   FOREIGN KEY (user_id) REFERENCES Users(user_id),
   FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);
CREATE TABLE BookingSeats (
   booking_id INTEGER,
   seat_id INTEGER,
   PRIMARY KEY (booking_id, seat_id),
   FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id),
   FOREIGN KEY (seat_id) REFERENCES Seats(seat_id)
);
CREATE TABLE Payments (
   payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
   booking_id INTEGER,
   amount REAL,
   payment_status TEXT,
   payment_method TEXT,
   payment_time DATETIME,
   FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);
