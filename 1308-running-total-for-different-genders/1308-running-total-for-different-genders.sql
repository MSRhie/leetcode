# 솔루션
# 각 날별로 각 성별별 전체 총합계를 구해라.
# 이해 O / 직풀 O / 3분
# 누적합 계산은 SUM() OVER (PARTITION BY ~ ORDER BY ~)
SELECT
    gender,
    day,
    SUM(score_points) OVER (PARTITION BY gender ORDER BY day)AS 'total'
FROM Scores
GROUP BY gender, day
ORDER BY gender, day
