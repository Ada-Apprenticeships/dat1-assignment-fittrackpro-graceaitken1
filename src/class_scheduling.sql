-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;
-- Class Scheduling Queries

-- 1. List all classes with their instructors
SELECT c.class_id, 
       c.name, 
       s.first_name || ' ' || s.last_name AS instructor_name
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
JOIN staff s ON cs.staff_id = s.staff_id;

-- 2. Find available classes for a specific date
SELECT c.class_id, 
       c.name, 
       cs.start_time, 
       cs.end_time,
       (c.capacity - COUNT(ca.attendance_status)) AS available_spots
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
LEFT JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id
AND ca.attendance_status IN ('Registered', 'Attended')
WHERE DATE(start_time) = '2025-02-01'
GROUP BY c.class_id, c.name, cs.start_time, cs.end_time, c.capacity;

-- 3. Register a member for a class
INSERT INTO class_attendance (attendance_status, schedule_id, member_id)
VALUES ('Registered', 3, 11);  

-- 4. Cancel a class registration
DELETE FROM class_attendance
WHERE member_id = 2 AND schedule_id = 2; 

-- 5. List top 5 most popular classes
SELECT c.class_id, c.name, COUNT(ca.attendance_status) AS registration_count
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id
GROUP BY c.class_id, c.name
ORDER BY registration_count DESC;

-- 6. Calculate average number of classes per member
SELECT AVG(class_count) AS avg_classes_per_member
FROM (
    SELECT member_id, COUNT(schedule_id) AS class_count
    FROM class_attendance
    GROUP BY member_id
);
