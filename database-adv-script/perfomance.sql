-- Initial Complex Query
-- Retrieves all bookings along with user details, property details, and payment details

-- This query joins multiple tables to get a comprehensive view of booking information
-- It includes User (guest) details, Property details, Host details, Payment information, and Review data
SELECT 
    b.BookingID,
    b.CheckInDate,
    b.CheckOutDate,
    b.TotalPrice,
    b.NumberOfGuests,
    b.BookingStatus,
    b.BookingDate,
    
    -- Guest Information
    g.UserID AS GuestID,
    g.FirstName AS GuestFirstName,
    g.LastName AS GuestLastName,
    g.Email AS GuestEmail,
    g.PhoneNumber AS GuestPhoneNumber,
    
    -- Property Information
    p.PropertyID,
    p.Title AS PropertyTitle,
    p.Description AS PropertyDescription,
    p.PropertyType,
    p.PricePerNight,
    p.NumberOfBedrooms,
    p.NumberOfBathrooms,
    p.MaxGuests,
    p.Status AS PropertyStatus,
    
    -- Host Information
    h.UserID AS HostID,
    h.FirstName AS HostFirstName,
    h.LastName AS HostLastName,
    h.Email AS HostEmail,
    h.PhoneNumber AS HostPhoneNumber,
    
    -- Address Information
    a.AddressID,
    a.StreetAddress,
    a.City,
    a.State,
    a.Country,
    a.PostalCode,
    
    -- Payment Information
    pay.PaymentID,
    pay.Amount AS PaymentAmount,
    pay.PaymentDate,
    pay.PaymentStatus,
    pay.PaymentMethod,
    
    -- Review Information (if available)
    r.ReviewID,
    r.Rating,
    r.Comment,
    r.ReviewDate
FROM 
    Booking b
JOIN 
    User g ON b.GuestID = g.UserID
JOIN 
    Property p ON b.PropertyID = p.PropertyID
JOIN 
    User h ON p.HostID = h.UserID
JOIN 
    Address a ON p.AddressID = a.AddressID
LEFT JOIN 
    Payment pay ON b.BookingID = pay.BookingID
LEFT JOIN 
    Review r ON b.BookingID = r.BookingID
WHERE 
    b.BookingDate >= '2024-01-01'
ORDER BY 
    b.BookingDate DESC, p.PricePerNight DESC;

-- EXPLAIN ANALYZE for the initial query
EXPLAIN
SELECT 
    b.BookingID,
    b.CheckInDate,
    b.CheckOutDate,
    b.TotalPrice,
    b.NumberOfGuests,
    b.BookingStatus,
    b.BookingDate,
    g.UserID AS GuestID,
    g.FirstName AS GuestFirstName,
    g.LastName AS GuestLastName,
    g.Email AS GuestEmail,
    g.PhoneNumber AS GuestPhoneNumber,
    p.PropertyID,
    p.Title AS PropertyTitle,
    p.Description AS PropertyDescription,
    p.PropertyType,
    p.PricePerNight,
    p.NumberOfBedrooms,
    p.NumberOfBathrooms,
    p.MaxGuests,
    p.Status AS PropertyStatus,
    h.UserID AS HostID,
    h.FirstName AS HostFirstName,
    h.LastName AS HostLastName,
    h.Email AS HostEmail,
    h.PhoneNumber AS HostPhoneNumber,
    a.AddressID,
    a.StreetAddress,
    a.City,
    a.State,
    a.Country,
    a.PostalCode,
    pay.PaymentID,
    pay.Amount AS PaymentAmount,
    pay.PaymentDate,
    pay.PaymentStatus,
    pay.PaymentMethod,
    r.ReviewID,
    r.Rating,
    r.Comment,
    r.ReviewDate
FROM 
    Booking b
JOIN 
    User g ON b.GuestID = g.UserID
JOIN 
    Property p ON b.PropertyID = p.PropertyID
JOIN 
    User h ON p.HostID = h.UserID
JOIN 
    Address a ON p.AddressID = a.AddressID
LEFT JOIN 
    Payment pay ON b.BookingID = pay.BookingID
