.open fittrackpro.db
.mode column

-- 8.1 
SELECT pt.session_id,  COALESCE(m.first_name || ' ' || m.last_name, 'Member not assigned') AS 'member_name', pt.session_date, pt.start_time, pt.end_time
-- COALESCE(s.first_name || ' ' || s.last_name, 'Trainer not assigned') AS 'trainer_name' --optional 
FROM personal_training_sessions pt
LEFT JOIN members m 
ON pt.member_id = m.member_id
LEFT JOIN staff s 
ON pt.staff_id = s.staff_id
WHERE s.first_name = 'Ivy' AND s.last_name = 'Irwin';


SELECT pt.session_id, COALESCE(m.first_name || ' ' || m.last_name, 'Member not assigned') AS 'member_name', pt.session_date, pt.start_time, pt.end_time --added in edge case of member not being assigned to a session e.g. cancelled
FROM personal_training_sessions pt
LEFT JOIN members m 
ON pt.member_id = m.member_id
LEFT JOIN staff s 
ON pt.staff_id = s.staff_id
WHERE s.first_name = 'Liam' AND s.last_name = 'Harris';
