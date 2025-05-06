# Write your MySQL query statement below
# 적어도 5번 직접 보고된 매니저들을 찾아라
# managerId별 id가 최소 5번 이상 카운트 되는 managerId를 찾아라.

SELECT
    B.name
FROM Employee A
INNER JOIN Employee B ON A.managerId = B.id
GROUP BY B.id 
HAVING COUNT(B.id) >= 5