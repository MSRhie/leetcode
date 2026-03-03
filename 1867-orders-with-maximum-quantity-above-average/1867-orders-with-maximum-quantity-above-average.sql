# Write your MySQL query statement below

WITH calculate_df AS (

    SELECT
        order_id
        ,AVG(quantity) AS avg_quantity
        ,MAX(quantity) AS max_quantity
     FROM OrdersDetails
    GROUP BY order_id
), calculate_df2 AS (
    SELECT
        order_id
        ,MAX(avg_quantity) OVER() AS max_avg_quantity      
    FROM calculate_df
    GROUP BY order_id
), dcalculate_df3 AS (
SELECT
    DISTINCT
    A.order_id
    ,CASE
        WHEN max_quantity > max_avg_quantity THEN 1
        ELSE 0
    END AS flag_result
FROM calculate_df AS A
LEFT JOIN calculate_df2 AS B ON A.order_id = B.order_id
HAVING flag_result = 1
)
SELECT
    order_id
FROM dcalculate_df3
