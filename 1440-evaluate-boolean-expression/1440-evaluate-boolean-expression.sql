# Write your MySQL query statement below
# Expressions 테이블의 조건에 맞게 Bloon을 생성하라
SELECT
    A.left_operand,
    A.operator,
    A.right_operand,
    IF(value=1, 'true', 'false') AS value
FROM(
SELECT
    A.*,
    CASE WHEN operator LIKE '>' THEN B.name > C.name
        WHEN operator LIKE '<' THEN B.name < C.name
        WHEN operator LIKE '=' THEN B.name = C.name
    END AS 'value'
FROM Expressions AS A
LEFT JOIN Variables AS B ON A.left_operand = B.name
LEFT JOIN Variables AS C ON A.right_operand = C.name
) A

