# 1) 주문일과 고객 희망 배달이리 같다면, 주문을 immediate 로, 그렇지않으면 scheduled로 둔다.
# 2) 고객이 첫 주문 중 immediate인 비율을 구해라 AS immediate_percentage
# 3) 설계 
 -- customer_id 별 delivery_id, order_date별 오름차순 정렬
 -- 이 중 order_date와 customer_pref_delivery_date 차이가 = 0 
with temp_delivery AS (
    SELECT
        * ,
        CASE 
            WHEN customer_pref_delivery_date - order_date = 0
            THEN 'immediate'
            ELSE 'scheduled'
        END AS order_finished ,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date, customer_id) AS 'number_row'
    FROM Delivery
)
SELECT ROUND(SUM(CASE WHEN order_finished = 'immediate' THEN 1 ELSE 0 END) / COUNT(order_finished) * 100, 2)  AS 'immediate_percentage'
FROM temp_delivery
WHERE number_row = 1

