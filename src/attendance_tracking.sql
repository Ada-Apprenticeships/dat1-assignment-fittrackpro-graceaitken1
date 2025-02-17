-- Initial SQLite setup
.open fittrackpro.db
.mode column
.mode box

-- Enable foreign key support
PRAGMA foreign_key = ON;
-- Attendance Tracking Queries

INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (7, 1, datetime ('now')); 

SELECT date(check_in_time) AS visit_date,
       check_in_time,
       check_out_time
FROM attendance
WHERE member_id = 5;

SELECT strftime('%w', check_in_time) AS day_of_week, COUNT(*) AS visit_count
FROM attendance
GROUP BY day_of_week
ORDER BY visit_count DESC
LIMIT 1;

SELECT l.name AS location_name, AVG(daily_visits) AS avg_daily_attendance
FROM (
    SELECT location_id, date(check_in_time) AS visit_date, COUNT(*) AS daily_visits
    FROM attendance
    GROUP BY location_id, visit_date) AS daily_attendance
JOIN locations l ON daily_attendance.location_id = l.location_id
GROUP BY l.name;