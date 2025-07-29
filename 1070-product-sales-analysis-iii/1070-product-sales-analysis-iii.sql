# sales_id, year 가 PK
# product_id 가 FK
# 1. 같은 해에 여러개의 제품 판매가 가능함.
# 각 재품이 첫번째 팔린 것을 찾아라
# 1. 각 product_id, year가 Sale 테이블에 있음.
# 모든 판매 엔트리들을 리턴해라

SELECT
    product_id,
    year AS first_year,
    quantity,
    price
FROM
(
    SELECT
        *,
        DENSE_RANK() OVER (PARTITION BY product_id ORDER BY year) AS product_rank
    FROM Sales
) A
WHERE product_rank = 1


# 제한 시간안에 품
# 단순한 문제