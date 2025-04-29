
# 이해 O / 직풀 X / 1시간
# 동일한 id간 직,간접의 수를 카운트 할 시,
# 전체에서 INNER JOIN으로 하나하나 조건을 걸어 행을 제거
SELECT
    e1.employee_id
FROM Employees e1
INNER JOIN Employees e2 ON e1.manager_id = e2.employee_id
INNER JOIN Employees e3 ON e2.manager_id = e3.employee_id
WHERE e3.manager_id = 1 AND e1.employee_id <> 1