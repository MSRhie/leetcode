# Write your MySQL query statement below
SELECT A.id
FROM weather A
JOIN weather B
ON DATEDIFF(A.recordDate, B.recordDate) = 1
WHERE A.temperature > B.temperature