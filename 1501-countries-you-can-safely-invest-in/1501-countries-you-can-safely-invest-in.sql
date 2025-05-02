# 평균 전화 통화 기간이 전세계 평균보다 매우 커야 한다.
# 이 회사가 투자할 나라를 찾아라.
# 전화를 건사람/ 한사람의 평균 > 
SELECT
 co.name AS country
FROM
 person p
 JOIN
     country co
     ON SUBSTRING(phone_number,1,3) = country_code
 JOIN
     calls c
     ON p.id IN (c.caller_id, c.callee_id)
GROUP BY
 co.name
HAVING
 AVG(duration) > (SELECT AVG(duration) FROM calls)