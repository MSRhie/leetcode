# 버스에 타기위해 기다리는 사람들의 수이다.
# 버스는 1000 킬로그램 제한이있음
# 몇 사람은 버스 못탐
# 무게 초과없이 버스에 핏할 수 있는 마지막 사람의 이름을 찾아라.

SELECT
    person_name
FROM
(
SELECT
    *,
    SUM(weight) OVER (ORDER BY turn) AS 'sum_weight'
FROM Queue
) A
WHERE sum_weight <= 1000
ORDER BY sum_weight DESC
LIMIT 1

# 푼시간 6분 30초
