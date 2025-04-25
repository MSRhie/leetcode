# 각 학생별로 코스에 대응되는 가장 높은 등급을 찾아라., 동점일 경우 course_id가 가장 작은 값을 찾아라.
# 이해 O / 직풀 O / 11분
SELECT
    student_id,
    course_id,
    grade
FROM (
SELECT 
    student_id,
    course_id,
    grade,
    RANK() OVER (PARTITION BY student_id ORDER BY grade DESC, course_id ) AS 'lv'
FROM Enrollments
) A
WHERE lv = 1