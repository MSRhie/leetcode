# 기본 가격이 10
# 2019-08-16 기준으로 product_id별 가장 빠른 날짜의new_price를 가져와야 함

WITH new_price_df AS
(
SELECT
    *
FROM Products
WHERE (product_id, change_date) IN (
    SELECT
        product_id, MAX(change_date) AS max_change_date
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
)
), ex_id AS
(
SELECT
    DISTINCT
    product_id,
    10 AS ex_price 
FROM Products
)
SELECT
    e.product_id,
    IF(n.new_price IS NULL, ex_price, new_price) AS price
FROM ex_id AS e
LEFT JOIN new_price_df AS n
ON e.product_id = n.product_id