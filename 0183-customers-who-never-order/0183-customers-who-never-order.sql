SELECT name AS 'Customers'
FROM Customers AS A
LEFT JOIN Orders AS B ON A.id = B.customerId
WHERE B.customerId IS NULL