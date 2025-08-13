-- -- # 첫번째 로그인 후 당일 이후에 다시 한번로그인한 비율을 총 플레이어의 수로 나눠서 구해라.

SELECT
  ROUND(
    COUNT(A1.player_id)
    / (SELECT COUNT(DISTINCT A3.player_id) FROM Activity A3)
    , 2) AS fraction
FROM
  Activity A1
WHERE 
  (A1.player_id, DATE_SUB(A1.event_date, INTERVAL 1 DAY)) IN (
    SELECT
      A2.player_id,
      MIN(A2.event_date)
    FROM
      Activity A2
    GROUP BY
      A2.player_id
  );
  # 시간 오버
  # 날짜가 하루 차이씩 나면서, 같은 player ID 일때
