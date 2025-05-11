-- ========================================================
-- ALX Airbnb Database Schema (DDL)
-- File: database-script-0x01/schema.sql
-- ========================================================

-- 1. User
CREATE TABLE "User" (
  user_id       UUID         PRIMARY KEY,
  first_name    VARCHAR(255) NOT NULL,
  last_name     VARCHAR(255) NOT NULL,
  email         VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  phone_number  VARCHAR(50),
  role          VARCHAR(10)  NOT NULL 
                    CHECK (role IN ('guest','host','admin')),
  created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_user_email ON "User"(email);


-- 2. Location
CREATE TABLE Location (
  location_id UUID         PRIMARY KEY,
  address     VARCHAR(255) NOT NULL,
  city        VARCHAR(100),
  state       VARCHAR(100),
  country     VARCHAR(100)
);


-- 3. Property
CREATE TABLE Property (
  property_id    UUID         PRIMARY KEY,
  host_id        UUID         NOT NULL
                     REFERENCES "User"(user_id)
                     ON DELETE CASCADE,
  name           VARCHAR(255) NOT NULL,
  description    TEXT         NOT NULL,
  price_per_night DECIMAL(10,2) NOT NULL,
  location_id    UUID         NOT NULL
                     REFERENCES Location(location_id)
                     ON DELETE RESTRICT,
  created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
                     ON UPDATE CURRENT_TIMESTAMP
);

CREATE INDEX idx_property_host ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location_id);


-- 4. Booking
CREATE TABLE Booking (
  booking_id  UUID         PRIMARY KEY,
  property_id UUID         NOT NULL
                     REFERENCES Property(property_id)
                     ON DELETE CASCADE,
  user_id     UUID         NOT NULL
                     REFERENCES "User"(user_id)
                     ON DELETE CASCADE,
  start_date  DATE         NOT NULL,
  end_date    DATE         NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  status      VARCHAR(10)  NOT NULL 
                     CHECK (status IN ('pending','confirmed','canceled')),
  created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_user     ON Booking(user_id);


-- 5. Payment
CREATE TABLE Payment (
  payment_id     UUID         PRIMARY KEY,
  booking_id     UUID         NOT NULL
                     REFERENCES Booking(booking_id)
                     ON DELETE CASCADE,
  amount         DECIMAL(10,2) NOT NULL,
  payment_date   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  payment_method VARCHAR(20)  NOT NULL 
                     CHECK (payment_method IN ('credit_card','paypal','stripe'))
);

CREATE INDEX idx_payment_booking ON Payment(booking_id);


-- 6. Review
CREATE TABLE Review (
  review_id    UUID         PRIMARY KEY,
  booking_id   UUID         NOT NULL
                     REFERENCES Booking(booking_id)
                     ON DELETE CASCADE,
  reviewer_id  UUID         NOT NULL
                     REFERENCES "User"(user_id)
                     ON DELETE SET NULL,
  rating       INT          NOT NULL 
                     CHECK (rating BETWEEN 1 AND 5),
  comment      TEXT         NOT NULL,
  created_at   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_review_booking  ON Review(booking_id);
CREATE INDEX idx_review_reviewer ON Review(reviewer_id);


-- 7. Message
CREATE TABLE Message (
  message_id   UUID         PRIMARY KEY,
  sender_id    UUID         NOT NULL
                     REFERENCES "User"(user_id)
                     ON DELETE CASCADE,
  recipient_id UUID         NOT NULL
                     REFERENCES "User"(user_id)
                     ON DELETE CASCADE,
  message_body TEXT         NOT NULL,
  sent_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_message_sender    ON Message(sender_id);
CREATE INDEX idx_message_recipient ON Message(recipient_id);
