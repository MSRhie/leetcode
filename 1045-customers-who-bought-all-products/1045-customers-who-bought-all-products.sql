# 1. Product 테이블에서 모든 제품들을 산 Customer 테이블로부터 customer ids를 보고해라.
# 2. 정렬은 디폴트로

SELECT
    customer_id
FROM
(
SELECT
    customer_id,
    COUNT(customer_id) AS cnt_customer,
    COUNT(DISTINCT P.product_key) AS cnt_product
FROM Customer AS C
CROSS JOIN Product AS P
ON C.product_key = P.product_key
GROUP BY customer_id
) A
WHERE cnt_product = (
                        SELECT COUNT(DISTINCT product_key)
                        FROM Product
                    )



