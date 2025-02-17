-- Initial SQLite setup
.open fittrackpro.db
.mode column
.mode box

-- Enable foreign key support
PRAGMA foreign_key = ON;
-- Membership Management Queries

SELECT m.member_id, 
       m.first_name, 
       m.last_name, 
       ms.type AS membership_type,
       m.join_date
FROM members m
JOIN memberships ms ON m.member_id = ms.member_id
WHERE ms.status = 'Active';

SELECT ms.type AS membership_type,
       AVG(julianday(a.check_out_time) - julianday(a.check_in_time)) * 24 * 60 AS avg_visit_duration_minutes
FROM memberships ms
JOIN members m ON ms.member_id = m.member_id
JOIN attendance a ON m.member_id = a.member_id
GROUP BY ms.type;

SELECT m.member_id, 
       m.first_name, 
       m.last_name, 
       m.email, 
       ms.end_date
FROM members m
JOIN memberships ms ON m.member_id = ms.member_id
WHERE ms.end_date
BETWEEN DATE('now') AND DATE('now', '+1 year');
