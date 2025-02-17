-- Initial SQLite setup
.open fittrackpro.db
.mode column
.mode box

-- Enable foreign key support
PRAGMA foreign_key = ON;
-- Equipment Management Queries

SELECT equipment_id, 
       name, 
       next_maintenance_date
FROM equipment
WHERE next_maintenance_date <= date('now');

SELECT type AS equipment_type, COUNT(*) AS count
FROM equipment
GROUP BY type;

SELECT type AS equipment_type, 
       AVG(julianday('now') - julianday(purchase_date)) AS ave_age_days
FROM equipment 
GROUP BY type;