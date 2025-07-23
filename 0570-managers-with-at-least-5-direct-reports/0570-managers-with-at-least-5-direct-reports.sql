# 직접 manager에게 5번 리포트를 보낸 매니저들을 찾아라.


SELECT name
FROM Employee AS A
INNER JOIN (
SELECT managerId
FROM Employee
GROUP BY managerId
HAVING COUNT(managerId) >= 5
) AS B ON A.id = B.managerId