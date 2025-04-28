# Teams
# 1) 각행은 하나의 fottball team을 표현한다.
# 2) team_id는 유닉키다.
# Matches
# 1) 각행은 서로다른 두팀에 대한 매치결과의 기록이다.
# 2) host_team과 guest_team은 그들의 Teams테이블의 team_id로 표현된다.
# 그리고 host_goals 와 guest_goals목표들로 각각 기록된다.
# 3) match_id는 테이블의 유닉키이다.

# 솔루션
# 모든 매치이후의 모든 팀들의 점수들을 계산하고자 한다.
# 포인트들은 다음을 따른다.
# 1) 만약 그들이 팀에서 이기면 3포인트를 얻는다. (즉, 상대편 팀보다 좀더 골을 많이 기록하면)
# 2) 만약 비기면 1포인트를 받는다.(상대편과 같은 점수일 경우)
# 3) 팀에서 지면 0포인트를 받는다.(상대편 점수보다 점수가 낮을 경우)
# 모든 매치 이후 각 팀마다 team_id, team_name와 num_points를 SELECT 해라. 
# num_points별로 내림차순으로 정렬하고, 동점일경우 team_id별로 오름차순해라.
# 이해 O / 직풀 O / 29분
WITH ids AS(
SELECT
    match_id,
    host_team,
    guest_team,
    CASE
        WHEN host_goals > guest_goals
            THEN host_team
        WHEN host_goals < guest_goals
            THEN guest_team
    END AS 'winner_id',
    CASE
        WHEN host_goals = guest_goals
            THEN host_team
    END AS 'draw_id_host',
    CASE
        WHEN host_goals = guest_goals
            THEN guest_team
    END AS 'draw_id_guest'
FROM Matches
), count_table AS (
SELECT
    winner_id AS id,
    COUNT(winner_id) * 3 AS 'points'
FROM ids
GROUP BY winner_id
UNION ALL
SELECT
    draw_id_host AS id,
    COUNT(draw_id_host) * 1 AS 'points'
FROM ids
GROUP BY draw_id_host
UNION ALL
SELECT
    draw_id_guest AS id,
    COUNT(draw_id_guest) * 1 AS 'points'
FROM ids
GROUP BY draw_id_guest
)
SELECT
    A.team_id,
    A.team_name,
    IF(B.num_points IS NULL, 0, B.num_points) AS num_points
FROM Teams AS A
LEFT JOIN (
SELECT
    id,
    SUM(points) AS 'num_points'
FROM count_table
WHERE id IS NOT NULL
GROUP BY id
) B ON A.team_id = B.id
ORDER BY num_points DESC, A.team_id