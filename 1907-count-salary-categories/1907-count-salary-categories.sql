# Accounts 테이블 각행은 매달 하나의 은행에 대한 수입을 포함한다.
# 각 연봉 카테고리에에 대한 은행계좌 수를 계산해라.
# Low Salary : 20000 미만
# Average Salary : 20000 이상 ~ 50000 이하
# High Salary : 50000 초과
# 모든 카테고리 포함해야하며 만약 어떤 계좌가 없더라도 0을 return 해야함.
# 1) 모든 카테고리 포함~ 0 return : 틀을 먼저 만들고 값을 채워 넣기
# 이해 O / 직풀 O
SELECT
    'Low Salary' AS category,
    SUM(IF(income < 20000, 1, 0 )) AS accounts_count
FROM Accounts
UNION ALL
SELECT
    'Average Salary' AS category,
    SUM(IF(income >= 20000 AND income <= 50000, 1, 0 )) AS accounts_count
FROM Accounts
UNION ALL
SELECT
    'High Salary' AS category,
    SUM(IF(income > 50000, 1, 0 )) AS accounts_count
FROM Accounts
