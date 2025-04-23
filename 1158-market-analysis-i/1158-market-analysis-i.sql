# 각유저별로 날짜와 그들이 2019년에 구매한 주문들의 수를 구해라
# Users테이블의 Join_date와 buyer_id 
# Orders테이블에서
# 1) order_date가 2019이면서
# 2) Users테이블의 buyer_id와 INNER JOIN 한 buyer_id
# 3) buyerid 수
# 이해 O / 직풀 X / 1시간
# 내가 푼 쿼리
-- WITH key_id AS
-- (
-- SELECT
--     User_id,
--     join_date
-- FROM Users
-- )
-- SELECT
--     A.user_id AS 'buyer_id',
--     join_date,
--     COUNT(buyer_id) AS 'orders_in_2019'
-- FROM key_id AS A
-- LEFT JOIN Orders AS B ON A.user_id = B.buyer_id
-- AND EXTRACT(year FROM order_date) = '2019'
-- GROUP BY buyer_id, join_date

# 개선된 풀이
SELECT
  u.user_id AS buyer_id,
  u.join_date,
  COUNT(o.order_id) AS orders_in_2019
FROM Users AS u
LEFT JOIN Orders AS o
  ON u.user_id = o.buyer_id
  AND YEAR(o.order_date) = 2019
GROUP BY
  u.user_id,
  u.join_date;