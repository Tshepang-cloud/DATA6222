-- Create the database
CREATE DATABASE DEBATES;
USE DEBATES;

-- Create the Faculty table
CREATE TABLE Faculty (
    FacultyID VARCHAR(10) PRIMARY KEY,
    FacultyName VARCHAR(100) NOT NULL
);

-- Create the Venue table
CREATE TABLE Venue (
    VenueID VARCHAR(10) PRIMARY KEY,
    VenueName VARCHAR(100) NOT NULL,
    VenueAddress VARCHAR(255) NOT NULL
);

-- Create the Debate table
CREATE TABLE Debate (
    DebateID VARCHAR(10) PRIMARY KEY,
    FacultyID_A VARCHAR(10),
    FacultyID_B VARCHAR(10),
    VenueID VARCHAR(10),
    DebateDate DATE,
    DebateTime TIME,
    DebateDuration INT,
    -- Foreign key constraints linking back to Faculty and Venue
    CONSTRAINT fk_debate_faculty_a FOREIGN KEY (FacultyID_A) REFERENCES Faculty(FacultyID),
    CONSTRAINT fk_debate_faculty_b FOREIGN KEY (FacultyID_B) REFERENCES Faculty(FacultyID),
    CONSTRAINT fk_debate_venue FOREIGN KEY (VenueID) REFERENCES Venue(VenueID)
);
-- Insert data into Faculty
INSERT INTO Faculty (FacultyID, FacultyName) VALUES
('F001', 'Faculty of Science'),
('F002', 'Faculty of Engineering'),
('F003', 'Faculty of Humanities'),
('F004', 'Faculty of Law'),
('F005', 'Faculty of Commerce');

-- Insert data into Venue
INSERT INTO Venue (VenueID, VenueName, VenueAddress) VALUES
('V001', 'Newton Hall', '12 University Road, Cape Town'),
('V002', 'Curie Centre', '44 Innovation Avenue, Gqeberha'),
('V003', 'Plato Auditorium', '88 Knowledge Street, Durban'),
('V004', 'Darwin Hall', '15 Research Lane, Johannesburg'),
('V005', 'Aristotle Theatre', '9 Academic Crescent, Tshwane');

-- Insert data into Debate
INSERT INTO Debate (DebateID, FacultyID_A, FacultyID_B, VenueID, DebateDate, DebateTime, DebateDuration) VALUES
('D001', 'F001', 'F002', 'V001', '2026-08-10', '10:00:00', 60),
('D002', 'F003', 'F005', 'V004', '2026-08-11', '14:00:00', 90),
('D003', 'F002', 'F003', 'V005', '2026-08-12', '18:00:00', 90),
('D004', 'F001', 'F005', 'V003', '2026-08-13', '16:00:00', 120),
('D005', 'F002', 'F005', 'V001', '2026-08-14', '17:00:00', 120);

ALTER TABLE Debate
ADD SeatsAvailable INT;

UPDATE Debate
SET SeatsAvailable = 400
WHERE DebateID = 'D003';

-- Solution using LEFT JOIN
SELECT V.VenueName
FROM Venue V
LEFT JOIN Debate D ON V.VenueID = D.VenueID
WHERE D.DebateID IS NULL;

-- Alternative Solution using NOT IN
SELECT VenueName
FROM Venue
WHERE VenueID NOT IN (SELECT VenueID FROM Debate);

SELECT V.VenueName, SUM(D.DebateDuration) AS "TOTAL DURATION"
FROM Venue V
LEFT JOIN Debate D ON V.VenueID = D.VenueID
GROUP BY V.VenueName
ORDER BY V.VenueName ASC;

SELECT TOP 1 V.VenueName, D.DebateDate, D.DebateDuration
FROM Venue V
JOIN Debate D ON V.VenueID = D.VenueID
WHERE D.VenueID = 'V001'
ORDER BY D.DebateDuration DESC;
