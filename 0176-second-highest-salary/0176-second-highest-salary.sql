-- SELECT
--     COALESCE(MAX(Salary)) AS SecondHighestSalary
-- FROM Employee
-- WHERE Salary < (SELECT MAX(Salary) FROM Employee)

WITH temp AS(
SELECT
    Salary,
    DENSE_RANK() OVER(ORDER BY Salary DESC) AS rank_salary
FROM Employee
)
SELECT MAX(Salary) AS 'SecondHighestSalary'
FROM temp
WHERE rank_salary = 2

# 제한시간 20분 내 못품
# 알아간 것 #
# 1. 집계함수는 값이 없을 경우 자동으로 null을 출력한다.
# 2. DENSE_RANK()와 RANK()의 차이 복습
# 3. PARTITION BY 사용방법 복습
# 4. COALESCE는 인자에 값이 있다면 값을, 없다면 null을 리턴한다.