LEFT JOIN 
    Review r ON b.BookingID = r.BookingID
WHERE 
    b.BookingDate >= '2024-01-01'
ORDER BY 
    b.BookingDate DESC, p.PricePerNight DESC;

-- Query with Multiple AND Conditions
-- This query demonstrates the use of multiple filtering conditions that can benefit from indexes

EXPLAIN ANALYZE
SELECT 
    b.BookingID,
    b.CheckInDate,
    b.CheckOutDate,
    b.TotalPrice,
    b.NumberOfGuests,
    b.BookingStatus,
    b.BookingDate,
    
    -- Guest Information
    g.UserID AS GuestID,
    g.FirstName AS GuestFirstName,
    g.LastName AS GuestLastName,
    g.Email AS GuestEmail,
    
    -- Property Information
    p.PropertyID,
    p.Title AS PropertyTitle,
    p.PropertyType,
    p.PricePerNight,
    p.NumberOfBedrooms,
    
    -- Payment Information
    pay.PaymentID,
    pay.Amount AS PaymentAmount,
    pay.PaymentDate,
    pay.PaymentStatus
FROM 
    Booking b
JOIN 
    User g ON b.GuestID = g.UserID
JOIN 
    Property p ON b.PropertyID = p.PropertyID
JOIN 
    Address a ON p.AddressID = a.AddressID
LEFT JOIN 
    Payment pay ON b.BookingID = pay.BookingID
WHERE 
    b.BookingDate >= '2024-01-01' AND
    b.BookingStatus = 'Confirmed' AND
    p.PropertyType = 'Apartment' AND
    p.PricePerNight BETWEEN 100 AND 300 AND
    a.City = 'New York' AND
    pay.PaymentStatus = 'Completed'
ORDER BY 
    b.BookingDate DESC;

-- Optimized Query
-- This query has been refactored to improve performance

-- 1. Reduced number of columns to only those needed
-- 2. Used indexed columns in joins and WHERE clauses
-- 3. Added appropriate indexing (assuming indexes from database_index.sql are applied)
-- 4. Used subqueries for related data that isn't always needed
-- 5. Limited the result set size with pagination

SELECT 
    b.BookingID,
    b.CheckInDate,
    b.CheckOutDate,
    b.TotalPrice,
    b.BookingStatus,
    
    -- Guest Information (limited columns)
    g.UserID AS GuestID,
    g.FirstName AS GuestFirstName,
    g.LastName AS GuestLastName,
    
    -- Property Information (limited columns)
    p.PropertyID,
    p.Title AS PropertyTitle,
    p.PropertyType,
    p.PricePerNight,
    
    -- Payment Information (using subquery to avoid join when not needed)
    (SELECT PaymentStatus FROM Payment WHERE BookingID = b.BookingID LIMIT 1) AS PaymentStatus
FROM 
    Booking b
JOIN 
    User g ON b.GuestID = g.UserID
JOIN 
    Property p ON b.PropertyID = p.PropertyID
WHERE 
    b.BookingDate >= '2024-01-01'
ORDER BY 
    b.BookingDate DESC, p.PricePerNight DESC
LIMIT 100;  -- Added pagination

-- EXPLAIN ANALYZE for the optimized query
EXPLAIN
SELECT 
    b.BookingID,
    b.CheckInDate,
    b.CheckOutDate,
    b.TotalPrice,
    b.BookingStatus,
    g.UserID AS GuestID,
    g.FirstName AS GuestFirstName,
    g.LastName AS GuestLastName,
    p.PropertyID,
    p.Title AS PropertyTitle,
    p.PropertyType,
    p.PricePerNight,
    (SELECT PaymentStatus FROM Payment WHERE BookingID = b.BookingID LIMIT 1) AS PaymentStatus
FROM 
    Booking b
JOIN 
    User g ON b.GuestID = g.UserID
JOIN 
    Property p ON b.PropertyID = p.PropertyID
WHERE 
    b.BookingDate >= '2024-01-01'
ORDER BY 
    b.BookingDate DESC, p.PricePerNight DESC
LIMIT 100;
