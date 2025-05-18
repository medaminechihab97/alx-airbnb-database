-- Table Partitioning for Booking Table
-- This script implements partitioning on the Booking table based on CheckInDate

-- 1. First, create a backup of the existing Booking table
CREATE TABLE Booking_Backup AS SELECT * FROM Booking;

-- 2. Drop the existing Booking table
DROP TABLE IF EXISTS Booking;

-- 3. Create a new partitioned Booking table
-- Note: Using RANGE partitioning based on the CheckInDate column
CREATE TABLE Booking (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT NOT NULL,
    GuestID INT NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    NumberOfGuests INT NOT NULL,
    BookingStatus VARCHAR(20) NOT NULL,
    BookingDate TIMESTAMP NOT NULL,
    
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID),
    FOREIGN KEY (GuestID) REFERENCES User(UserID)
) 
PARTITION BY RANGE (YEAR(CheckInDate)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p2027 VALUES LESS THAN (2028),
    PARTITION pFuture VALUES LESS THAN MAXVALUE
);

-- 4. Restore data from the backup table
INSERT INTO Booking SELECT * FROM Booking_Backup;

-- 5. Create indexes on the partitioned table
CREATE INDEX idx_booking_checkin_date ON Booking(CheckInDate);
CREATE INDEX idx_booking_property ON Booking(PropertyID);
CREATE INDEX idx_booking_guest ON Booking(GuestID);
CREATE INDEX idx_booking_status ON Booking(BookingStatus);

-- 6. Test queries to demonstrate performance improvements

-- Query 1: Find all bookings for a specific date range (uses partitioning)
-- This query will benefit from partitioning as it only needs to scan relevant partitions
EXPLAIN
SELECT 
    b.BookingID,
    b.PropertyID,
    b.GuestID,
    b.CheckInDate,
    b.CheckOutDate,
    b.TotalPrice,
    b.BookingStatus
FROM 
    Booking b
WHERE 
    b.CheckInDate BETWEEN '2024-01-01' AND '2024-12-31';

-- Query 2: Find all bookings for a specific property in a date range
-- This query combines partitioning with regular indexing
EXPLAIN
SELECT 
    b.BookingID,
    b.CheckInDate,
    b.CheckOutDate,
    b.TotalPrice,
    b.BookingStatus,
    u.FirstName AS GuestFirstName,
    u.LastName AS GuestLastName
FROM 
    Booking b
JOIN 
    User u ON b.GuestID = u.UserID
WHERE 
    b.PropertyID = 123
    AND b.CheckInDate BETWEEN '2024-06-01' AND '2024-08-31';

-- Query 3: Count bookings by year (demonstrates partition pruning)
-- This query will be very efficient as it can directly access the relevant partition
EXPLAIN
SELECT 
    YEAR(CheckInDate) AS BookingYear,
    COUNT(*) AS TotalBookings,
    SUM(TotalPrice) AS TotalRevenue
FROM 
    Booking
WHERE 
    CheckInDate BETWEEN '2024-01-01' AND '2025-12-31'
GROUP BY 
    YEAR(CheckInDate);

-- Alternative Partitioning Approach: RANGE COLUMNS
-- This is an alternative approach that doesn't require a function in the partition key
/*
CREATE TABLE Booking (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT NOT NULL,
    GuestID INT NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    NumberOfGuests INT NOT NULL,
    BookingStatus VARCHAR(20) NOT NULL,
    BookingDate TIMESTAMP NOT NULL,
    
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID),
    FOREIGN KEY (GuestID) REFERENCES User(UserID)
) 
PARTITION BY RANGE COLUMNS(CheckInDate) (
    PARTITION p2023 VALUES LESS THAN ('2024-01-01'),
    PARTITION p2024 VALUES LESS THAN ('2025-01-01'),
    PARTITION p2025 VALUES LESS THAN ('2026-01-01'),
    PARTITION p2026 VALUES LESS THAN ('2027-01-01'),
    PARTITION p2027 VALUES LESS THAN ('2028-01-01'),
    PARTITION pFuture VALUES LESS THAN MAXVALUE
);
*/

-- Alternative Partitioning Approach: LIST partitioning by season
-- This approach partitions by season, which can be useful for seasonal businesses
/*
CREATE TABLE Booking (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT NOT NULL,
    GuestID INT NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    NumberOfGuests INT NOT NULL,
    BookingStatus VARCHAR(20) NOT NULL,
    BookingDate TIMESTAMP NOT NULL,
    Season VARCHAR(10) GENERATED ALWAYS AS (
        CASE
            WHEN MONTH(CheckInDate) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(CheckInDate) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(CheckInDate) IN (6, 7, 8) THEN 'Summer'
            ELSE 'Fall'
        END
    ) STORED,
    
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID),
    FOREIGN KEY (GuestID) REFERENCES User(UserID)
) 
PARTITION BY LIST COLUMNS(Season) (
    PARTITION pWinter VALUES IN ('Winter'),
    PARTITION pSpring VALUES IN ('Spring'),
    PARTITION pSummer VALUES IN ('Summer'),
    PARTITION pFall VALUES IN ('Fall')
);
*/
