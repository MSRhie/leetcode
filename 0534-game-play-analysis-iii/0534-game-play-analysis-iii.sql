# Activity 테이블은 각 플레이어의 날짜에 대한 기록.
# 각 행은 장치를 사용하고 로그인하기전 로그인한 플레이어와 플레이한 게임의 수이다.(0도가능) 
# 솔루션 작성
# 1) 각 플레이어와 날짜별로 얼마나 많은 게임들이 플레이어에 의해 플레이되었는가? 즉, 특정날짜까지 플레이어에 의해 플레이된 게임 수.
# -> player별 날짜별 누적합을 계산해라.
# 이해 O / 직풀 O / 풀이시간 2분
SELECT
    player_id,
    event_date,
    SUM(games_played) OVER (PARTITION BY player_id ORDER BY event_date) AS 'games_played_so_far'
FROM Activity
