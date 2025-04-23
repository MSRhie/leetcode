# Stocks 테이블
# 각 행의 이 테이블은 주식이름을 가진 주식이 가격을가진 opreation_day에 운영을 가진다.
# 각 Sell 은 이전날 Buy가 작동될때 Sell이 생성된다. 이는 또한 각 Buy가 생성된날 다음날에 동시에 Sell이 작동하게 된다.
# 솔루션
# 1) 각 주식에 대한 Capital gain/loss를 보고하라.
# 2) Capital gain/loss은 전체 이득이나 손실이다. 주식을 사거나 판 하나이상일 때.
# Stock_name별로 Buy는 - Sell은 +의 누적합임. 이때 operation_day는 시간순이므로 정렬 필요
# 이해O / 직풀 O / 18분
WITH base_data AS
(
SELECT
    stock_name,
    operation_day,
    SUM(
        CASE WHEN operation = 'Buy' THEN price * -1
            WHEN operation = 'Sell' THEN price
        END
    ) OVER (PARTITION BY stock_name ORDER BY operation_day) AS 'capital_gain_loss',
    RANK() OVER (PARTITION BY stock_name ORDER BY operation_day) AS 'rk'
FROM Stocks
)
SELECT
    stock_name,
    capital_gain_loss
FROM base_data
WHERE (stock_name, rk) IN (SELECT stock_name, MAX(rk) AS rk FROM base_data GROUP BY stock_name)