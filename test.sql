WITH T1 AS (
SELECT 
    se.student_id, 
    si.date_registered,
    MIN(se.date_watched) as first_date_watched,
    MIN(sp.date_purchased) as first_date_purchased,
    TIMESTAMPDIFF(DAY, si.date_registered, MIN(se.date_watched)) as date_diff_reg_watch,
    TIMESTAMPDIFF(DAY, MIN(se.date_watched), MIN(sp.date_purchased)) as date_diff_watch_purch

FROM 
    db_course_conversions.student_info as si
LEFT JOIN 
    db_course_conversions.student_engagement as se ON si.student_id = se.student_id
LEFT JOIN 
    db_course_conversions.student_purchases as sp ON se.student_id = sp.student_id
GROUP BY 
    si.student_id, si.date_registered
HAVING 
    se.student_id IS NOT NULL AND (date_diff_watch_purch >= 0 OR date_diff_watch_purch IS NULL))

SELECT (SELECT COUNT(first_date_watched) FROM T1 WHERE first_date_purchased IS NOT NULL)/COUNT(first_date_watched) AS Conversion_rate,
		AVG(date_diff_reg_watch) as av_reg_watch,
        AVG(date_diff_watch_purch) as av_watch_purch
FROM T1 


