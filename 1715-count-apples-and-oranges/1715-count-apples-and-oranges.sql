# Write your MySQL query statement below


SELECT
    SUM(sum_apples) AS 'apple_count',
    SUM(sum_oranges) AS 'orange_count'
FROM
(
SELECT
    box_id,
    B.chest_id,
    COALESCE(B.apple_count, 0) + COALESCE(C.apple_count, 0) AS 'sum_apples',
    COALESCE(B.orange_count, 0) + COALESCE(C.orange_count, 0) AS 'sum_oranges'
FROM Boxes B
LEFT JOIN Chests C
ON B.chest_id = C.chest_id
) A