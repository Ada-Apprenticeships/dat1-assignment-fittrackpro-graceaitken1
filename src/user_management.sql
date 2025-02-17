-- Initial SQLite setup
.open fittrackpro.db
.mode column
.mode box

PRAGMA foreign_key = ON;

SELECT member_id, 
       first_name,
       last_name, 
       email, 
       join_date 
FROM members; 

UPDATE members
SET phone_number = '555-9876', 
    email = 'emily.jones.updated@email.com'
WHERE member_id = 5;
        
SELECT COUNT(*) AS total_members
FROM members;

SELECT m.member_id, m.first_name, m.last_name, COUNT(ca.member_id) AS registration_count
FROM members m
JOIN class_attendance ca ON m.member_id = ca.member_id
GROUP BY m.member_id, m.first_name, m.last_name
ORDER BY registration_count DESC
LIMIT 1;

SELECT m.member_id, m.first_name, m.last_name, COUNT(ca.member_id) AS registration_count
FROM members m
LEFT JOIN class_attendance ca ON m.member_id = ca.member_id
GROUP BY m.member_id, m.first_name, m.last_name
ORDER BY registration_count ASC
LIMIT 1;

SELECT 
    (COUNT(DISTINCT ca.member_id) * 100.0 / COUNT(DISTINCT m.member_id)) AS percentage_attended
FROM 
    members m
LEFT JOIN 
    class_attendance ca ON m.member_id = ca.member_id
AND 
    ca.attendance_status = 'Attended';


