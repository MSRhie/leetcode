# Project 테이블
# 1) project_id와 employee_id는 조합했을 때 unique한 키
# 2) employee_id는 외래키 > employee
# 3) 각행은 project_id별 employee를 나타남.
# Employee 테이블
# 1) 각행은 한 직원에 대한 정보를 포함함.

# 솔루션
# 각 프로젝트별로 가장 경험많은 직원을 골라라. 동점일 경우, 해당 프로젝트의 모든 직원들의 최대 연차를 표시해라.
# 이해 O / 직풀 O/ 8분

SELECT
    project_id,
    employee_id
FROM (
SELECT
    A.project_id,
    A.employee_id,
    DENSE_RANK() OVER (PARTITION BY project_id ORDER BY experience_years DESC) AS 'rk'
FROM Project A
LEFT JOIN Employee B ON A.employee_id = B.employee_id
) A
WHERE rk = 1
