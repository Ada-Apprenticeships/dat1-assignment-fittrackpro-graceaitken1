-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;
-- Membership Management Queries

-- 1. List all active memberships
SELECT m.member_id, 
       m.first_name, 
       m.last_name, 
       m.email, 
       m.join_date, 
       m.membership_type, 
       m.membership_status
FROM members m
WHERE m.membership_status = 'Active';

-- 2. Calculate the average duration of gym visits for each membership type
SELECT m.membership_type, 
       AVG(julianday(ca.check_out_time) - julianday(ca.check_in_time)) AS avg_duration
FROM members m
JOIN check_ins_outs ca ON m.member_id = ca.member_id
GROUP BY m.membership_type;

-- 3. Identify members with expiring memberships this year
SELECT m.member_id, 
       m.first_name, 
       m.last_name, 
       m.email, 
       m.join_date, 
       m.membership_type, 
       m.membership_status
FROM members m
WHERE m.join_date <= date('now', '-1 year')
AND m.membership_status = 'Active';
