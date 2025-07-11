-- DROP TABLES IF THEY ALREADY EXIST (in correct dependency order)
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS booking;
DROP TABLE IF EXISTS property;
DROP TABLE IF EXISTS users;

-- CREATE USERS TABLE
CREATE TABLE IF NOT EXISTS users (
    id CHAR(36) PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX (id)
);

-- CREATE PROPERTY TABLE
CREATE TABLE IF NOT EXISTS property (
    property_id CHAR(36) PRIMARY KEY,
    host_id CHAR(36),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX (property_id),
    FOREIGN KEY (host_id) REFERENCES users(id)
);

-- CREATE BOOKING TABLE
CREATE TABLE IF NOT EXISTS booking (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36),
    user_id CHAR(36),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX (booking_id),
    FOREIGN KEY (property_id) REFERENCES property(property_id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- CREATE PAYMENT TABLE
CREATE TABLE IF NOT EXISTS payment (
    payment_id CHAR(36) PRIMARY KEY,
    booking_id CHAR(36),
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    INDEX (payment_id),
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
);

-- CREATE REVIEW TABLE
CREATE TABLE IF NOT EXISTS review (
    review_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36),
    user_id CHAR(36),
    rating TINYINT UNSIGNED NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX (review_id),
    FOREIGN KEY (property_id) REFERENCES property(property_id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- CREATE MESSAGE TABLE
CREATE TABLE IF NOT EXISTS message (
    message_id CHAR(36) PRIMARY KEY,
    sender_id CHAR(36),
    recipient_id CHAR(36),
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX (message_id),
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (recipient_id) REFERENCES users(id)
);

-- INSERT SAMPLE USERS
INSERT INTO users (id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
  ('user-001', 'James', 'Bond', 'james.bond@example.com', 'hash007', '1234567890', 'guest'),
  ('user-002', 'Jane', 'Smith', 'jane.smith@example.com', 'hash001', '2345678901', 'host'),
  ('user-003', 'Alice', 'Brown', 'alice.brown@example.com', 'hashabc', '3456789012', 'admin');

-- INSERT SAMPLE PROPERTIES
INSERT INTO property (property_id, host_id, name, description, location, pricepernight)
VALUES
  ('prop-001', 'user-002', 'Ocean View Apartment', 'Beachside 2-bedroom with balcony.', 'Miami, FL', 120.00),
  ('prop-002', 'user-002', 'Mountain Cabin', 'Rustic cabin near ski slopes.', 'Aspen, CO', 200.00);

-- INSERT SAMPLE BOOKINGS
INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  ('book-001', 'prop-001', 'user-001', '2025-08-01', '2025-08-05', 480.00, 'confirmed'),
  ('book-002', 'prop-002', 'user-001', '2025-09-01', '2025-09-03', 400.00, 'pending');

-- INSERT SAMPLE PAYMENTS
INSERT INTO payment (payment_id, booking_id, amount, payment_method)
VALUES
  ('pay-001', 'book-001', 480.00, 'credit_card'),
  ('pay-002', 'book-002', 400.00, 'paypal');

-- INSERT SAMPLE REVIEWS
INSERT INTO review (review_id, property_id, user_id, rating, comment)
VALUES
  ('rev-001', 'prop-001', 'user-001', 5, 'Amazing view and great location.'),
  ('rev-002', 'prop-002', 'user-001', 4, 'Very cozy and clean, Wi-Fi could be better.');

-- INSERT SAMPLE MESSAGES
INSERT INTO message (message_id, sender_id, recipient_id, message_body)
VALUES
  ('msg-001', 'user-001', 'user-002', 'Hi Jane, is early check-in possible?'),
  ('msg-002', 'user-002', 'user-001', 'Yes, you can check in at 2 PM.');
