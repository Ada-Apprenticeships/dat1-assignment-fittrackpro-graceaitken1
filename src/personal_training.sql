-- Initial SQLite setup
.open fittrackpro.db
.mode column
.mode box

-- Enable foreign key support
PRAGMA foreign_key = ON;
-- Personal Training Queries

SELECT s.first_name || ' ' || s.last_name AS trainer_id, 
       pts.session_date, 
       pts.start_time, 
       m.first_name || ' ' || m.last_name AS client_name
FROM staff s
JOIN personal_training_sessions pts ON s.staff_id = pts.staff_id
JOIN members m ON pts.member_id = m.member_id
WHERE s.first_name = 'Ivy' AND s.last_name = 'Irwin';

SELECT pts.session_id, 
       m.first_name || ' ' || m.last_name AS member_name, 
       pts.session_date, 
       pts.start_time, 
       pts.end_time
FROM personal_training_sessions pts
JOIN members m ON pts.member_id = m.member_id
JOIN staff s ON pts.staff_id = s.staff_id
WHERE s.first_name = 'Ivy' AND s.last_name = 'Irwin';