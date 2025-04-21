# 1. Action 테이블은 중복 행이 있음. action컬럼엔 view, like, reaction ,comment 값이 있음. 다른컬럼들은 action에 대한 추가 정보임.
# 즉, 이 엑션을 했을 떄의 이유 등
# 2. 이 테이블의 각 행은 몇몇 포스터들이 제거되었다. 제보되거나 관리자 검토의 결과의 이유로.
# 문제 
# spam으로 제보된 후 제거된 포스터들의 일평균 퍼센테이지를 구해라. 둘째자리에서 반올림 해라.

# Removals 테이블의 remove_date가 Actions테이블보다 이후에 일어남.
# action에서 report, extra가 spam인 전체 수가 분모, removals에 포함된게 분자
# 이해 O / 직풀 X
-- SELECT 
--     ROUND(AVG(percent_spam) * 100,2) AS 'average_daily_percent'
-- FROM (
-- SELECT
--     action_date,
--     SUM(IF(extra = 'spam', 1, 0)) AS 'sum_spam',
--     SUM(IF(extra = 'spam' AND B.post_id IS NOT NULL, 1, 0)) AS 'sum_revocals',
--     SUM(IF(extra = 'spam' AND B.post_id IS NOT NULL, 1, 0)) / SUM(IF(extra = 'spam', 1, 0)) AS 'percent_spam'
-- FROM Actions AS A
-- LEFT JOIN Removals AS B ON A.post_id = B.post_id
-- AND B.remove_date > A.action_date
-- GROUP BY action_date
-- ) A
select ROUND(sum(daily_avg)/count(date)*100,2) as average_daily_percent FROM
(select 
    t.action_date as date,
    (count(distinct case when remove_date is not null then post_id else null end)/count(distinct post_id)) as daily_avg
FROM
(SELECT a.post_id, a.action_date, r.remove_date
from Actions a left join Removals r
on a.post_id = r.post_id
WHERE a.extra='spam') t
GROUP BY t.action_date) t2;