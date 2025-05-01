# 이해 O / 직풀 O / 24분
SELECT
    A.id AS P1,
    B.id AS P2,
    ABS(A.x_value - B.x_value) * ABS(A.y_value - B.y_value) AS Area
FROM Points AS A
INNER JOIN Points  AS B ON A.id < B.id
WHERE ABS(A.x_value - B.x_value) * ABS(A.y_value - B.y_value) > 0
ORDER BY area DESC, p1, p2