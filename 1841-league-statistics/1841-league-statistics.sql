# Write your MySQL query statement below

WITH team_score AS (
    SELECT
        *
        ,CASE
            WHEN (home_team_goals > away_team_goals) THEN 3
            WHEN (home_team_goals = away_team_goals) THEN 1
            ELSE 0
        END AS home_score
        ,CASE
            WHEN (home_team_goals < away_team_goals) THEN 3
            WHEN (home_team_goals = away_team_goals) THEN 1
            ELSE 0
        END AS away_score
    FROM matches
),
home_team AS (
    SELECT
        home_team_id AS team_id
        ,home_team_goals AS home_goals
        ,away_team_goals AS away_goals
        ,home_score AS score
    FROM team_score
),
away_team AS (
    SELECT
        away_team_id AS team_id
        ,away_team_goals AS home_goals
        ,home_team_goals AS away_goals
        ,away_score AS score
    FROM team_score
),
output AS (
SELECT
    *
FROM home_team
UNION ALL
SELECT
    *
FROM away_team
)
SELECT
    team_name
    ,matches_played
    ,points
    ,goal_for
    ,goal_against
    ,goal_for-goal_against AS goal_diff
FROM
    (
    SELECT
        team_id
        ,COUNT(team_id) AS matches_played
        ,SUM(score) AS points
        ,SUM(home_goals) AS goal_for
        ,SUM(away_goals) AS goal_against
    FROM output
    GROUP BY team_id
    ) A
LEFT JOIN teams AS B ON A.team_id = B.team_id
ORDER BY points DESC, goal_diff DESC , team_name

