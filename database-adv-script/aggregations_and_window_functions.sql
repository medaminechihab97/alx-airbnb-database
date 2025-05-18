-- 1. Query to find the total number of bookings made by each user
-- Using COUNT function and GROUP BY clause
SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    u.Email,
    COUNT(b.BookingID) AS TotalBookings
FROM 
    User u
LEFT JOIN 
    Booking b ON u.UserID = b.GuestID
GROUP BY 
    u.UserID, u.FirstName, u.LastName, u.Email
ORDER BY 
    TotalBookings DESC;

-- 2. Window function to rank properties based on the total number of bookings they have received
-- Using ROW_NUMBER() window function
SELECT 
    p.PropertyID,
    p.Title,
    p.PropertyType,
    p.PricePerNight,
    COUNT(b.BookingID) AS TotalBookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.BookingID) DESC) AS BookingRank
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.PropertyID = b.PropertyID
GROUP BY 
    p.PropertyID, p.Title, p.PropertyType, p.PricePerNight
ORDER BY 
    TotalBookings DESC;

-- Alternative ranking using RANK() window function
-- This will give the same rank to properties with equal number of bookings
SELECT 
    p.PropertyID,
    p.Title,
    p.PropertyType,
    p.PricePerNight,
    COUNT(b.BookingID) AS TotalBookings,
    RANK() OVER (ORDER BY COUNT(b.BookingID) DESC) AS BookingRank
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.PropertyID = b.PropertyID
GROUP BY 
    p.PropertyID, p.Title, p.PropertyType, p.PricePerNight
ORDER BY 
    TotalBookings DESC;

-- Additional example: Using DENSE_RANK() window function
-- Similar to RANK() but without gaps in the ranking values
SELECT 
    p.PropertyID,
    p.Title,
    p.PropertyType,
    p.PricePerNight,
    COUNT(b.BookingID) AS TotalBookings,
    DENSE_RANK() OVER (ORDER BY COUNT(b.BookingID) DESC) AS BookingRank
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.PropertyID = b.PropertyID
GROUP BY 
    p.PropertyID, p.Title, p.PropertyType, p.PricePerNight
ORDER BY 
    TotalBookings DESC;

-- Bonus: Ranking properties by average rating using window functions
SELECT 
    p.PropertyID,
    p.Title,
    p.PropertyType,
    p.PricePerNight,
    AVG(r.Rating) AS AverageRating,
    COUNT(r.ReviewID) AS TotalReviews,
    RANK() OVER (ORDER BY AVG(r.Rating) DESC) AS RatingRank
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.PropertyID = b.PropertyID
LEFT JOIN 
    Review r ON b.BookingID = r.BookingID
GROUP BY 
    p.PropertyID, p.Title, p.PropertyType, p.PricePerNight
HAVING 
    COUNT(r.ReviewID) > 0  -- Only include properties with at least one review
ORDER BY 
    AverageRating DESC, TotalReviews DESC;
