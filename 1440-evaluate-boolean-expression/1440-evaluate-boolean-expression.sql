# Write your MySQL query statement below
# Expressions 테이블의 조건에 맞게 Bloon을 생성하라
# 이해 O / 직풀 O/ 16분
# IF문과 CASE WHEN의 비교연산자 >, <, = 의 반환값은 True, False가 아니라 1,0으로 반환한다. < 처음 앎.
SELECT
    A.left_operand,
    A.operator,
    A.right_operand,
    IF(value=1, 'true', 'false') AS value
FROM(
SELECT
    A.*,
    CASE WHEN operator LIKE '>' THEN B.value > C.value
        WHEN operator LIKE '<' THEN B.value < C.value
        WHEN operator LIKE '=' THEN B.value = C.value
    END AS 'value'
FROM Expressions AS A
LEFT JOIN Variables AS B ON A.left_operand = B.name
LEFT JOIN Variables AS C ON A.right_operand = C.name
) A
