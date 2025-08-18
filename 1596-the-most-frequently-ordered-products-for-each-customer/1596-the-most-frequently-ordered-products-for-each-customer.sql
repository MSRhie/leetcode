# 각 고객들에서 가장 빈번하게 주문한 제품들을 찾아라
# 이 결과는 적어도 하나이상 주문한 customer_id별로 product_id, name을 포함한다.

# 단, 같은날 하나 이상 동일한 물건을 주문하지 않았다.

WITH temp_data AS
(
    SELECT
        customer_id,
        product_id,
        COUNT(product_id) OVER(PARTITION BY customer_id, product_id) AS cnt_customer_id
    FROM Orders
)
SELECT
    DISTINCT
    A.customer_id,
    p.product_id,
    p.product_name
FROM temp_data A
LEFT JOIN Customers c
ON A.customer_id = c.customer_id
LEFT JOIN Products p
ON A.product_id = p.product_id
WHERE (A.customer_id, cnt_customer_id) IN (
    SELECT 
        customer_id, MAX(cnt_customer_id)
    FROM temp_data
    GROUP BY customer_id
)
# 5분 초과 풀이 완