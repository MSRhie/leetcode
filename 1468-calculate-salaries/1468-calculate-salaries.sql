# 세금 적용후 직원들의 급여를 찾고 정수로 만들어라.
# 각 회사의 세금은아래를 따른다.
# 만약 회사의 어떤 직원의 연봉의 최댓값이 $1000 미만이면 0%
# 1000 이상 10000 이하면 24%
# 10000 초과면 49%
# 이해 O / 직풀 O / 9분

SELECT
    A.company_id,
    A.employee_id,
    employee_name,
    ROUND (CASE
                WHEN max_salary < 1000 THEN salary
                WHEN max_salary >= 1000 AND max_salary <= 10000 THEN salary * 0.76
                WHEN max_salary > 10000 THEN salary * 0.51
            END, 0) AS 'salary' 
FROM Salaries AS A
LEFT JOIN 
(
SELECT
    company_id,
    MAX(salary) AS max_salary
FROM Salaries
GROUP BY company_id
) AS B
ON A.company_id = B.company_id
