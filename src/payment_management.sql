-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;
-- Payment Management Queries

INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES (11, 50.00, datetime('now'), 'Credit Card', 'Monthly membership fee');


SELECT strftime('%Y-%m', payment_date) AS month, 
       SUM(amount) AS total_revenue
FROM payments
WHERE payment_date >= date('now', '-1 year')
GROUP BY month
ORDER BY month;

SELECT payment_id,
amount,
payment_date,
payment_method
FROM payments
WHERE payment_type = 'Day pass';