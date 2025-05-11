-- ALX AirBnB Database Seed Data
-- seed.sql

-- Disable foreign key constraints temporarily (for easier seeding)
PRAGMA foreign_keys = OFF;

-- Clear existing data
DELETE FROM Payment;
DELETE FROM Review;
DELETE FROM Booking;
DELETE FROM PropertyAmenityMapping;
DELETE FROM PropertyAvailability;
DELETE FROM Property;
DELETE FROM Address;
DELETE FROM User;
-- Don't delete from PropertyAmenity since we want to keep the standard amenities

-- Reset auto-increment counters
DELETE FROM sqlite_sequence WHERE name IN ('User', 'Address', 'Property', 'PropertyAvailability', 'Booking', 'Review', 'Payment', 'PropertyAmenityMapping');

-- Enable foreign key constraints
PRAGMA foreign_keys = ON;

-- Seed Users (mixture of hosts and guests)
INSERT INTO User (UserID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined, ProfilePicture, UserType) VALUES
-- Hosts
(1, 'John', 'Smith', 'john.smith@example.com', '$2a$10$1QUhRZoEs3LK9VN6QTpGieG7UrL5LrJXEtEzFKUA9CaNJW4vKeQhy', '+1-555-123-4567', '2023-01-15 08:30:00', 'profile1.jpg', 'Host'),
(2, 'Maria', 'Garcia', 'maria.garcia@example.com', '$2a$10$bE7Ny2LFYSEfVrGLFX9xR.BeTY1ES3C8WzEJ3by5UdgEp0jUBvzIi', '+1-555-234-5678', '2023-02-20 14:45:00', 'profile2.jpg', 'Host'),
(3, 'Ahmed', 'Hassan', 'ahmed.hassan@example.com', '$2a$10$pE7QOQrcL5LK4WrGG5ZTZ.qWGBDFZLtRJLg.1oUGu4HCsdS2iL3W2', '+20-100-123-4567', '2023-03-10 11:20:00', 'profile3.jpg', 'Host'),
(4, 'Sophie', 'Dubois', 'sophie.dubois@example.com', '$2a$10$KLjUm4UEBpV0H0P5DmMiZO5Tb2V2p4I96D8OJ2N9WsaNFBqZ3SdLO', '+33-6-12-34-56-78', '2023-01-30 09:15:00', 'profile4.jpg', 'Host'),
(5, 'Hiroshi', 'Tanaka', 'hiroshi.tanaka@example.com', '$2a$10$FdRrGkbMOk3PXnKJUaOgJ.wLWn2mNLFrKQxktUkVn.bDGpPEDqI4C', '+81-3-1234-5678', '2023-02-05 17:30:00', 'profile5.jpg', 'Host'),

