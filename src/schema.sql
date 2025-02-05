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




-- 4. equipment




-- 5. classes




-- 6. class_schedule





-- 7. memberships





-- 8. attendance






-- 9. class_attendance






-- 10. payments






-- 11. personal_training_sessions






-- 12. member_health_metrics





-- 13. equipment_maintenance_log

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal