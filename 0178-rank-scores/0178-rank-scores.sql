# 1) 점수 랭크는 가장 높은 값에서 낮은 순으로
# 2) 두 점수간 중복이 발생하면 두 점수는 같은 랭크를 가진다.
# 3) 중복 이후 다음 랭킹 은 다음의 연속적 정수 값을 가진다. 랭크간 빈 구멍은 없다.
# score 이름으로 내림차순으로 정렬해라.
# 이해 O / 직풀 O


SELECT
    Score,
    DENSE_RANK() OVER (ORDER BY score DESC) AS 'rank'
FROM Scores
ORDER BY Score DESC
