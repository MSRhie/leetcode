# 가장 최근 각 유저들이 3번주문한 것을 찾아라. 만약 유저들이 3번이하로 주문하면, 그들의 주문들을 모두 리턴해라.

# customer_name으로 오름차순으로해라. customer_id별로., 동점ㅇ이면 order_date로 내림차순해라

SELECT
    name AS customer_name,
    A.customer_id,
    A.order_id,
    A.order_date
FROM 
( 
SELECT
    customer_id,
    order_id,
    order_date, 
    RANK() OVER (PARTITION BY customer_id ORDER BY order_date DESC ) AS 'rk'
FROM Orders
) A 
LEFT JOIN Customers AS B ON A.customer_id = B.customer_id
WHERE rk <= 3 
ORDER BY customer_name, customer_id, order_date DESC
