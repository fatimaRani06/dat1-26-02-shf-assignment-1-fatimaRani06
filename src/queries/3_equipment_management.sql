.open fittrackpro.db
.mode column

3.1
SELECT equipment_id, name, next_maintenance_date
FROM equipment
WHERE next_maintenance_date BETWEEN CURRENT_DATE AND  DATE(CURRENT_DATE, '+30 days');
3.2
SELECT type AS 'Equipment Type', COUNT(type) AS 'Type Count'
FROM equipment
GROUP BY type;
3.3
SELECT type as 'Equipment Type', AVG(julianday(CURRENT_DATE) - julianday(purchase_date)) AS avg_age_days
FROM equipment
GROUP BY type;


