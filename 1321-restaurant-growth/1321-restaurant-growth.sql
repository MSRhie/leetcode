# 1. amount 변수의 7일간의 이동평균을 계산해라. average_amount
# 2. Visited_on으로 오름차순으로 계산해라.
# 3. 이해 O / 스스로풀이 x 

WITH temp_customer AS
(
SELECT
    visited_on,
    SUM(amount) AS daily_amount
FROM Customer
GROUP BY visited_on
)
SELECT visited_on, amount, ROUND(average_amount, 2) AS average_amount
FROM (
SELECT 
    visited_on,
    SUM(daily_amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS 'amount',
    AVG(daily_amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS 'average_amount',
    COUNT(visited_on) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS 'cnt'
FROM temp_customer AS A
) AS C
WHERE cnt = 7