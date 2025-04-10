# 1) 2019-06-30 기준 90일 이내의 모든 날을 리포팅해라
# 2) 해당날짜에 처음 로그인한 유저들의 수다.
# 이해 O / 직풀 O
# 배운내용
# 1. BETWEEN (A AND B) 는 A와 B를 0과 1로 바꾼후 보기 때문에 예상과 전혀 다른 결과가 나오니 주의
# 2. within 90 days > BETWEEN DATE_SUB('2019-06-30', INTERVAL 90 DAY) AND '2019-06-30'
SELECT
    activity_date AS login_date,
    COUNT(user_id) AS user_count
FROM (
SELECT *
    , ROW_NUMBER() OVER (PARTITION BY user_id, activity ORDER BY activity_date ) AS 'date_rank'
FROM Traffic
WHERE activity = 'login'
) A
WHERE (date_rank = 1) AND (activity_date BETWEEN DATE_SUB('2019-06-30', INTERVAL 90 DAY) AND '2019-06-30')
GROUP BY activity_date
