# 1. 2019-08-16 기준 이전 날짜 필터 -> 해당 날짜의 product id set A
# 2. 전체 product들 중 16일 가격 변동 이력이 있는 set A외 product id set B
# 3. 1와 2외의 product_id가 set C
WITH make_rank AS
(
    SELECT
        *,
        DENSE_RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS rank_id
    FROM Products
    WHERE change_date <= '2019-08-16'
)
SELECT
    DISTINCT
    IF(B.product_id IS NULL, A.product_id, B.product_id) AS product_id,
    IF(B.new_price IS NULL, 10, B.new_price) AS price 
FROM Products A 
LEFT OUTER JOIN (
                SELECT
                    *
                FROM make_rank
                WHERE rank_id = 1
                ) B
ON A.product_id = B.product_id
# 알게된 것
# 1. window 함수는 가장 마지막에 돌아감 > RANK에 영향을주는 ORDER BY를 WHERE문으로 줄때 해당 쿼리 내 삽입할 것