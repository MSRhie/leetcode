# n번째 가장 높은 연봉을 가진 직원테이블을 찾아라. 만약 n번째의 가장 높은 연봉이 없다면 NULL을 출력해라.
# 이해 O / 풀이 O
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    DECLARE nth int;
    SET nth = N ;
  RETURN (
    SELECT DISTINCT IF(salary IS NULL, NULL, salary)
    FROM (
    SELECT salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS 'id_rank'
    FROM Employee
    ) AS A
    WHERE id_rank = nth
  );
END
