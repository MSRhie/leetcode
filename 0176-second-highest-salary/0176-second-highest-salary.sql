SELECT
    COALESCE(MAX(Salary)) AS SecondHighestSalary
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee)