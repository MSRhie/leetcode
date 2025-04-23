# 승리한 후보의 이름을 적어라. (가장 많은 vote를 받아야 함.)
# 베이스 테이블 : candidate

SELECT
    name
FROM
(
SELECT
    A.id,
    name,
    COUNT(candidateId) AS cnt_cand,
    MAX(COUNT(candidateId)) OVER () AS 'max_vote'
FROM Candidate AS A
LEFT JOIN Vote AS B ON A.id = B.candidateId
GROUP BY id
) A
WHERE cnt_cand = max_vote