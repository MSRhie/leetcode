# 솔루션
# 1) 각날에 대한 홀수나 짝수 거래양에 대한 amount의 합계를 찾아라.
# 2) 특정한 날에 만약 어떠한 홀수나 짝수 거래가 없다면 0을 display해라.
# 3) transaction_date를 오름차순으로 정렬해라 
# 이해 O / 직풀 O/ 10분
SELECT
    transaction_date,
    SUM(IF(amount % 2 <> 0, amount, 0)) AS odd_sum,
    SUM(IF(amount % 2 = 0, amount, 0)) AS even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date