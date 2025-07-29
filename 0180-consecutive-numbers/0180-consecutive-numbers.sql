# 1. 3번 이상  연속 값이 나오는 num을 찾아 출력해라

SELECT
    DISTINCT
    num AS ConsecutiveNums
FROM (
SELECT
    id,
    num,
    LAG(num) OVER (ORDER BY id) AS 'lag_num',
    LEAD(num) OVER (ORDER BY id) AS 'lead_num'
FROM Logs
) A
WHERE num = lag_num AND num = lead_num

# 제한 시간내 품
# 알게된 것
# 1. where 문에서 중복 = = 문은 자칫  True, False = 1, 0 으로 값이 있을경우 의도치 않은 결과를 낼 수 있으므로 = AND = 로 한다.
# 2. "연속적" 조건일 때는 연속되는 값 id가 없다면 만들어서라도 ORDER BY를 통해 정렬 후, LAG와 LEAD 를 통해 값을 생성한 후 비교한다.
# 또는 본래 id와 , num 파티션별로 id가 1씩 증가하게 만든후 (SUM(1) OVER (PARTITION BY num ORDER BY id) AS 'cum_id') 이를 본래 id와 빼기를 통해
# 연속되는 값들을 필터링하는 flag 변수는 가급적 지양한다. (정확하지 않을 가능성 있음.)
