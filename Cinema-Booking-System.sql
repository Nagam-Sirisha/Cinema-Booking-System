USE siri;
CREATE DATABASE cinema_booking;
USE cinema_booking;


-- Movies table
CREATE TABLE Movies (
    MovieID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Genre VARCHAR(50),
    Duration INT -- in minutes
);

-- Theaters table
CREATE TABLE Theaters (
    TheaterID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100)
);

-- Showtimes table
CREATE TABLE Showtimes (
    ShowtimeID INT AUTO_INCREMENT PRIMARY KEY,
    MovieID INT,
    TheaterID INT,
    ShowDate DATE,
    ShowTime TIME,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (TheaterID) REFERENCES Theaters(TheaterID)
);

-- Seats table
CREATE TABLE Seats (
    SeatID INT AUTO_INCREMENT PRIMARY KEY,
    TheaterID INT,
    SeatNumber VARCHAR(10),
    IsBooked BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (TheaterID) REFERENCES Theaters(TheaterID)
);

-- Bookings table
CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    ShowtimeID INT,
    SeatID INT,
    CustomerName VARCHAR(100),
    BookingTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ShowtimeID) REFERENCES Showtimes(ShowtimeID),
    FOREIGN KEY (SeatID) REFERENCES Seats(SeatID)
);


-- Insert movies
INSERT INTO Movies (Title, Genre, Duration) VALUES
('Inception', 'Sci-Fi', 148),
('The Dark Knight', 'Action', 152);

-- Insert theaters
INSERT INTO Theaters (Name, Location) VALUES
('PVR Cinemas', 'Hyderabad'),
('INOX', 'Bangalore');

-- Insert showtimes
INSERT INTO Showtimes (MovieID, TheaterID, ShowDate, ShowTime) VALUES
(1, 1, '2025-04-15', '18:00:00'),
(2, 2, '2025-04-15', '20:00:00');

-- Insert seats
INSERT INTO Seats (TheaterID, SeatNumber) VALUES
(1, 'A1'), (1, 'A2'), (2, 'B1'), (2, 'B2');


SELECT s.SeatID, s.SeatNumber
FROM Seats s
JOIN Theaters t ON s.TheaterID = t.TheaterID
JOIN Showtimes st ON t.TheaterID = st.TheaterID
WHERE st.ShowtimeID = 1 AND s.IsBooked = FALSE;


-- Step 1: Mark seat as booked
UPDATE Seats SET IsBooked = TRUE WHERE SeatID = 1;

-- Step 2: Add entry in bookings
INSERT INTO Bookings (ShowtimeID, SeatID, CustomerName)
VALUES (1, 1, 'John Doe');

SELECT b.BookingID, m.Title, s.SeatNumber, b.CustomerName, b.BookingTime
FROM Bookings b
JOIN Showtimes st ON b.ShowtimeID = st.ShowtimeID
JOIN Movies m ON st.MovieID = m.MovieID
JOIN Seats s ON b.SeatID = s.SeatID;


