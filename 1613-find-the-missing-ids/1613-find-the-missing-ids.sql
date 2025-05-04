# missing customer ID를 찾아라. missing ID들은 CUstomers테이블에 포함되지 않는다. 그러나 범위는 1부터 customer_id의 최댓값이다.
# customer_id는 100을 초과하지 않을 것이다.
# ids로 오름차순으로 정렬해라
# 이해 X 직풀 X /10분 포기
# 아래 RECURSIVE 임시 테이블 생성 정리해둘것.
WITH RECURSIVE id_seq AS (
    SELECT 1 as continued_id
    UNION 
    SELECT continued_id + 1
    FROM id_seq
    WHERE continued_id < (SELECT MAX(customer_id) FROM Customers) 
)

SELECT continued_id AS ids
FROM id_seq
WHERE continued_id NOT IN (SELECT customer_id FROM Customers)  