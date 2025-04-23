# Student
# 1. studet_id는 primary 키
# 2. dept_id는 외래키
# 3. 각 행은 학생의 이름, 성별, 부서의 아이디를 나타냄.
# Department
# 1. dept_id는 primary 키
# 2. 각 행은 부서의 이름과 id를 포함함
# 솔루션
# 1) 각각 부서의 이름/ Department테이블에 모든 부서에 대해 각 부서에 대한 전공 학생들의 수
# (현재 학생들이 없더라도.)
# 2) student_number로 내림차순으로 정렬해라. 동점일 경우dept_name으로 알파벳순으로 정렬해라.

# 없더라도 값이 나와야 함 > 해당 변수가 있는 테이블 기준 : Department기준
# 이해 O / 직풀 O/ 9분
SELECT
    A.dept_name,
    COUNT(B.dept_id) AS student_number
FROM Department AS A
LEFT JOIN Student AS B ON A.dept_id = B.dept_id
GROUP BY dept_name
ORDER BY student_number DESC ,dept_name