-- Guests
(6, 'Emma', 'Johnson', 'emma.johnson@example.com', '$2a$10$TxUIf0S5OsVVDSh.rTSsD.QJ9TL/R.DGtdLVVIIVPUTEQTrSvO8uu', '+1-555-345-6789', '2023-03-05 10:00:00', 'profile6.jpg', 'Guest'),
(7, 'Carlos', 'Rodriguez', 'carlos.rodriguez@example.com', '$2a$10$IefgRrNfTa76pWu0BdGkv.bFx1I2tFHeFRQrArFCm58kUFuJLpgsW', '+34-612-345-678', '2023-02-10 13:20:00', 'profile7.jpg', 'Guest'),
(8, 'Anna', 'Kowalski', 'anna.kowalski@example.com', '$2a$10$ERGWoqLj7TtSiW7Z4h3WqONh4QP3QpnouLMdnGmgN3NJzMirGmv7.', '+48-512-345-678', '2023-01-25 16:45:00', 'profile8.jpg', 'Guest'),
(9, 'Omar', 'Farooq', 'omar.farooq@example.com', '$2a$10$mH/rKjrDOAPV06mO9QdTIeEK12u0cRVgDrZ.HdJLHPO6QiuOxmQSy', '+971-50-123-4567', '2023-03-15 08:10:00', 'profile9.jpg', 'Guest'),
(10, 'Priya', 'Patel', 'priya.patel@example.com', '$2a$10$JjjfPGH2L7zx0OKQTJUzxO.oHX.PWUQi0UGKpyRFzO1kDGcVcM86O', '+91-98765-43210', '2023-02-28 12:30:00', 'profile10.jpg', 'Guest'),
(11, 'David', 'Wilson', 'david.wilson@example.com', '$2a$10$LELUSMdkG0C.IpNnhMLxdOb7PANcIRahE8ilzpRh9KtLsL75VsVKG', '+1-555-456-7890', '2023-01-20 14:15:00', 'profile11.jpg', 'Guest'),
(12, 'Luisa', 'Fernandez', 'luisa.fernandez@example.com', '$2a$10$LELUSMdkG0C.IpNnhMLxdOb7PANcIRahE8ilzpRh9KtLsL75VsVKG', '+34-623-456-789', '2023-03-22 09:45:00', 'profile12.jpg', 'Guest'),
(13, 'Wei', 'Chen', 'wei.chen@example.com', '$2a$10$dP2GNSUi7U9YpMjQ6/QGGeq61Xg4e5LFdRgBEQ1cDo8aHEEqzm4by', '+86-131-2345-6789', '2023-02-15 11:25:00', 'profile13.jpg', 'Guest'),
(14, 'Sarah', 'Thompson', 'sarah.thompson@example.com', '$2a$10$qGSMmv1WS4uL5Lv/nAj76uEiXrQTGADwhKu4jUJbiUEOykJr5xLOS', '+1-555-567-8901', '2023-03-01 15:50:00', 'profile14.jpg', 'Guest'),
(15, 'Michael', 'Brown', 'michael.brown@example.com', '$2a$10$3wT7sFdAd8yhFkLSp2nqSemBIl1E2K7VqcIQ8fHFEXgJQm9QU.vHC', '+1-555-678-9012', '2023-01-12 10:35:00', 'profile15.jpg', 'Guest');

-- Seed Addresses for properties
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, PostalCode) VALUES
(1, '123 Main St', 'New York', 'NY', 'USA', '10001'),
(2, '456 Ocean Ave', 'Miami', 'FL', 'USA', '33139'),
(3, '789 Maple Rd', 'Los Angeles', 'CA', 'USA', '90001'),
(4, '321 Pine St', 'San Francisco', 'CA', 'USA', '94101'),
(5, '55 Rue de Rivoli', 'Paris', NULL, 'France', '75001'),
(6, '27 Carrer de Mallorca', 'Barcelona', 'Catalonia', 'Spain', '08008'),
(7, '9-1 Marunouchi', 'Tokyo', NULL, 'Japan', '100-0005'),
(8, '42 Al Marsa St', 'Dubai', NULL, 'UAE', '12345'),
(9, '15 Zeyrek St', 'Istanbul', NULL, 'Turkey', '34083'),
(10, '78 Queen St', 'London', NULL, 'UK', 'EC4N 8BL'),
(11, '8 Nile Corniche', 'Cairo', NULL, 'Egypt', '11511'),
(12, '36 Bondi Rd', 'Sydney', 'NSW', 'Australia', '2026'),
(13, '23 Marina Bay', 'Singapore', NULL, 'Singapore', '018915'),
(14, '67 Calle Florida', 'Buenos Aires', NULL, 'Argentina', 'C1005'),
(15, '12 Copacabana Ave', 'Rio de Janeiro', NULL, 'Brazil', '22010-000');

