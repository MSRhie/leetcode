# 1) Orders 테이블은 어떠한 고객도 동일한 제품을 하루에 하나이상 주문하지 않음.
# 2) 고객별로 가장 빈번하게 주문된 제품들을 찾아라
-- 하나 주문 했다면 한 고객에 여러 제품이 여러 행에 걸쳐서 출력됨.
-- 가장 빈번하게 > product_id가 count되어 가장 큰 값
# 3) 결과 테이블은 최소 한번 이상 주문한 cusotmer_id별 product_id와 product_name가 결과여야 한다.
# 4) any order로 결과를 내라.
SELECT customer_id, A.product_id, B.product_name
FROM (
    SELECT
    customer_id,
    product_id,
    COUNT(product_id) AS cnt_product_id,
    MAX(COUNT(product_id)) OVER (PARTITION BY customer_id) AS 'cnt_max'
    FROM Orders
    GROUP BY customer_id, product_id
) AS A
LEFT JOIN Products AS B ON A.product_id = B.product_id
WHERE cnt_product_id = cnt_max


