# 1) 이 id는 request를 보낸 유저아이디, 요청을 받은 유저아이디를 포함함.
# (친구요청인것 같음)
# 2) 요청을 받은 유저의 아이디와 요청을 승낙한 date가 있다.
# 예시
# 3) requester_id가 3 기준
# 3-1 요청한 사람(requester_id)은 1,2
# 3-2 요청 받은 사람(accepter_id)은 4 > requester_id가 있어야 행있음.
# > 즉 requester_id에 3을 카운트 -> 1 / accepter_id 3 카운트 -> 2
# > 총 3사람 
# 이해O / 직풀 O
WITH temp_table AS (
SELECT requester_id AS id, COUNT(requester_id) AS cnt_id
FROM RequestAccepted
GROUP BY requester_id
UNION ALL
SELECT accepter_id, COUNT(accepter_id)
FROM RequestAccepted
GROUP BY accepter_id
)
SELECT id, SUM(cnt_id) AS num
FROM temp_table
GROUP BY id
ORDER BY num DESC
LIMIT 1