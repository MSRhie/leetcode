# id는 친구의 id이고 PK이다.
# acticity는 친구가 참가한 활동 이름이다.

# 솔루션
# 1) 최고나 최저가 아닌 참가자수를 가진 활동수를 찾아라.
# 2) 각 Acticities의 활동테이블은 Friends 테이블의 어떤사람이든 수행한 것이다.
# 이해O / 직풀 O / 16분
# HAVING에서는 중복 집계함수 사용이 안됨.ex. HAVING MAX(COUNT())
# > COUNT(*) 하고 (SELECT ~ FROM ~ GROUP BY ~ ORDER BY ~ LIMIT 1) 처럼 MAX()함수를 일일이 코딩해야함.
SELECT
    DISTINCT
    activity
FROM
(
SELECT
    activity,
    COUNT(activity) AS CNT,
    MAX(COUNT(activity)) OVER () AS 'max_cnt',
    MIN(COUNT(activity)) OVER () AS 'min_cnt'
FROM Friends
GROUP BY activity
) A
WHERE CNT <> max_cnt AND CNT <> min_cnt
