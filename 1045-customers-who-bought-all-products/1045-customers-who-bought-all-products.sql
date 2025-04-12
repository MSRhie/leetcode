# 1) product 테이블에서 모든 제품들을 샀던 Customer 테이블의 ids를 찾아라
# 2) 모든 제품을 샀던 >product 테이블의 product_key의 하나 이상 값을 가지고 있다.
#  1. customer_id별 product 테이블의 product_key 갯수 카운트
#  2. product table의 product_key 갯수 카운트와 2를 비교 같은 행만 추출
# 오류 TEST 원인 분석
-- SELECT COUNT(DISTINCT product_key) -- 17
-- FROM Product

-- SELECT
--     customer_id,
--     #COUNT(DISTINCT A.product_key), -- 17
--     COUNT(product_key) OVER(PARTITION BY customer_id) AS 'cnt_custom' -- 17이상 값들 존재 > product 중복 구매가 원인인듯 > 확인 완료
-- FROM Customer AS A
# 이해 O/ 직풀 O
SELECT DISTINCT customer_id
FROM (
SELECT 
    DISTINCT A.customer_id,
    B.product_key,
    COUNT(B.product_key) OVER(PARTITION BY customer_id) AS 'cnt_custom'
FROM Customer AS A
INNER JOIN Product AS B ON A.product_key = B.product_key 
GROUP BY customer_id, B.product_key
) A
WHERE cnt_custom = (
    SELECT COUNT(DISTINCT product_key)
    FROM Product
)

