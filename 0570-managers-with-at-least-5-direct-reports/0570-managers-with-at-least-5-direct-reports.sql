# Write your MySQL query statement below

SELECT name
FROM Employee AS A
INNER JOIN (
    SELECT managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(managerId) >= 5
) B
ON A.id = B.managerId