-- Seed Properties
INSERT INTO Property (PropertyID, HostID, AddressID, Title, Description, PropertyType, PricePerNight, NumberOfBedrooms, NumberOfBathrooms, MaxGuests, Status, CreatedAt, UpdatedAt) VALUES
(1, 1, 1, 'Modern Manhattan Loft', 'Spacious loft in the heart of NYC with skyline views', 'Apartment', 250.00, 2, 2, 4, 'Available', '2023-01-20 09:30:00', '2023-01-20 09:30:00'),
(2, 1, 2, 'Beachfront Miami Condo', 'Luxurious condo with direct beach access and ocean views', 'Condo', 300.00, 3, 2, 6, 'Available', '2023-01-25 11:45:00', '2023-01-25 11:45:00'),
(3, 2, 3, 'Hollywood Hills Villa', 'Exclusive villa with pool and stunning city views', 'Villa', 750.00, 5, 4, 10, 'Available', '2023-02-22 14:00:00', '2023-02-22 14:00:00'),
(4, 2, 4, 'Cozy San Francisco Studio', 'Charming studio in the historic Mission District', 'Studio', 175.00, 1, 1, 2, 'Available', '2023-02-25 10:15:00', '2023-02-25 10:15:00'),
(5, 3, 5, 'Elegant Parisian Apartment', 'Classic Haussmannian apartment near the Louvre', 'Apartment', 280.00, 2, 1, 4, 'Available', '2023-03-12 16:30:00', '2023-03-12 16:30:00'),
(6, 3, 6, 'Barcelona Beachside Flat', 'Stylish apartment minutes from Barceloneta Beach', 'Apartment', 200.00, 1, 1, 3, 'Available', '2023-03-15 13:20:00', '2023-03-15 13:20:00'),
(7, 4, 7, 'Tokyo Minimalist Studio', 'Modern Japanese-style apartment in central Tokyo', 'Studio', 190.00, 1, 1, 2, 'Available', '2023-02-05 08:45:00', '2023-02-05 08:45:00'),
(8, 4, 8, 'Dubai Marina Penthouse', 'Luxurious penthouse with panoramic views of Dubai Marina', 'Penthouse', 500.00, 3, 3, 6, 'Available', '2023-02-10 15:30:00', '2023-02-10 15:30:00'),
(9, 5, 9, 'Historic Istanbul Apartment', 'Charming apartment in the heart of historic Istanbul', 'Apartment', 150.00, 2, 1, 4, 'Available', '2023-03-07 11:10:00', '2023-03-07 11:10:00'),
(10, 5, 10, 'Central London Flat', 'Elegant flat steps away from St. Paul\'s Cathedral', 'Apartment', 290.00, 1, 1, 2, 'Available', '2023-03-11 09:25:00', '2023-03-11 09:25:00'),
(11, 1, 11, 'Nile View Cairo Apartment', 'Spacious apartment with breathtaking views of the Nile', 'Apartment', 180.00, 3, 2, 6, 'Available', '2023-01-30 12:40:00', '2023-01-30 12:40:00'),
(12, 2, 12, 'Bondi Beach House', 'Stunning beach house just steps from Bondi Beach', 'House', 320.00, 3, 2, 8, 'Available', '2023-03-02 16:15:00', '2023-03-02 16:15:00'),
(13, 3, 13, 'Singapore Orchard Road Condo', 'Luxury condo in the heart of Singapore\'s shopping district', 'Condo', 270.00, 2, 2, 4, 'Available', '2023-03-20 10:50:00', '2023-03-20 10:50:00'),
(14, 4, 14, 'Buenos Aires Historic Loft', 'Unique loft in a converted historic building', 'Loft', 160.00, 1, 1, 3, 'Available', '2023-02-17 14:25:00', '2023-02-17 14:25:00'),
(15, 5, 15, 'Copacabana Beachfront Apartment', 'Beautiful apartment with direct views of Copacabana Beach', 'Apartment', 210.00, 2, 2, 5, 'Available', '2023-03-01 15:40:00', '2023-03-01 15:40:00');

-- Seed PropertyAmenityMapping
INSERT INTO PropertyAmenityMapping (PropertyID, AmenityID) VALUES
-- Modern Manhattan Loft amenities
(1, 1), -- WiFi
(1, 2), -- Air Conditioning
(1, 3), -- Kitchen
(1, 7), -- TV
(1, 10), -- Heating

-- Beachfront Miami Condo amenities
(2, 1), -- WiFi
(2, 2), -- Air Conditioning
(2, 3), -- Kitchen
(2, 5), -- Swimming Pool
(2, 7), -- TV
(2, 8), -- Washer
(2, 9), -- Dryer

-- Hollywood Hills Villa amenities
(3, 1), -- WiFi
(3, 2), -- Air Conditioning
(3, 3), -- Kitchen
(3, 4), -- Free Parking
(3, 5), -- Swimming Pool
(3, 6), -- Gym
(3, 7), -- TV
(3, 8), -- Washer
(3, 9), -- Dryer
(3, 10), -- Heating

