# 1) 각 부서별로 가장 높은 연봉을 받는 사람을 출력해라. (동일연봉이면 같이 출력)
WITH temp_employee AS (
SELECT
    departmentId,
    name,
    salary,
    DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS 'salary_dense'
FROM Employee
)
SELECT B.name AS 'Department', A.name AS 'Employee', A.salary
FROM temp_employee AS A
LEFT JOIN Department AS B ON A.departmentId = B.id
WHERE salary_dense = 1