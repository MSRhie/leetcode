# 1) Chargebacks 테이블은 Transactions에 위치한 몇몇 transactions로부터의 chargeback의 수입과 관련된 정보다. 각 chargeback은 그들이 승인을 하지 않았더라도 거래에 대한 응답한다.
# Transactions 테이블은 수입 거래에 대한 정보를 가진다. state 컬럼은 ENUM 칼럼이다 (승인/거부)
# 2) 월별 나라별로 솔루션을 작성해라. 승인된 거래들과 승인된 거래들의 총양, chargeacks의 수, chargeback의 총양
# 모든 0을 가진 컬럼들은 무시해라.
# 결과테이블은 any order다.
# 이해O/ 직풀 X 고민 2시간 / 
# Key 정보를 두개가진 테이블이 있고, key정보가 상대 테이블에 있을지도, 없을지도 모르는 상황일때
# > 예로 Chargebacks 테이블의 trans_id가 Transaction 테이블에 없을 수도 있음(반대경우도마찬가지)
# >또한 Chargebacks 테이블의 trans_date가 Transaction 테이블에 없을 수도 있음(반대경우도마찬가지)
# Chargebacks 테이블 별도로 집계를 내고, Transaction 테이블 별도로 집계를 낸 후 통합한다.
# 이때 당연히 Transaction과 Chargebacks 테이블 서로간 집계변수가 없으므로 임의로 0을 생성해준다!
WITH trans_agg AS
(
SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    0 AS chargeback_count,
    0 AS chargeback_amount,
    COUNT(id) AS approved_count,
    SUM(amount) AS approved_amount
FROM Transactions
WHERE state = 'approved'
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country
),
charge_agg AS (
SELECT
    DATE_FORMAT(B.trans_date, '%Y-%m') AS month,
    country,
    COUNT(trans_id) AS chargeback_count,
    SUM(amount) AS chargeback_amount,
    0 AS approved_count,
    0 AS approved_amount
FROM Transactions AS A
INNER JOIN Chargebacks AS B ON A.id = B.trans_id
GROUP BY DATE_FORMAT(B.trans_date, '%Y-%m'), country
)
SELECT
    month,
    country,
    SUM(chargeback_count) AS chargeback_count,
    SUM(chargeback_amount) AS chargeback_amount,
    SUM(approved_count) AS approved_count,
    SUM(approved_amount) AS approved_amount
FROM (
SELECT *
FROM charge_agg
UNION ALL
SELECT *
FROM trans_agg
) A
GROUP BY month, country