# Orders 테이블에 같은 유저가 하나 이상 같은날 제품을 주문한 적이 없다.
# 각 제품별로 가장 최근 주문한 것들을찾아라.
# product_name이 오름차순이고, 같은 수준이면 product_id로 오름차순해라. 그래도 동등하다면 order_id로 내림차순해라.
# 이해O/ 직풀 O
SELECT
    A.product_name,
    A.product_id,
    A.order_id,
    A.order_date
FROM (
SELECT
    DENSE_RANK() OVER (PARTITION BY A.product_id ORDER BY A.order_date DESC) AS 'rk',
    B.product_name,
    B.product_id,
    A.order_id,
    A.order_date
FROM Orders AS A
LEFT JOIN Products AS B ON A.product_id = B.product_id
) A
WHERE rk = 1
ORDER BY A.product_name, A.product_id, A.order_id