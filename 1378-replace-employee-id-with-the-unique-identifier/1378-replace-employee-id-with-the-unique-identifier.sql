# Write your MySQL query statement below

SELECT unique_id, name
FROM Employees AS A
LEFT JOIN EmployeeUNI AS B
ON A.id = B.id
