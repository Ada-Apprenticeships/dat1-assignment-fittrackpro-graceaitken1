-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;
-- Equipment Management Queries

-- 1. Find equipment due for maintenance
SELECT equipment_id, 
       name, 
       type, 
       last_maintenance_date, 
       next_maintenance_date
FROM equipment
WHERE next_maintenance_date <= date('now');

SELECT type, COUNT(*) AS count
FROM equipment
GROUP BY type;

SELECT type, AVG (julianday('now') - julianday(purchase_date)) AS ave_age_days
FROM equipment 
GROUP BY type;