-- Continue for all properties...
(4, 1), (4, 3), (4, 7), (4, 10), -- Cozy San Francisco Studio
(5, 1), (5, 3), (5, 7), (5, 10), -- Elegant Parisian Apartment
(6, 1), (6, 2), (6, 3), (6, 7), -- Barcelona Beachside Flat
(7, 1), (7, 2), (7, 7), -- Tokyo Minimalist Studio
(8, 1), (8, 2), (8, 3), (8, 5), (8, 6), (8, 7), (8, 8), (8, 9), -- Dubai Marina Penthouse
(9, 1), (9, 3), (9, 7), (9, 10), -- Historic Istanbul Apartment
(10, 1), (10, 3), (10, 7), (10, 10), -- Central London Flat
(11, 1), (11, 2), (11, 3), (11, 7), -- Nile View Cairo Apartment
(12, 1), (12, 2), (12, 3), (12, 4), (12, 7), (12, 8), (12, 9), -- Bondi Beach House
(13, 1), (13, 2), (13, 3), (13, 6), (13, 7), -- Singapore Orchard Road Condo
(14, 1), (14, 3), (14, 7), (14, 10), -- Buenos Aires Historic Loft
(15, 1), (15, 2), (15, 3), (15, 7), (15, 8), (15, 9); -- Copacabana Beachfront Apartment

-- Seed PropertyAvailability
INSERT INTO PropertyAvailability (PropertyID, StartDate, EndDate, IsAvailable) VALUES
-- Property 1 availability
(1, '2023-05-01', '2023-05-15', TRUE),
(1, '2023-05-20', '2023-06-15', TRUE),
(1, '2023-06-20', '2023-07-31', TRUE),
(1, '2023-08-10', '2023-09-30', TRUE),

-- Property 2 availability
(2, '2023-05-01', '2023-06-30', TRUE),
(2, '2023-07-10', '2023-08-15', TRUE),
(2, '2023-09-01', '2023-10-31', TRUE),

-- Property 3 availability
(3, '2023-05-01', '2023-05-31', TRUE),
(3, '2023-06-15', '2023-08-31', TRUE),
(3, '2023-09-15', '2023-12-31', TRUE),

-- Add more availability periods for other properties
(4, '2023-05-01', '2023-09-30', TRUE),
(5, '2023-05-01', '2023-07-31', TRUE),
(6, '2023-05-15', '2023-10-15', TRUE),
(7, '2023-05-01', '2023-12-31', TRUE),
(8, '2023-06-01', '2023-09-30', TRUE),
(9, '2023-05-01', '2023-11-30', TRUE),
(10, '2023-05-15', '2023-08-15', TRUE),
(11, '2023-05-01', '2023-10-31', TRUE),
(12, '2023-05-01', '2023-07-31', TRUE),
(13, '2023-06-01', '2023-09-30', TRUE),
(14, '2023-05-15', '2023-12-15', TRUE),
(15, '2023-05-01', '2023-12-31', TRUE);

-- Seed Bookings
INSERT INTO Booking (BookingID, PropertyID, GuestID, CheckInDate, CheckOutDate, TotalPrice, NumberOfGuests, BookingStatus, BookingDate) VALUES
-- Completed bookings
(1, 1, 6, '2023-04-05', '2023-04-10', 5 * 250.00, 2, 'Confirmed', '2023-03-15 14:30:00'),
(2, 3, 7, '2023-04-02', '2023-04-07', 5 * 750.00, 8, 'Confirmed', '2023-03-10 11:45:00'),
(3, 5, 8, '2023-04-10', '2023-04-15', 5 * 280.00, 3, 'Confirmed', '2023-03-20 09:15:00'),
(4, 7, 9, '2023-04-03', '2023-04-08', 5 * 190.00, 2, 'Confirmed', '2023-03-12 16:20:00'),
(5, 10, 10, '2023-04-12', '2023-04-16', 4 * 290.00, 2, 'Confirmed', '2023-03-25 13:10:00'),

-- Current bookings
(6, 2, 11, '2023-05-05', '2023-05-12', 7 * 300.00, 4, 'Confirmed', '2023-04-10 10:30:00'),
(7, 4, 12, '2023-05-08', '2023-05-13', 5 * 175.00, 2, 'Confirmed', '2023-04-15 15:45:00'),

