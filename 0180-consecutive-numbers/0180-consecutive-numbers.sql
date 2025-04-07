# 1. at least three times consecutively : 주어진 행 기준 바로 전 값과, 전전 값이 같다면 3개가 연속된 행이다.
# > LAG() 함수 이용

WITH temp_data AS
(
SELECT
    id,
    num,
    LAG(num) OVER(ORDER BY id) AS 'lag_num',
    LAG(num, 2) OVER(ORDER BY id) AS 'lag2_num'
FROM Logs
)
SELECT DISTINCT num AS 'ConsecutiveNums'
FROM temp_data
WHERE num = lag_num AND num = lag2_num

