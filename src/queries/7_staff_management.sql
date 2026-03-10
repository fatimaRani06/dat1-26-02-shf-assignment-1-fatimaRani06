.open fittrackpro.db
.mode column

-- 7.1 
SELECT staff_id, first_name AS 'First Name', last_name AS 'Last Name', position
FROM staff
ORDER BY position;

-- 7.2
INSERT INTO personal_training_sessions (member_id, staff_id, session_date, start_time, end_time, notes)
SELECT 1, 1, '2025-03-10', '08:00:00', '09:00:00', 'Test session for query 2'
WHERE NOT EXISTS (
    SELECT 1
    FROM personal_training_sessions
    WHERE member_id = 1
    AND staff_id = 1
    AND session_date = '2025-03-10'
); 

SELECT s.staff_id AS 'trainer_id', s.first_name || ' ' || s.last_name AS 'trainer_name', COUNT(t.session_id) AS 'session_count'
FROM personal_training_sessions t
JOIN staff s ON t.staff_id = s.staff_id
WHERE t.session_date BETWEEN CURRENT_DATE AND DATE(CURRENT_DATE, '+30 days')
GROUP BY s.staff_id
HAVING session_count > 0; 


