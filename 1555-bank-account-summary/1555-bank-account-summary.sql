# 모든 거래를 Transaction 테이블에 기록한다. 유저들의 잔고와 그들의 신용ㅎ나도에 도달했는지를 확인하고자함.
# credit은 거래 수행이후의 잔고이다.
# Credit_limit_brached로 credit_limit을 확인할 수 있다.

WITH minus AS (
SELECT
    paid_by AS 'minus_id',
    -SUM(amount) AS 'minus_amount'
FROM TRansactions
GROUP BY paid_by
), plus AS (
SELECT
    paid_to AS 'plus_id',
    SUM(amount) AS 'plus_amount'
FROM transactions
GROUP BY paid_to
), base AS (
SELECT
    user_id,
    plus_id,
    minus_id,
    user_name,
    credit,
    IF(minus_amount IS NULL , 0, minus_amount) AS 'minus_amount',
    IF(plus_amount IS NULL , 0, plus_amount) AS 'plus_amount',
    IF(credit+minus_amount+plus_amount < 0, 'Yes', 'No') AS 'credit_limit_breached'
FROM Users AS A
LEFT JOIN minus AS B ON A.user_id = B.minus_id
LEFT JOIN plus AS C ON A.user_id = C.plus_id
GROUP BY user_id
)
SELECT 
    user_id,
    user_name,
    credit+minus_amount+plus_amount AS credit,
    IF(credit+minus_amount+plus_amount < 0, 'Yes', 'No') AS 'credit_limit_breached'
FROM base
