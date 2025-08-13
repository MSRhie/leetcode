# 각 부서들에서 가장높은 연봉을 받는 직원들을 찾아라

SELECT
    B.name AS Department,
    A.name AS Employee,
    salary
FROM Employee A
LEFT JOIN Department B
ON A.departmentId = B.id
WHERE (departmentId, salary) IN (
    SELECT departmentId, MAX(salary)
    FROM Employee
    GROUP BY departmentId
)

# 문제 품 / 시간 못젬
