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

-- TODO: Create the following tables:
-- 1. locations

CREATE TABLE locations ( 
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(40) NOT NULL CHECK(length(name) > 4),
    address VARCHAR(100) NOT NULL CHECK(length(address) > 4),
    phone_number VARCHAR(15) NOT NULL CHECK(length(phone_number) >= 8),
    email VARCHAR(50) NOT NULL CHECK(email LIKE '%@%.%'),
    opening_hours VARCHAR(50) NOT NULL CHECK(length(opening_hours) >= 10)
);
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

INSERT INTO staff (first_name, last_name, email, phone_number, position, hire_date, location_id)
VALUES 
('David', 'Brown', 'david.b@fittrackpro.com', '555-4444', 'Trainer', '2024-11-10', 1),
('Emma', 'Davis', 'emma.d@fittrackpro.com', '555-5555', 'Manager', '2024-11-15', 2),
('Frank', 'Evans', 'frank.e@fittrackpro.com', '555-6666', 'Receptionist', '2024-12-10', 1),
('Grace', 'Green', 'grace.g@fittrackpro.com', '555-7777', 'Trainer', '2024-12-20', 2),
('Henry', 'Harris', 'henry.h@fittrackpro.com', '555-8888', 'Maintenance', '2025-01-05', 1),
('Ivy', 'Irwin', 'ivy.i@fittrackpro.com', '555-9999', 'Trainer', '2025-01-01', 2),
('Jack', 'Johnson', 'jack.j@fittrackpro.com', '555-0000', 'Manager', '2024-11-15', 1),
('Karen', 'King', 'karen.k@fittrackpro.com', '555-1212', 'Trainer', '2024-12-01', 2);

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

INSERT INTO equipment (name, type, purchase_date, last_maintenance_date, next_maintenance_date, location_id)
VALUES 
('Treadmill 1', 'Cardio', '2024-11-01', '2024-11-15', '2025-02-15', 1),
('Treadmill 2', 'Cardio', '2024-11-02', '2024-11-20', '2025-02-20', 1),
('Treadmill 3', 'Cardio', '2024-11-03', '2024-11-25', '2025-02-25', 2),
('Treadmill 4', 'Cardio', '2024-11-04', '2024-11-30', '2025-02-28', 2),
('Bench Press 1', 'Strength', '2024-11-05', '2024-12-01', '2025-03-01', 1),
('Bench Press 2', 'Strength', '2024-11-06', '2024-12-05', '2025-03-05', 2),
('Elliptical 1', 'Cardio', '2024-11-07', '2024-12-10', '2025-03-10', 1),
('Elliptical 2', 'Cardio', '2024-11-08', '2024-12-15', '2025-03-15', 2),
('Squat Rack 1', 'Strength', '2024-11-09', '2024-12-20', '2025-03-20', 1),
('Squat Rack 2', 'Strength', '2024-11-10', '2024-12-25', '2025-03-25', 2),
('Rowing Machine 1', 'Cardio', '2024-11-11', '2024-12-30', '2025-03-30', 1),
('Rowing Machine 2', 'Cardio', '2024-11-12', '2025-01-01', '2025-04-01', 2),
('Leg Press 1', 'Strength', '2024-11-13', '2025-01-05', '2025-04-05', 1),
('Leg Press 2', 'Strength', '2024-11-14', '2025-01-10', '2025-04-10', 2),
('Stationary Bike 1', 'Cardio', '2024-11-15', '2025-01-15', '2025-04-15', 1),
('Stationary Bike 2', 'Cardio', '2024-11-16', '2025-01-20', '2025-04-20', 2);

-- 5. classes

CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(40) NOT NULL CHECK(length(name) > 1),
    description VARCHAR(100) NOT NULL CHECK(length(description) > 1),
    capacity INTEGER NOT NULL CHECK(capacity > 0),
    duration INTEGER NOT NULL CHECK(duration > 0),
    location_id INTEGER NOT NULL CHECK(location_id > 0),
    staff_id INTEGER NOT NULL CHECK(staff_id > 0),
    FOREIGN KEY (location_id) REFERENCES locations(location_id),    
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

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

INSERT INTO class_schedule (class_id, staff_id, start_time, end_time)
VALUES 
(1, 1, '2024-11-01 10:00:00', '2024-11-01 11:00:00'),
(2, 2, '2024-11-15 18:00:00', '2024-11-15 18:45:00'),
(3, 6, '2024-12-03 07:00:00', '2024-12-03 07:50:00'),
(4, 4, '2024-12-20 09:00:00', '2024-12-20 09:55:00'),
(5, 8, '2025-01-05 19:00:00', '2025-01-05 20:00:00'),
(6, 1, '2025-01-20 12:00:00', '2025-01-20 12:45:00'),
(3, 6, '2025-02-01 14:00:00', '2025-02-01 14:50:00'),
(5, 8, '2025-02-01 19:00:00', '2025-02-01 20:00:00'),
(5, 4, '2025-02-15 09:00:00', '2025-02-15 10:00:00');

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

INSERT INTO memberships (member_id, type, start_date, end_date, status)
VALUES
(1, 'Premium', '2024-11-01', '2025-10-31', 'Active'),
(2, 'Basic', '2024-11-05', '2025-11-04', 'Active'),
(3, 'Premium', '2024-11-10', '2025-11-09', 'Active'),
(4, 'Basic', '2024-11-15', '2025-11-14', 'Active'),
(5, 'Premium', '2024-11-20', '2025-11-19', 'Active'),
(6, 'Basic', '2024-11-25', '2025-11-24', 'Inactive'),
(7, 'Premium', '2024-12-01', '2025-11-30', 'Active'),
(8, 'Basic', '2024-12-05', '2025-12-04', 'Active'),
(9, 'Premium', '2024-12-10', '2025-12-09', 'Active'),
(10, 'Basic', '2024-12-15', '2025-12-14', 'Inactive'),
(11, 'Premium', '2024-12-20', '2025-12-19', 'Active'),
(12, 'Basic', '2024-12-25', '2025-12-24', 'Active'),
(13, 'Premium', '2025-01-01', '2025-12-31', 'Active'),
(14, 'Basic', '2025-01-05', '2026-01-04', 'Inactive'),
(15, 'Premium', '2025-01-10', '2026-01-09', 'Active');

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

-- 9. class_attendance

CREATE TABLE class_attendance(
    class_attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    schedule_id INTEGER NOT NULL CHECK(schedule_id > 0),	
    member_id INTEGER NOT NULL CHECK(member_id > 0),	
    attendance_status VARCHAR(25) NOT NULL CHECK (attendance_status IN	('Registered', 'Attended', 'Unattended')),
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES 
(1, 1, 'Attended'),
(2, 2, 'Attended'),
(3, 3, 'Attended'),
(4, 4, 'Attended'),
(5, 5, 'Attended'),
(6, 6, 'Registered'),
(7, 7, 'Registered'),
(8, 8, 'Registered'),
(1, 9, 'Attended'),
(2, 10, 'Unattended'),
(3, 11, 'Attended'),
(4, 12, 'Unattended'),
(5, 13, 'Attended'),
(6, 1, 'Registered'),
(7, 2, 'Registered'),
(8, 3, 'Registered');

-- 10. payments






-- 11. personal_training_sessions






-- 12. member_health_metrics





-- 13. equipment_maintenance_log

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal