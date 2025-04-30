# A,B를 산 고객들의 이름과 id를 보고 해라. 그러나 C를 사지말아야한다. C를 추천하고 싶기 떄문.
# customer_id로 오름차순해라
# 이해 O / 직풀 O /23분
# 이번 예시처럼 product_id의 A,B를 모두 포함하는, 같은 열에 조건을 두개 걸어야 하는 경우
# 단순히 WHERE문으로 해결이 불가능하다.
# 이때 HAVING SUM(product_name) > 0 AND SUM(product_name) > 0 AND SUM(product_name) = 0 을 활용한다.

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
WHERE sum = 2 AND (product_name = 'A' OR product_name = 'B')
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