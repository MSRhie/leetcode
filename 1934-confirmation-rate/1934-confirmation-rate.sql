# 1. confirmed messages divided by
#  1) total number of requested confirmation messages
#  2) user that didn't requet any confirmation messages is 0
# 2. Round the confirmatio nrate to TWO DECIMAL places.

with confirm_user AS
(   SELECT  ROUND(SUM_confirm / (SUM_timeout + SUM_confirm), 2) AS con_rate,
            C.user_id
    FROM (
    SELECT
        SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) AS SUM_confirm , 
        SUM(CASE WHEN action = 'timeout' THEN 1 ELSE 0 END) AS SUM_timeout ,
        user_id
    FROM confirmations
    GROUP BY user_id
    ) AS C 
)
SELECT DISTINCT A.user_id, COALESCE(con_rate, ROUND(0, 2)) AS confirmation_rate 
FROM Signups AS A
LEFT JOIN confirm_user AS B ON A.user_id = B.user_id