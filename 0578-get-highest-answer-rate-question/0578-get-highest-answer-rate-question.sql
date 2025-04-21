# 중복이 포함된 SurveyLog
# action은 show, answer, skip으로 구분됨.
# 각 행의 id는 answer_id는 해당 id의 answer를 포함할 것이다, 응답이없다면 NULL이다.
# q_num은 현재 session의 질문순서다.
# 출력 조건
# 1) answer rate를 구해라. (question_id별 answer_id가 NULL이 아닌 수/question_id별 질문 수)
# 2) 가장 높은 answer rate를 구해라. 만약 중복 질문이 같은 answer rate최댓값을 가지면, question_id가 가장 작은걸 우선시해라.
# 이해 O / 직풀 O / 14분 24초

SELECT
    question_id AS 'survey_log'
FROM (
SELECT
    question_id,
    COUNT(answer_id) / COUNT(question_id) AS survey_lob,
    RANK() OVER(ORDER BY (COUNT(answer_id) / COUNT(question_id)) DESC, question_id  ) AS 'rk'
FROM SurveyLog
GROUP BY question_id
) A
WHERE rk = 1