# ALX AirBnB Database Seed Data

## Overview

This directory contains SQL scripts to populate the AirBnB-like accommodation booking system database with realistic sample data. The seed data provides a comprehensive set of interrelated records across all tables to facilitate testing, development, and demonstration of database functionality.

## Seed Data Statistics

The database is populated with the following sample data:

- **Users**: 15 total
  - 5 hosts
  - 10 guests
  
- **Properties**: 15 total with various types
  - Apartments: 7
  - Studios: 2
  - Houses/Villas: 2
  - Condos: 2
  - Lofts/Penthouses: 2
  
- **Addresses**: 15 (one for each property)
  - Geographic diversity across multiple countries and cities

- **Property Amenities**: All 15 properties have various amenities mapped
  - Common amenities like WiFi, Kitchen, TV
  - Premium amenities like Swimming Pool, Gym

- **Property Availability**: 15+ date ranges across all properties

- **Bookings**: 15 total
  - 5 completed bookings
  - 2 current bookings
  - 3 future confirmed bookings
  - 2 cancelled bookings
  - 3 pending bookings

- **Reviews**: 5 (one for each completed booking)
  - Various ratings (3-5 stars)
  - Detailed comments

- **Payments**: 15 (one for each booking)
  - Different payment methods (Credit Card, PayPal, Debit Card)
  - Various payment statuses (Completed, Pending, Refunded)

## Data Relationships

The seed data demonstrates various relationships:

1. **One-to-Many**: 
   - Hosts with multiple properties
   - Guests with multiple bookings
   - Properties with multiple bookings

2. **Many-to-Many**:
   - Properties and their amenities through the mapping table

3. **One-to-One**:
   - Bookings with their corresponding reviews
   - Bookings with their corresponding payments

## User Scenarios

The seed data supports various real-world scenarios:

1. **Booking Lifecycle**:
   - Pending bookings awaiting confirmation
   - Confirmed future stays
   - Active current stays
   - Completed past stays with reviews
   - Cancelled bookings with refunds

2. **Property Management**:
   - Properties with various amenities and availability periods
   - Different property types across multiple locations

3. **User Experience**:
   - Guest booking history
   - Host property management
   - Review system

## Data Time Frame

The seed data follows a chronological pattern:
- User accounts created in January-March 2023
- Properties listed in January-March 2023
- Bookings from April-July 2023
- Reviews from April 2023
- Availability periods from May-December 2023

## Using the Seed Script

To populate your database with this sample data:

1. Ensure you have already run the schema creation script (`schema.sql`)

2. Run the seed script:
   ```
   sqlite3 airbnb.db < seed.sql
   ```
   or
   ```
   mysql -u username -p airbnb_db < seed.sql
   ```

## Data Customization

The seed data can be customized by:
- Modifying property details, prices, or locations
- Adjusting booking dates to reflect current timeframes
- Adding more users, properties, or bookings
- Creating additional reviews or changing ratings

## Notes

- All user passwords are hashed (using bcrypt format in this example)
- Property prices reflect realistic market rates for different property types and locations
- Review comments are based on common traveler feedback
- All dates follow ISO format (YYYY-MM-DD)