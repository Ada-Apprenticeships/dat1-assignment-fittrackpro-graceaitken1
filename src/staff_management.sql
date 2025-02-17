-- Initial SQLite setup
.open fittrackpro.db
.mode column
.mode box

-- Enable foreign key support
PRAGMA foreign_key = ON;
-- Staff Management Queries

SELECT staff_id, 
       first_name, 
       last_name, 
       position AS role
FROM staff
ORDER BY position;

SELECT s.staff_id AS trainer_id,
       s.first_name || ' ' || s.last_name AS trainer_name, 
       COUNT(*) AS session_count
FROM staff s
JOIN personal_training_sessions pts ON s.staff_id = pts.staff_id
WHERE pts.session_date BETWEEN datetime('now') AND datetime('now', '+30 days')
GROUP BY s.staff_id, trainer_name;