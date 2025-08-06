# 선호 배달날짜가 다른 주문날짜와 같다면, immediate 로,
# 다른경우는 scheduled 로

# 고객의 첫번째 주문은 고객이 주문한 가장빠른날짜다. 이는 정확하게 하나의 첫주문 하나다.
# 고객들의 첫번째 주문들의 즉시의 비중을 찾고 두번째 자리에서 반올림 해라

SELECT
    ROUND(SUM(IF(delivery_day = 'immediate',1,0))/COUNT(delivery_Day)*100,2) AS 'immediate_percentage'
FROM
(
SELECT
    *,
    DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS customer_id_rank,
    CASE
        WHEN order_date = customer_pref_delivery_date THEN 'immediate'
        ELSE 'scheduled'
    END AS 'delivery_day'
FROM Delivery
) A
WHERE customer_id_rank = 1

# 푼시간 13분
# 배운내용 없음