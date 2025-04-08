# 1) player_id별로 이틀이상 연속 로그인을 한 player의 수 를 구하고
# 2) 1)에서 구한 수 / 전체 player 수인 fraction을 구해라.
WITH select_player AS
(
SELECT
    player_id,
    event_date,
    DATEDIFF(event_date, LAG(event_date) OVER (PARTITION BY player_id ORDER BY player_id, event_date)) AS 'diff',
    ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY player_id, event_date) AS 'count_row'
FROM Activity
)
SELECT 
    ROUND(COUNT(DISTINCT player_id) / (SELECT COUNT(DISTINCT player_id) FROM select_player),2) AS fraction
FROM select_player
WHERE diff = 1 AND count_row = 2

