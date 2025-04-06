-- 1. find the prices of all products on 2019-08-16
-- 2. Assume the price befor any change is 10 (defult)
WITH temp_data AS (
        SELECT
            product_id,
            new_price,
            change_date,
            ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY product_id, change_date desc) AS 'product_number'
        FROM Products
        WHERE DATE_FORMAT(change_date, '%Y-%m-%d') <= DATE_FORMAT('2019-08-16', '%Y-%m-%d')
)
SELECT DISTINCT A.product_id, 
    COALESCE(B.new_price, 10) AS price
FROM Products AS A
LEFT JOIN temp_data AS B ON A.product_id = B.product_id AND B.product_number = 1
