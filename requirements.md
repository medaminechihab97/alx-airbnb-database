# alx-airbnb-database
alx-airbnb-database


# Task 0: ERD Requirements

## 1. Entities & Attributes

### User
- **user_id** (PK)  
- name  
- email  
- password_hash  
- created_at  

### Property
- **property_id** (PK)  
- host_user_id (FK → User.user_id)  
- title  
- description  
- address  
- price_per_night  

### Booking
- **booking_id** (PK)  
- user_id (FK → User.user_id)  
- property_id (FK → Property.property_id)  
- start_date  
- end_date  
- total_price  

### Payment
- **payment_id** (PK)  
- booking_id (FK → Booking.booking_id)  
- amount  
- method  
- status  
- paid_at  

### Review
- **review_id** (PK)  
- booking_id (FK → Booking.booking_id)  
- rating  
- comment  
- created_at  


## 2. Relationships

- **User 1 → N Booking**  
  - One user can make many bookings.

- **Property 1 → N Booking**  
  - One property can have many bookings.

- **Booking 1 → N Payment**  
  - One booking can have multiple payment records.

- **Booking 1 → 1 Review**  
  - One booking yields one review.  

- **User 1 → N Property**  
  - One user (as host) can list many properties.



## 3. Notes

- Primary Keys (PK) uniquely identify each record.  
- Foreign Keys (FK) link related records across tables.  
- Use crow’s-foot notation in your diagram to show “1” vs “many.”  
- Export your ERD diagram as `airbnb-erd.drawio` or `airbnb-erd.png` and add it here.  
