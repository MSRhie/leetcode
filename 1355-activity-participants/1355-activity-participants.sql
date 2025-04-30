# id는 친구의 id이고 PK이다.
# acticity는 친구가 참가한 활동 이름이다.

# 솔루션
# 1) 최고나 최저가 아닌 참가자수를 가진 활동수를 찾아라.
# 2) 각 Acticities의 활동테이블은 Friends 테이블의 어떤사람이든 수행한 것이다.


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
