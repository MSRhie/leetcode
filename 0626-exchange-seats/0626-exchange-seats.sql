# 1. id가 2번째마다  학생들 id seat의 자리를 뒤바꿔라.
# 2. 만약 학생수가 홀수면, 마지막 학생의 id는 바뀌지 않는다.
# 3. id의 오름차순으로 결과 테이블을 만들어라.

WITH temp_seat AS 
(
    SELECT
        id,
        student AS student2,
        (SELECT MAX(id) FROM Seat) AS max_id,
        LAG(student) OVER (ORDER BY id) AS 'lag_student',
        LEAD(student) OVER (ORDER BY id) AS 'lead_student'
    FROM Seat
)
SELECT
    id,
    CASE
        WHEN (max_id % 2 <> 0) AND lead_student IS NULL
            THEN student2
        WHEN id % 2 = 0
            THEN lag_student
        WHEN id % 2 <> 0
            THEN lead_student
    END AS 'student'
FROM temp_seat
