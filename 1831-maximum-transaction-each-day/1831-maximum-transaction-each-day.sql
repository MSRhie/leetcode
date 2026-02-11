# Write your MySQL query statement below
# amount의 최댓값을 각날마다의 iD를 구해라, 만약 하루가 여러번 거래가 발생하면, 모두를 리턴해라
# id를 오름차순으로

SELECT transaction_id 
FROM (
    SELECT
        *,
        DENSE_RANK() OVER (PARTITION BY day ORDER BY amount DESC) AS rnk
    FROM Transactions
) AS t
WHERE rnk = 1
ORDER by 1;