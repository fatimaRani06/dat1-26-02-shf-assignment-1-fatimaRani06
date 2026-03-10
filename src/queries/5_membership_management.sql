.open fittrackpro.db
.mode column

-- 5.1 
SELECT * 
FROM memberships 
WHERE status = 'Active' 
ORDER BY type;

-- 5.2
SELECT 
    m.type AS membership_type, 
    ROUND(AVG((JULIANDAY(a.check_out_time) - JULIANDAY(a.check_in_time)) * 1440), 2) --24 hours * 60 minutes rounded to 2.d.p
    AS avg_visit_duration_minutes
FROM attendance a
JOIN memberships m ON a.member_id = m.member_id
GROUP BY m.type;

-- 5.3
SELECT first_name, last_name, email
FROM members m 
JOIN memberships ms ON m.member_id = ms.member_id
WHERE strftime('%Y', ms.end_date) =  strftime('%Y', 'now'); 


