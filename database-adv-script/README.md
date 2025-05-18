# Advanced SQL Queries

This directory contains SQL scripts demonstrating advanced database operations for an Airbnb-like database system.

## Joins Queries (joins_queries.sql)

The `joins_queries.sql` file contains three complex SQL queries demonstrating different types of joins:

### 1. INNER JOIN

Retrieves all bookings and the respective users who made those bookings. This query joins the `Booking` and `User` tables where the `GuestID` in the Booking table matches the `UserID` in the User table.

```sql
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
```

### 2. LEFT JOIN

Retrieves all properties and their reviews, including properties that have no reviews. This query uses two LEFT JOINs to connect the `Property`, `Booking`, and `Review` tables, ensuring that all properties are included even if they have no bookings or reviews.

```sql
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
```

### 3. FULL OUTER JOIN

Retrieves all users and all bookings, even if the user has no booking or a booking is not linked to a user. Since MySQL doesn't directly support FULL OUTER JOIN, this is implemented using a UNION of LEFT JOIN and RIGHT JOIN. For PostgreSQL or SQL Server, a direct FULL OUTER JOIN implementation is also provided (commented out).

```sql
-- MySQL version
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
```

## Subqueries (subqueries.sql)

The `subqueries.sql` file contains SQL queries demonstrating both correlated and non-correlated subqueries:

### 1. Non-correlated Subquery

Finds all properties where the average rating is greater than 4.0. This query uses a subquery to calculate the average rating for each property.

```sql
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
```

An alternative approach using a WITH clause for better readability is also provided.

### 2. Correlated Subquery

Finds users who have made more than 3 bookings. This query uses a correlated subquery where the inner query references the outer query's table.

```sql
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
```

An alternative approach using GROUP BY instead of a correlated subquery is also provided for comparison.

## Aggregations and Window Functions (aggregations_and_window_functions.sql)

The `aggregations_and_window_functions.sql` file contains SQL queries demonstrating the use of aggregation functions and window functions for data analysis:

### 1. Aggregation with COUNT and GROUP BY

Finds the total number of bookings made by each user using the COUNT function and GROUP BY clause.

```sql
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
```

### 2. Window Functions for Ranking

Ranks properties based on the total number of bookings they have received using the ROW_NUMBER() window function.

```sql
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
```

Alternative ranking examples using RANK() and DENSE_RANK() window functions are also provided to demonstrate different ranking behaviors:

- RANK(): Gives the same rank to properties with equal bookings, leaving gaps in the ranking sequence
- DENSE_RANK(): Similar to RANK() but without gaps in the ranking values

A bonus query is included that ranks properties by their average rating, demonstrating how window functions can be combined with other aggregations.

## Database Schema

These queries are based on the normalized database schema (3NF) for the Airbnb-like application, which includes the following main tables:

- **User**: Contains user information (hosts and guests)
- **Property**: Contains property listings information
- **Booking**: Contains booking records linking guests to properties
- **Review**: Contains reviews left by guests after bookings
- **Payment**: Contains payment information for bookings