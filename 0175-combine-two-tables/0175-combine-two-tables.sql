# Write your MySQL query statement below
SELECT B.firstName, B.lastName, A.city, A.state
FROM Person AS B
LEFT JOIN Address AS A
ON A.personID = B.personId

