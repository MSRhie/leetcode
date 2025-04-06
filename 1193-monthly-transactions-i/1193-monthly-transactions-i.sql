# 1. To find for each month, and contry -> GROUP BY month or Contry
# 2. the number of transactions and their total amount,
# 3. the number of approved transactions and their total monut

SELECT 
    DATE_FORMAT(trans_date, "%Y-%m") AS month,
    country,
    COUNT(id) AS trans_count,
    SUM(CASE WHEN state = 'approved'  THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY month,country
