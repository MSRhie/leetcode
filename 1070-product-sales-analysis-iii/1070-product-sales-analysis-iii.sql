# 1) Sales 테이블은 특정 년의 제품 product_id의 판매를 보여줌
# 2) Product 테이블은 각 제품의 이름을 보여줌
# 3) product id, year, 제품이 팔린 첫해의 가격(price)
# 풀이x 이해x > 답지참고
# 내가 이해한 것 : 제품 아이디별 해당연도에 가장 처음 팔린 행 하나만 가져오도록 작성
# 잘못된 것  : 제품 아이디별 해당 연도에 가장 처음 판매된다 했을 때, 한해에 하나의 제품이 여러 판매건이 있을 경우
# 한건만 가져오게 됨 > 
with temp_sales AS
(
SELECT
    A.product_id,
    A.year AS 'first_year',
    A.quantity, A.price,
    DENSE_RANK() OVER (PARTITION BY product_id ORDER BY product_id, year) AS 'row_rank'
FROM Sales AS A
)
SELECT DISTINCT product_id, first_year, quantity, price
FROM temp_sales
WHERE row_rank = 1