-- Future bookings
(8, 8, 13, '2023-06-10', '2023-06-17', 7 * 500.00, 5, 'Confirmed', '2023-05-01 12:20:00'),
(9, 12, 14, '2023-06-15', '2023-06-22', 7 * 320.00, 6, 'Confirmed', '2023-05-02 09:30:00'),
(10, 15, 15, '2023-06-20', '2023-06-27', 7 * 210.00, 4, 'Confirmed', '2023-05-04 14:15:00'),

-- Cancelled bookings
(11, 6, 6, '2023-05-20', '2023-05-27', 7 * 200.00, 2, 'Cancelled', '2023-04-05 11:00:00'),
(12, 9, 8, '2023-05-25', '2023-06-02', 8 * 150.00, 3, 'Cancelled', '2023-04-10 16:30:00'),

-- Pending bookings
(13, 11, 9, '2023-07-05', '2023-07-12', 7 * 180.00, 5, 'Pending', '2023-05-06 10:45:00'),
(14, 13, 10, '2023-07-10', '2023-07-17', 7 * 270.00, 3, 'Pending', '2023-05-07 13:20:00'),
(15, 14, 7, '2023-07-15', '2023-07-22', 7 * 160.00, 2, 'Pending', '2023-05-08 15:10:00');

-- Seed Reviews (only for completed bookings)
INSERT INTO Review (ReviewID, BookingID, Rating, Comment, ReviewDate) VALUES
(1, 1, 5, 'Amazing loft with breathtaking views of NYC! Everything was perfect.', '2023-04-12 16:30:00'),
(2, 2, 4, 'Beautiful villa with a great pool. Slightly noisy at night, but overall a fantastic stay.', '2023-04-09 14:15:00'),
(3, 3, 5, 'The Parisian apartment was even more beautiful than in the photos. Perfect location!', '2023-04-17 11:20:00'),
(4, 4, 3, 'Nice and clean studio, but smaller than expected. Good location though.', '2023-04-10 09:45:00'),
(5, 5, 5, 'Perfect London location and a beautifully appointed flat. Would definitely stay again!', '2023-04-18 15:30:00');

-- Seed Payments
INSERT INTO Payment (PaymentID, BookingID, Amount, PaymentDate, PaymentStatus, PaymentMethod) VALUES
-- Payments for completed bookings
(1, 1, 5 * 250.00, '2023-03-15 14:35:00', 'Completed', 'Credit Card'),
(2, 2, 5 * 750.00, '2023-03-10 11:50:00', 'Completed', 'PayPal'),
(3, 3, 5 * 280.00, '2023-03-20 09:20:00', 'Completed', 'Credit Card'),
(4, 4, 5 * 190.00, '2023-03-12 16:25:00', 'Completed', 'Debit Card'),
(5, 5, 4 * 290.00, '2023-03-25 13:15:00', 'Completed', 'Credit Card'),

-- Payments for current bookings
(6, 6, 7 * 300.00, '2023-04-10 10:35:00', 'Completed', 'PayPal'),
(7, 7, 5 * 175.00, '2023-04-15 15:50:00', 'Completed', 'Credit Card'),

-- Payments for future bookings
(8, 8, 7 * 500.00, '2023-05-01 12:25:00', 'Completed', 'Credit Card'),
(9, 9, 7 * 320.00, '2023-05-02 09:35:00', 'Completed', 'Debit Card'),
(10, 10, 7 * 210.00, '2023-05-04 14:20:00', 'Completed', 'PayPal'),

-- Refunded payment for cancelled booking
(11, 11, 7 * 200.00, '2023-04-05 11:05:00', 'Refunded', 'Credit Card'),
(12, 12, 8 * 150.00, '2023-04-10 16:35:00', 'Refunded', 'PayPal'),

-- Pending payments
(13, 13, 7 * 180.00, '2023-05-06 10:50:00', 'Pending', 'Credit Card'),
(14, 14, 7 * 270.00, '2023-05-07 13:25:00', 'Pending', 'PayPal'),
(15, 15, 7 * 160.00, '2023-05-08 15:15:00', 'Pending', 'Debit Card');