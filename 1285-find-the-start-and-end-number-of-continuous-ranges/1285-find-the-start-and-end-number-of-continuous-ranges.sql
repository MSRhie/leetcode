#  Logs의 연속된 시작과 끝의 수를 구해라
# 연속된 지점이 끝나는 지점이 end_id다.
# 이해 O / 직풀 O / 20분
# join key를 ROW_NUMBER로 만들어야함

WITH base AS
(
SELECT
    IF(B.log_id IS NULL, A.Log_id, NULL) AS 'start_id',
    IF(C.log_id IS NULL, A.Log_id, NULL) AS 'end_id'
FROM Logs AS A
LEFT JOIN Logs AS B ON A.log_id = B.log_id + 1
LEFT JOIN Logs AS C ON A.log_id = C.log_id - 1
), start_var AS(
SELECT 
    start_id,
    ROW_NUMBER() OVER (ORDER BY start_id) AS rn
FROM base
WHERE start_id IS NOT NULL
), end_var AS(
SELECT
    end_id,
    ROW_NUMBER() OVER (ORDER BY end_id) AS rn
FROM base
WHERE end_id IS NOT NULL
)
SELECT
    start_id,
    end_id
FROM start_var AS A
LEFT JOIN  end_var AS B ON A.rn = B.rn