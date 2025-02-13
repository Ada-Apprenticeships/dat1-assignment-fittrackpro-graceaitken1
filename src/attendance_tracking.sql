-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;
-- Attendance Tracking Queries

-- 1. Record a member's gym visit
INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (7, 1, datetime ('now')); 

-- 2. Retrieve a member's attendance history
SELECT date(check_in_time) AS visit_date,
       check_in_time,
       check_out_time
FROM attendance
WHERE member_id = 5;

-- 3. Find the busiest day of the week based on gym visits
SELECT strftime('%w', check_in_time) AS day_of_week, COUNT(*) AS visit_count
FROM attendance
GROUP BY day_of_week
ORDER BY visit_count DESC
LIMIT 1;

-- 4. Calculate the average daily attendance for each location
SELECT location_id, AVG(daily_visits) AS avg_daily_attendance
FROM (
    SELECT location_id, date(check_in_time) AS visit_date, COUNT(*) AS daily_visits
    FROM attendance
    GROUP BY location_id, visit_date
)
GROUP BY location_id;
