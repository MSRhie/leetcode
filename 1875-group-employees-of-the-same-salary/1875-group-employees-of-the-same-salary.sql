# Write your MySQL query statement below
# 같은 salay를 가진 팀으로 구성하려고 함
# 조건
#  1) 각 팀은 최소 2명 이상, 한명은 제외됨
#  2) 팀 id가 오름차순으로 salary가 높음
#     단, 제외된 사람을 팀 id RANK에 제외할 것
# team_id별 오름차순, 동점일땐 employee_id의 오름차순으로.

# 조건 1)
WITH exclusive_salary AS (
    SELECT
        salary
        ,COUNT(salary) AS cnt_salary
    FROM Employees
    GROUP BY salary
    HAVING cnt_salary > 1
# 조건 2)
), ranking_df AS (
    SELECT
        E.*
        ,DENSE_RANK() OVER (ORDER BY E.salary) AS team_id
    FROM Employees AS E
    INNER JOIN exclusive_salary AS ES ON E.salary = ES.salary
)
SELECT
    *
FROM ranking_df
ORDER BY team_id ASC, employee_id ASC