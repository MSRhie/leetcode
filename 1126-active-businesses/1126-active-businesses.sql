# business_id, event_type 의 조합이 primary key
# 각행은 많은 수에 대해 몇몇 비즈니스가 발생되는 몇몇 타입의 이벤트에 대한 정보로그이다.
# 솔루션
# 1) event_type에 대한 average activity는 이 이벤트를 가지는 모든 회사들에 걸치는 평균 발생이다.
# 2) average businesses는 하나이상의 event_type을 가진다. 이러한 그들의 occurrences는 엄밀히 이벤트에 대한 average activity보다 더 크다.
# 3) 모든 active businesses에 대해 찾아라.
# > 각 event_type의 평균 occurrences보다 큰 개별 business_id를 찾아라.
SELECT
    DISTINCT
    business_id
FROM Events AS A
INNER JOIN 
(
SELECT
    event_type,
    AVG(occurrences) AS avg_occ
FROM Events
GROUP BY event_type
) AS B
ON A.event_type = B.event_type AND B.avg_occ < A.occurrences
GROUP BY business_id
HAVING COUNT(business_id) >= 2