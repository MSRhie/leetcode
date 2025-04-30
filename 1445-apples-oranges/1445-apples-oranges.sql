# apples와 oranges가 판매된 각날마다의 차이값을 계산해라
# sale_date으로 sorting해라

WITH base AS 
(
SELECT
    sale_date,
    fruit,
    MAX(SUM_sold_num) AS 'max_sold'
FROM(
SELECT
    sale_date,
    fruit,
    SUM(sold_num) OVER (PARTITION BY sale_date, fruit ORDER BY sale_date) AS 'SUM_sold_num'
FROM Sales
) A
GROUP BY sale_Date, fruit
)
SELECT
    *
FROM (
SELECT
    sale_date,
    LAG(max_sold) OVER (PARTITION BY sale_date ORDER BY fruit) - max_sold AS 'diff'
FROM base
) A
WHERE diff IS NOT NULL