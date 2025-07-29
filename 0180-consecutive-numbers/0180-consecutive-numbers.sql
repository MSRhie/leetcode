# 1. 3번 연속 값이 나오는 num을 찾아 출력해라

SELECT
    DISTINCT
    num AS ConsecutiveNums
FROM (
SELECT
    id,
    num,
    LAG(num) OVER (ORDER BY id) AS 'lag_num',
    LEAD(num) OVER (ORDER BY id) AS 'lead_num'
FROM Logs
) A
WHERE num = lag_num AND num = lead_num