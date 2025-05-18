-- 1. Non-correlated subquery to find all properties where the average rating is greater than 4.0
SELECT 
    p.PropertyID,
    p.Title,
    p.PropertyType,
    p.PricePerNight,
    (SELECT AVG(r.Rating) 
     FROM Review r 
     JOIN Booking b ON r.BookingID = b.BookingID 
     WHERE b.PropertyID = p.PropertyID) AS AverageRating
FROM 
    Property p
WHERE 
    (SELECT AVG(r.Rating) 
     FROM Review r 
     JOIN Booking b ON r.BookingID = b.BookingID 
     WHERE b.PropertyID = p.PropertyID) > 4.0
ORDER BY 
    AverageRating DESC;

-- Alternative non-correlated subquery approach using WITH clause for better readability
WITH PropertyRatings AS (
    SELECT 
        b.PropertyID,
        AVG(r.Rating) AS AverageRating
    FROM 
        Review r
    JOIN 
        Booking b ON r.BookingID = b.BookingID
    GROUP BY 
        b.PropertyID
    HAVING 
        AVG(r.Rating) > 4.0
)
SELECT 
    p.PropertyID,
    p.Title,
    p.PropertyType,
    p.PricePerNight,
    pr.AverageRating
FROM 
    Property p
JOIN 
    PropertyRatings pr ON p.PropertyID = pr.PropertyID
ORDER BY 
    pr.AverageRating DESC;

-- 2. Correlated subquery to find users who have made more than 3 bookings
SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    u.Email,
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.GuestID = u.UserID) AS BookingCount
FROM 
    User u
WHERE 
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.GuestID = u.UserID) > 3
ORDER BY 
    BookingCount DESC;

-- Alternative approach using GROUP BY instead of a correlated subquery
-- This is often more efficient but included for comparison
SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    u.Email,
    COUNT(b.BookingID) AS BookingCount
FROM 
    User u
JOIN 
    Booking b ON u.UserID = b.GuestID
GROUP BY 
    u.UserID, u.FirstName, u.LastName, u.Email
HAVING 
    COUNT(b.BookingID) > 3
ORDER BY 
    BookingCount DESC;
