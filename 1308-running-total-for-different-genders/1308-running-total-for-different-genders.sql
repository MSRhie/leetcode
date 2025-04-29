# 솔루션
# 각 날별로 각 성별별 전체 총합계를 구해라.

SELECT
    gender,
    day,
    SUM(score_points) OVER (PARTITION BY gender ORDER BY day)AS 'total'
FROM Scores
GROUP BY gender, day
ORDER BY gender, day
