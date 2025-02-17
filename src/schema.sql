-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;

-- Drop tables if they exist
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS equipment_maintenance_log;

-- Create your tables here
-- Example:
-- CREATE TABLE table_name (
--     column1 datatype,
--     column2 datatype,
--     ...
-- );

-- 1. locations

CREATE TABLE locations ( 
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(40) NOT NULL CHECK(length(name) > 4),
    address VARCHAR(100) NOT NULL CHECK(length(address) > 4),
    phone_number VARCHAR(15) NOT NULL CHECK(length(phone_number) >= 8),
    email VARCHAR(50) NOT NULL CHECK(email LIKE '%@%.%'),
    opening_hours VARCHAR(50) NOT NULL CHECK(length(opening_hours) >= 12)
);

/*INSERT INTO locations (name, address, phone_number, email, opening_hours)
VALUES ('Gym1', '123 Main St, Cityville', '555-1234', 'test@example.com', '6:00-22:00');

INSERT INTO locations (name, address, phone_number, email, opening_hours)
VALUES ('Gym Location', '123 Main St, Cityville', '12345678', 'test@example.com', '6:00-22:00');*/

-- 2. members

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,              
    first_name VARCHAR(40) NOT NULL CHECK(length(first_name) > 1),          
    last_name VARCHAR(40) NOT NULL CHECK(length(last_name) > 1),           
    email VARCHAR(50) NOT NULL CHECK(email LIKE '%@%.%'),                 
    phone_number VARCHAR(15) NOT NULL CHECK(length(phone_number) >= 8),         
    date_of_birth DATE NOT NULL,        
    join_date DATE NOT NULL,          
    emergency_contact_name VARCHAR(80) NOT NULL CHECK(length(emergency_contact_name) > 1),
    emergency_contact_phone VARCHAR(15) NOT NULL CHECK(length(emergency_contact_phone) >= 8)
);

/*-- Attempt to insert a member with a first_name of exactly 2 characters (minimum valid length)
INSERT INTO members (first_name, last_name, email, phone_number, date_of_birth, join_date, emergency_contact_name, emergency_contact_phone)
VALUES ('Jo', 'Doe', 'johndoe@example.com', '12345678', '1990-01-01', '2025-01-01', 'Jane Doe', '87654321');

-- Attempt to insert a member with a phone_number of exactly 8 characters (minimum valid length)
INSERT INTO members (first_name, last_name, email, phone_number, date_of_birth, join_date, emergency_contact_name, emergency_contact_phone)
VALUES ('John', 'Doe', 'johndoe@example.com', '12345678', '1990-01-01', '2025-01-01', 'Jane Doe', '87654321');*/

-- 3. staff

CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,              
    first_name VARCHAR(40) NOT NULL CHECK(length(first_name) > 1),          
    last_name VARCHAR(40) NOT NULL CHECK(length(last_name) > 1),           
    email VARCHAR(50) NOT NULL CHECK(email LIKE '%@%.%'),                 
    phone_number VARCHAR(15) NOT NULL CHECK(length(phone_number) >= 8),         
    position VARCHAR(25) NOT NULL CHECK(position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance')), 
    hire_date DATE NOT NULL,        
    location_id INTEGER NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

/*INSERT INTO members (first_name, last_name, email, phone_number, date_of_birth, join_date, emergency_contact_name, emergency_contact_phone)
VALUES ('Jo', 'Doe', 'johndoe@example.com', '12345678', '1990-01-01', '2025-01-01', 'Jane Doe', '87654321');

INSERT INTO members (first_name, last_name, email, phone_number, date_of_birth, join_date, emergency_contact_name, emergency_contact_phone)
VALUES ('John', 'Doe', 'johndoe@example.com', '12345678', '1990-01-01', '2025-01-01', 'Jane Doe', '87654321');*/

-- 4. equipment

CREATE TABLE equipment (
    equipment_id INTEGER PRIMARY KEY AUTOINCREMENT,	
    name VARCHAR(40) NOT NULL CHECK(length(name) > 1),
    type VARCHAR(25) NOT NULL CHECK(type IN ('Cardio', 'Strength')),
    purchase_date DATE NOT NULL,
    last_maintenance_date DATE NOT NULL,	
    next_maintenance_date DATE NOT NULL,	
    location_id INTEGER NOT NULL CHECK(location_id > 0),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

/*INSERT INTO equipment (name, type, purchase_date, last_maintenance_date, next_maintenance_date, location_id)
VALUES ('E', 'Cardio', '2025-01-01', '2025-01-01', '2025-06-01', 1);

INSERT INTO equipment (name, type, purchase_date, last_maintenance_date, next_maintenance_date, location_id)
VALUES ('Eq', 'Cardio', '2025-01-01', '2025-01-01', '2025-06-01', 1);*/

-- 5. classes

CREATE TABLE classes(
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(40) NOT NULL CHECK(length(name) > 1),
    description VARCHAR(100) NOT NULL CHECK(length(description) > 1),
    capacity INTEGER NOT NULL CHECK(capacity > 0),
    duration INTEGER NOT NULL CHECK(duration > 0),
    location_id INTEGER NOT NULL CHECK(location_id > 0),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

/*INSERT INTO classes (name, description, capacity, duration, location_id)
VALUES ('Class1', 'Description', -2, 60, 1);

INSERT INTO classes (name, description, capacity, duration, location_id)
VALUES ('1', 'Description', 2, 60, 1);*/

-- 6. class_schedule

CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id INTEGER NOT NULL CHECK(class_id > 0),
    staff_id INTEGER NOT NULL CHECK(staff_id > 0),
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

/*INSERT INTO class_schedule (class_id, staff_id, start_time, end_time)
VALUES (1, 1, '2025-01-01 11:00:00');*/

-- 7. memberships

CREATE TABLE memberships (
    membership_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL CHECK(member_id > 0),
    type VARCHAR(25) NOT NULL CHECK(type IN ('Basic', 'Premium')),	
    start_date  DATE NOT NULL,	
    end_date DATE NOT NULL,	
    status VARCHAR(25) NOT NULL CHECK (status IN ('Active', 'Inactive')),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

/*INSERT INTO memberships (member_id, type, start_date, end_date, status)
VALUES (1, 'Active', '2025-01-01', '2025-12-31', 'Active');*/

-- 8. attendance

CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL CHECK(member_id > 0),
    location_id INTEGER NOT NULL CHECK(location_id > 0),
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

/*INSERT INTO attendance (member_id, location_id, check_in_time, check_out_time)
VALUES (1, 1, '2025-01-01 11:00:00');*/

-- 9. class_attendance

CREATE TABLE class_attendance(
    class_attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    schedule_id INTEGER NOT NULL CHECK(schedule_id > 0),	
    member_id INTEGER NOT NULL CHECK(member_id > 0),	
    attendance_status VARCHAR(25) NOT NULL CHECK (attendance_status IN	('Registered', 'Attended', 'Unattended')),
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

/*INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES (1, 1, 'Not attended');

INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES (0, 1, 'Attended');*/

-- 10. payments

CREATE TABLE payments(
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL CHECK(member_id > 0),	
    amount DECIMAL(10, 2) NOT NULL CHECK(amount > 0),	
    payment_date DATETIME NOT NULL,	
    payment_method VARCHAR(25) NOT NULL CHECK(payment_method IN ('Credit Card', 'Bank Transfer','Cash', 'PayPal')),
    payment_type VARCHAR(25) NOT NULL CHECK(payment_type IN ('Monthly membership fee', 'Day pass')),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

/*INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES (1, 0.01, datetime('now'), 'Credit Card', 'Monthly membership fee');

INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES (1, 0.04, datetime('now'), 'Credit Card', 'Weekly membership fee');*/

-- 11. personal_training_sessions

CREATE TABLE personal_training_sessions(
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL CHECK(member_id > 0),
    staff_id INTEGER NOT NULL CHECK(staff_id > 0),
    session_date DATE NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    notes VARCHAR(100),
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

/*INSERT INTO personal_training_sessions (member_id, staff_id, session_date, start_time, end_time, notes)
VALUES (1, 1, '2025-01-01', '2025-01-01 10:00:00', '2025-01-01 11:00:00', 'A');*/

-- 12. member_health_metrics

CREATE TABLE member_health_metrics(
    metric_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL CHECK(member_id > 0),
    measurement_date DATE NOT NULL,
    weight DECIMAL(5, 2) NOT NULL CHECK(weight > 0),
    body_fat_percentage DECIMAL(5, 2) NOT NULL CHECK(body_fat_percentage > 0),
    muscle_mass DECIMAL(5, 2) NOT NULL CHECK(muscle_mass > 0),
    bmi DECIMAL(5, 2) NOT NULL CHECK(bmi > 0),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

/*INSERT INTO member_health_metrics (member_id, measurement_date, weight, body_fat_percentage, muscle_mass, bmi)
VALUES (1, '2025-01-01', -0.6, 10.0, 20.0, 25.0);*/

-- 13. equipment_maintenance_log

CREATE TABLE equipment_maintenance_log(
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    equipment_id INTEGER NOT NULL CHECK(equipment_id > 0),
    maintenance_date DATE NOT NULL,
    description VARCHAR(100) NOT NULL CHECK(length(description) > 1),
    staff_id INTEGER NOT NULL CHECK(staff_id > 0),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

/*INSERT INTO equipment_maintenance_log (equipment_id, maintenance_date, description, staff_id)
VALUES (1, '2025-01-01', 'K', 1);*/

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal
