-- creation of users table
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);
-- Data insertion
INSERT INTO users VALUES
('U1', 'John Doe', '9876543210', 'john@example.com', 'ABC Street'),
('U2', 'Alice', '9123456780', 'alice@example.com', 'XYZ Street');

SELECT * FROM users;

-- creation of BOOKINGS TABLE
CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
-- Data insertion
INSERT INTO bookings VALUES
('B1', '2021-11-10 10:00:00', 'R101', 'U1'),
('B2', '2021-11-15 12:00:00', 'R102', 'U1'),
('B3', '2021-10-05 09:00:00', 'R103', 'U2');

--creation of ITEMS TABLE
CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);
-- Data insertion
INSERT INTO items VALUES
('I1', 'Paratha', 20),
('I2', 'Veg Curry', 100);

-- creation of Booking_commercials
CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);
--data insertion
INSERT INTO booking_commercials VALUES
('C1', 'B1', 'BL1', '2021-11-10', 'I1', 3),
('C2', 'B1', 'BL1', '2021-11-10', 'I2', 1),
('C3', 'B2', 'BL2', '2021-11-15', 'I2', 5),
('C4', 'B3', 'BL3', '2021-10-05', 'I1', 10);

