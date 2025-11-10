# Write your MySQL query statement below


SELECT
    A.player_id,
    p.player_name,
    COUNT(A.player_id) AS 'grand_slams_count'
FROM
(
SELECT
    Wimbledon AS 'player_id'
FROM Championships AS p
UNION ALL
SELECT
    Fr_open
FROM Championships AS p
UNION ALL
SELECT
    US_open
FROM Championships AS p
UNION ALL
SELECT
    Au_open
FROM Championships AS p
) A
LEFT JOIN players AS p
ON A.player_id = p.player_id
GROUP BY player_id
