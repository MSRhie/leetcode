# 1. 확인 비율 : 한 유저당 confirmed 메시지의 수 / 총 요청받았던 확인 메시지의 수
# 2. 확인 비율에서 요청이 없을 경우 0이다.
# 3. 두번째 자리에서 반올림.

SELECT
    user_id,
    ROUND(SUM(flag_action) / total_count, 2) AS confirmation_rate
FROM (
SELECT
    S.user_id,
    action,
    IF(action = 'timeout' OR action IS NULL, 0, 1) AS 'flag_action',
    SUM(1) OVER (PARTITION BY S.user_id) AS 'total_count'
FROM Signups S
LEFT JOIN Confirmations C
ON S.user_id = C.user_id
) A
GROUP BY user_id
ORDER BY user_id