# 1) 유저별로 3일간의 이동평균을 계산해라.
# 2) 각날마다 연속된 3일에 대해 계산된다.
# 이해 O / 직풀 x / 재도전 필요
-- WITH consecutive_3days AS
-- (
-- SELECT
--     user_id,
--     steps_date,
--     IF(lag_steps_data IS NULL, 1 ,steps_date-lag_steps_data) AS diff_date,
--     rolling_average,
--     SUM(steps_date-lag_steps_data) OVER (PARTITION BY user_id ORDER BY user_id, steps_date) AS sum_diff
-- FROM (
-- SELECT
--     user_id,
--     steps_date,
--     LAG(steps_date) OVER (PARTITION BY user_id ORDER BY user_id, steps_date) AS 'lag_steps_data',
--     AVG(steps_count) OVER (PARTITION BY user_id ORDER BY user_id, steps_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 'rolling_average'
-- FROM Steps
-- ) A
-- ), Rank_user_filter AS (
-- SELECT
--     *,
--     RANK() OVER (PARTITION BY user_id ORDER BY steps_date DESC) AS 'rank_sum_diff'
-- FROM consecutive_3days
-- WHERE diff_date <= 1 AND sum_diff  >= 2 # 1일 날짜 차이가 나며 AND 1일 날짜차이가 3일 연속차이일때 (lag 계산으로 3이아닌 2)
-- ORDER BY user_id, steps_date
-- )
-- SELECT
--     user_id,
--     steps_date,
--     ROUND(rolling_average, 2) AS rolling_average
-- FROM Rank_user_filter
-- WHERE rank_sum_diff <=2

select user_id, steps_date, rolling_average
from (
    select user_id, steps_date,
    round(avg(steps_count) over (partition by user_id order by steps_date rows between 2 preceding and current row), 2) as rolling_average,
    lag(steps_date, 2) over (partition by user_id order by steps_date) as two_dates_before
    from steps
) tmp
where datediff(steps_date, two_dates_before) = 2 # 두날짜 차이는 DATEDIFF 조건으로 해결
order by 1, 2
;