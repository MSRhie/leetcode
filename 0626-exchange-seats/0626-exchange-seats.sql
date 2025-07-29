# 두번 연속된 각 학생들의 seat id의 위치를 바꿔라. 만약 학생 번호가 홀수면, swapp 하지 않는다.
# id가 오름차순으로 리턴해라

SELECT
    id,
    IF(student_A IS NULL, student, student_A) AS student 
FROM
(
    SELECT
        id,
        student,
        IF(odd_flag=1 , LEAD_student, Lag_student) AS student_A

    FROM 
    (
        SELECT
            *,
            SUM(odd_flag) OVER (ORDER BY id) AS sum_odd_flag,
            LAG(student) OVER (ORDER BY id) AS Lag_student,
            LEAD(student) OVER (ORDER BY id) AS LEAD_student
        FROM(
            SELECT
                *,
                IF(id % 2 = 0, 0, 1) AS odd_flag
            FROM Seat
            ) A
    ) A
    #GROUP BY sum_odd_flag
) A
ORDER BY id