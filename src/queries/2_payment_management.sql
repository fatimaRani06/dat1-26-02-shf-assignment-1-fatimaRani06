.open fittrackpro.db
.mode column

-- 2.1 
INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
SELECT 11, 50.00, CURRENT_TIMESTAMP, 'Credit Card', 'Monthly membership fee'
WHERE NOT EXISTS (
    SELECT 1 
    FROM payments 
    WHERE member_id = 11 
    AND DATE(payment_date) = CURRENT_DATE
); 

-- 2. 
Calculate total revenue from membership fees for each month of the 4 months (from November 2024 - Feb 2025)
SELECT 
    strftime('%Y-%m', payment_date) AS Month, 
    SUM(amount) AS 'Total Revenue'
FROM payments
WHERE payment_type = 'Monthly membership fee'
AND payment_date BETWEEN '2024-11-01 00:00:00' AND '2025-02-28 23:59:59'
GROUP BY Month
ORDER BY Month;

-- 3. 
Find all day pass purchases
SELECT payment_id, amount, payment_date, payment_method
FROM payments 
WHERE payment_type = 'Day pass'
GROUP BY payment_date
ORDER BY payment_method;


