# 1. at least three times consecutively : 주어진 행 기준 바로 전 값과, 전전 값이 같다면 3개가 연속된 행이다.

# 연속 조건 : id값이 연속적일 때, 이전값과 다음값이 같음. 같은 경우가 2번 이상 반복됨.


# 연속적이라는 기준을 순서대로 증가하는 id로 기준을 잡았으나  id순서가 섞여있거나 중간에 값이 빠져있었음.
SELECT
    DISTINCT # 4. 중복방지
#    id,
    num AS ConsecutiveNums
#    rn_id,
#    rn_num,
#    rn_id-rn_num # 3.rn_id - rn_num 하면, 해당 값별로 그룹화가 진행 됨. 
FROM (
SELECT
    id,
    num,
    ROW_NUMBER() OVER (ORDER BY id) AS 'rn_id', # 1. id별로 정렬했을 떄 넘버링. : 연속적인 값인지 판단할 수 있는 기준 열
    ROW_NUMBER() OVER (PARTITION BY num ORDER BY id) AS 'rn_num' # 2. num의 값을 id별로 정렬했을 떄 넘버링 : id별로 num이 연속적인지의 기준 열 
FROM Logs 
) A
GROUP BY num, rn_id-rn_num
HAVING COUNT(rn_id-rn_num) >= 3


# 오답 정리 #

-- SELECT
--     num AS ConsecutiveNums
-- FROM (
-- SELECT
--     num,
--     LAG(num) OVER (ORDER BY id) AS 'lag_num'
-- FROM Logs 
-- ) A
-- WHERE num = lag_num 
-- GROUP BY lag_num
-- HAVING COUNT(lag_num) >= 2 -> 이경우 num이 lag_num과 같은 값들도 같이 출력됨. -> 무엇을 기준으로 연속되었는가가 중요
-- 반례
-- Logs
-- +----+-----+
-- | id | num |
-- +----+-----+
-- |  1 |   1 |
-- |  2 |   1 |  ← (1,1) 첫 번째 페어
-- |  3 |   2 |
-- |  4 |   1 |
-- |  5 |   1 |  ← (1,1) 두 번째 페어
-- +----+-----+
