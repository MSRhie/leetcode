# 2019-08-16 날짜의 모든 제품들의 가격을 찾아라. 단, 모든 제품들의 가격은 변화하기전 가격은 10으로 가정한다.
# 2019-08-16 이전의 product_id값이 포함안될 수 있으므로, product_id기준과 change_date 2019-08-16을 기준으로 product_id가 유닉한 A LEFT self join A'한다.
# A'의 product_id별 new_price의 마지막 날짜 값을 구한다.
# A'의 product_id가 NULL이면 10의 값을 대입한다.
WITH key_table AS
(
SELECT
    DISTINCT
    product_id
FROM Products
)
SELECT
    A.product_id,
    IFNULL(new_price,10) AS price
FROM key_table A
LEFT JOIN Products B ON A.product_id = B.product_id
AND (A.product_id, B.change_date) IN (SELECT product_id, MAX(change_date) FROM Products WHERE change_date <= '2019-08-16' GROUP BY product_id)