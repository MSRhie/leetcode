with temp AS
(
SELECT num, COUNT(num) AS cnt_num
FROM MyNumbers
GROUP BY num
HAVING cnt_num = 1
)
SELECT MAX(num) AS num
FROM temp


