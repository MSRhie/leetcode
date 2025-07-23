# 각달과 나라들에대해 총 거래양, 승인된 거래들의 수와 그들의 총 양을 쿼리해라

# 모두 GROP GY month yyy-mm, country
# trans_count : COUNT(id)
# approved_count : COUNT(id) IF state = approved
# trans_total_amount : SUM(amount)
# approved_total_amount : SUM(amount) IF state = approved

SELECT
    SUBSTR(trans_date, 1, 7) AS month,
    country,
    COUNT(id) AS trans_count,
    SUM(IF(state = 'approved', 1, 0)) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount
FROM Transactions
GROUP BY SUBSTR(trans_date, 1, 7), country
