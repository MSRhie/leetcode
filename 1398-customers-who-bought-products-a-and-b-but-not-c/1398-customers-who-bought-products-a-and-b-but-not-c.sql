# A,B를 산 고객들의 이름과 id를 보고 해라. 그러나 C를 사지말아야한다. C를 추천하고 싶기 떄문.
# customer_id로 오름차순해라
WITH base AS
(
SELECT
    customer_id
FROM (
SELECT
    customer_id,
    product_name,
    COUNT(order_id),
    SUM(COUNT(order_id)) OVER (PARTITION BY customer_id ORDER BY product_name) AS 'sum'
FROM Orders
GROUP BY customer_id, product_name
) A
WHERE sum = 2
)
SELECT
    DISTINCT
    A.customer_id,
    B.customer_name
FROM Orders AS A
LEFT JOIN Customers AS B ON A.customer_id = B.customer_id
INNER JOIN base AS C ON  A.customer_id = C.customer_id
WHERE 
(A.customer_id) NOT IN (
SELECT
    customer_id
FROM Orders
WHERE product_name = 'C'
)