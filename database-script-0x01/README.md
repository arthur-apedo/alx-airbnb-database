# ALX Airbnb Database DDL

This project defines the core database schema for an Airbnb-like platform using MySQL. The schema supports user management, property listings, bookings, payments, reviews, and messaging.

## Tables

### 1. `users`
Stores user information.
- `id`: UUID, primary key
- `first_name`, `last_name`, `email`, `password_hash`, `phone_number`
- `role`: guest, host, or admin
- `created_at`: timestamp

### 2. `property`
Represents properties listed by hosts.
- `property_id`: UUID, primary key
- `host_id`: references `users(id)`
- `name`, `description`, `location`, `pricepernight`
- `created_at`, `updated_at`: timestamps

### 3. `booking`
Tracks property bookings.
- `booking_id`: UUID, primary key
- `property_id`: references `property(property_id)`
- `user_id`: references `users(id)`
- `start_date`, `end_date`, `total_price`, `status`
- `created_at`: timestamp

### 4. `payment`
Records payments for bookings.
- `payment_id`: UUID, primary key
- `booking_id`: references `booking(booking_id)`
- `amount`, `payment_date`, `payment_method`

### 5. `review`
Stores user reviews for properties.
- `review_id`: UUID, primary key
- `property_id`: references `property(property_id)`
- `user_id`: references `users(id)`
- `rating` (1-5), `comment`, `created_at`

### 6. `message`
Handles user-to-user messaging.
- `message_id`: UUID, primary key
- `sender_id`, `recipient_id`: references `users(id)`
- `message_body`, `sent_at`

## Notes

- All primary keys use UUIDs for uniqueness.
- Foreign keys ensure referential integrity.
- Indexes are added for efficient querying.
- Enum types restrict valid values for roles, booking status, and payment methods.

## Usage

Run the DDL scripts in your MySQL environment to create the schema.
