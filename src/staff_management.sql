-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;
-- Staff Management Queries

-- 1. List all staff members by role
SELECT position, first_name, last_name, position
FROM staff
ORDER BY position;

-- 2. Find trainers with one or more personal training session in the next 30 days
SELECT s.staff_id, s.first_name, s.last_name, COUNT(*) AS session_count
FROM staff s
JOIN personal_training_sessions pts ON s.staff_id = pts.staff_id
WHERE pts.session_date BETWEEN datetime('now') AND datetime('now', '+30 days')
GROUP BY s.staff_id, s.first_name, s.last_name;