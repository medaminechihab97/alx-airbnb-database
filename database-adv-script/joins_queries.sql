-- 1. INNER JOIN query to retrieve all bookings and the respective users who made those bookings
SELECT 
    b.BookingID,
    b.CheckInDate,
    b.CheckOutDate,
    b.TotalPrice,
    b.NumberOfGuests,
    b.BookingStatus,
    u.UserID,
    u.FirstName,
    u.LastName,
    u.Email
FROM 
    Booking b
INNER JOIN 
    User u ON b.GuestID = u.UserID
ORDER BY 
    b.BookingDate DESC;

-- 2. LEFT JOIN query to retrieve all properties and their reviews, including properties that have no reviews
SELECT 
    p.PropertyID,
    p.Title,
    p.PropertyType,
    p.PricePerNight,
    r.ReviewID,
    r.Rating,
    r.Comment,
    r.ReviewDate
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.PropertyID = b.PropertyID
LEFT JOIN 
    Review r ON b.BookingID = r.BookingID
ORDER BY 
    p.PropertyID, r.ReviewDate DESC;

-- 3. FULL OUTER JOIN query to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
-- Note: MySQL doesn't support FULL OUTER JOIN directly, so we use UNION of LEFT JOIN and RIGHT JOIN
-- For PostgreSQL or SQL Server, you could use FULL OUTER JOIN directly

-- MySQL version:
SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    u.Email,
    b.BookingID,
    b.CheckInDate,
    b.CheckOutDate,
    b.TotalPrice,
    b.BookingStatus
FROM 
    User u
LEFT JOIN 
    Booking b ON u.UserID = b.GuestID

UNION

SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    u.Email,
    b.BookingID,
    b.CheckInDate,
    b.CheckOutDate,
    b.TotalPrice,
    b.BookingStatus
FROM 
    User u
RIGHT JOIN 
    Booking b ON u.UserID = b.GuestID
WHERE 
    u.UserID IS NULL
ORDER BY 
    UserID, BookingID;

