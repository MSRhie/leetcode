# 1. 2019-08-16 기준 이전 날짜 필터 -> 해당 날짜의 product id set A
# 2. 전체 product들 중 16일 가격 변동 이력이 있는 set A외 product id set B
# 3. 1와 2외의 product_id가 set C

WITH Set_A AS(
SELECT
    DISTINCT
    product_id,
    MAX(new_price) OVER (PARTITION BY product_id ORDER BY change_date DESC) AS price
FROM Products
WHERE '2019-08-16' >= change_date
)
SELECT
    DISTINCT
    IF(B.product_id IS NULL, A.product_id, B.product_id) AS product_id,
    IF(B.price IS NULL, 10, B.price) AS price
FROM Products A
LEFT OUTER JOIN Set_A B ON A.product_id = B.product_id
