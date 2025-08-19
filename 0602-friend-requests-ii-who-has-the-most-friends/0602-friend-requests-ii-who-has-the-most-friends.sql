# 가장 친구가 많은 accepter_id를 구하라
WITH key_id AS
(
SELECT
    id,
    COUNT(id) AS cnt_id
FROM (
SELECT requester_id AS id
FROM RequestAccepted
UNION ALL
SELECT accepter_id AS id
FROM RequestAccepted
) A
GROUP BY id
)
SELECT
    id,
    cnt_id AS num
FROM key_id
WHERE cnt_id = (
    SELECT
        MAX(cnt_id)
    FROM key_id
)