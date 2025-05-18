-- Database Indexes for Optimization
-- This file contains CREATE INDEX commands for high-usage columns in the Airbnb database

-- Performance Measurement Section
-- First, let's measure the performance of some common queries BEFORE adding indexes

-- Measure performance of user lookup by email
EXPLAIN ANALYZE SELECT * FROM User WHERE Email = 'example@email.com';

-- Measure performance of property search by location and price
EXPLAIN ANALYZE SELECT * FROM Property WHERE City = 'New York' AND PricePerNight BETWEEN 100 AND 300;

-- Measure performance of booking search by date range
EXPLAIN ANALYZE SELECT p.*, b.CheckInDate, b.CheckOutDate 
FROM Property p 
JOIN Booking b ON p.PropertyID = b.PropertyID 
WHERE b.CheckInDate >= '2023-01-01' AND b.CheckOutDate <= '2023-12-31';

-- Measure performance of finding top-rated properties
EXPLAIN ANALYZE SELECT p.*, AVG(r.Rating) as AvgRating 
FROM Property p 
JOIN Booking b ON p.PropertyID = b.PropertyID 
JOIN Review r ON b.BookingID = r.BookingID 
GROUP BY p.PropertyID 
ORDER BY AvgRating DESC 
LIMIT 10;

-- User Table Indexes
-- Index on Email (used in login queries and uniqueness checks)
CREATE INDEX idx_user_email ON User(Email);

-- Index on UserType (used to filter hosts vs guests)
CREATE INDEX idx_user_type ON User(UserType);

-- Property Table Indexes
-- Index on HostID (used in JOIN operations and filtering properties by host)
CREATE INDEX idx_property_host ON Property(HostID);

-- Index on PropertyType (used in filtering and searching)
CREATE INDEX idx_property_type ON Property(PropertyType);

-- Composite index on location-related columns (used in location-based searches)
CREATE INDEX idx_property_location ON Property(City, State, Country);

-- Index on PricePerNight (used in filtering, sorting, and range queries)
CREATE INDEX idx_property_price ON Property(PricePerNight);

-- Index on Status (used to filter available properties)
CREATE INDEX idx_property_status ON Property(Status);

-- Booking Table Indexes
-- Index on PropertyID (used in JOIN operations and property booking history)
CREATE INDEX idx_booking_property ON Booking(PropertyID);

-- Index on GuestID (used in JOIN operations and user booking history)
CREATE INDEX idx_booking_guest ON Booking(GuestID);

-- Index on BookingStatus (used to filter bookings by status)
CREATE INDEX idx_booking_status ON Booking(BookingStatus);

-- Composite index on CheckInDate and CheckOutDate (used in availability searches)
CREATE INDEX idx_booking_dates ON Booking(CheckInDate, CheckOutDate);

-- Review Table Indexes
-- Index on BookingID (used in JOIN operations)
CREATE INDEX idx_review_booking ON Review(BookingID);

-- Index on Rating (used in filtering and sorting by rating)
CREATE INDEX idx_review_rating ON Review(Rating);

-- Payment Table Indexes
-- Index on BookingID (used in JOIN operations)
CREATE INDEX idx_payment_booking ON Payment(BookingID);

-- Index on PaymentStatus (used in filtering payments by status)
CREATE INDEX idx_payment_status ON Payment(PaymentStatus);

-- Index on PaymentDate (used in date range queries and reporting)
CREATE INDEX idx_payment_date ON Payment(PaymentDate);
