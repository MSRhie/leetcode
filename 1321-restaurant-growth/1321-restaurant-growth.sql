# 최소한 한명이상의 고객들이 온다
# 7일 간격의 이동평균을 구해라. (현재일 + 6일)
WITH sum_amount_DF AS
(
    SELECT 
        visited_on,
        amount,
        SUM(amount) AS sum_amount,
        SUM(1) OVER(ORDER BY visited_on) AS ID
    FROM Customer
    GROUP BY visited_on
)
SELECT
    visited_on,
    amount,
    average_amount
FROM (
SELECT
    ID,
    visited_on,
    SUM(sum_amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW ) AS amount,
    ROUND(AVG(sum_amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW ), 2) AS average_amount
FROM sum_amount_DF
ORDER BY visited_on
) A
WHERE ID >= 7