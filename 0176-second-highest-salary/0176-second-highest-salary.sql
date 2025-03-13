SELECT 
    CASE 
        WHEN (SELECT COUNT(DISTINCT salary) FROM Employee) >= 2 
        THEN (SELECT DISTINCT salary 
              FROM Employee 
              ORDER BY salary DESC 
              OFFSET 1
	      LIMIT 1 
		)
        ELSE NULL
    END AS SecondHighestSalary;