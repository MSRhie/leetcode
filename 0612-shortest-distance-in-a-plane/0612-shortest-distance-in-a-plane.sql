# Point2D테이블에서 가장 짧은 거리의 두점 사이의 거리를 구하고 2번째 자리에서 반올림해라
# 이때 중복 점은 없다 -> 거리가 0인건 없다.
# 이해 O / 직풀 O / 23분 소요
# > CROSS JOIN에서 모든 경우의 수를 엮을시 ON 생략도 가능하다.
SELECT
    MIN(shortest) AS shortest
FROM
(
SELECT
    A.x AS A_X,
    A.y AS A_Y,
    B.x AS B_X,
    B.y AS B_Y,
    ROUND(SQRT(POWER(B.x-A.x, 2) + POWER(B.y-A.y, 2)),2) AS shortest
FROM Point2D AS A
CROSS JOIN POint2D AS B 
) A
WHERE shortest <> 0