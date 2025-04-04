-- 1. who earns the most money in each of the company's departement.
-- 2. find employees who are high earners in each of the departments.
-- 3. any order

SELECT C.Department,
    C.Employee,
    C.Salary
FROM
    (SELECT
        B.name AS Department,
        A.name AS Employee,
        A.salary AS Salary,
        DENSE_RANK() OVER(PARTITION BY B.name ORDER BY A.Salary DESC) AS 'Row_number' -- Must be being quotation
    FROM Employee AS A
    LEFT JOIN Department AS B ON A.departmentId = B.id) C
WHERE C.Row_number <= 3

