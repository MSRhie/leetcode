# 1) 1000 킬로그램의 무게재한 버스가 있다.
# 2) 무게가 초과되어 버스에 탑승불가한 마지막 사람의 person_name을 출력해라.
# - 첫번째 사람부터 무게가 초과될 수 있다.
# - turn이 탑승 순서이다.
# 누적 합
WITH sum_table AS
(
SELECT
    turn,
    person_name,
    SUM(weight) OVER (ORDER BY turn) AS 'sum_weight'
FROM Queue
ORDER BY turn
)
SELECT A.person_name
FROM (
SELECT person_name,
        sum_weight
FROM sum_table
WHERE sum_weight <= 1000
) AS A
ORDER BY A.sum_weight DESC
LIMIT 1