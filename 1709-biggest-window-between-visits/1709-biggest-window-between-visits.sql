# Write your MySQL query statement below
# 오늘날짜 2021-1-1
# user_id별로 각 방문일자에서 마지막으로 방문일이 가장 긴 window를 찾아라
# (오늘방문, 다음날 방문이 없담 당일)
# 풀이 X 시간초과
SELECT user_id, MAX(diff) AS biggest_window
FROM
(
	SELECT user_id, 
	   DATEDIFF(LEAD(visit_date, 1, '2021-01-01') OVER (PARTITION BY user_id ORDER BY visit_date), visit_date) AS diff
	FROM userVisits
) a
GROUP BY user_id
ORDER BY user_id