# tiv_2016의 전체 투자 합계를 구해라. 이때 보험계약자는
# 1) 같은 tiv_2025값을 하나나 하나이상의 다른 보험계약자 보다 많이 가진다. > tiv_2015 값이 같다.
# 2) 서로다른 위치에 있다. > lat과 lon 가 같지 않다.
# 이해 O / 직풀 x
-- WITH key_id AS
-- (
-- SELECT
--     tiv_2015,
--     COUNT(tiv_2015) AS cnt_tiv_2015
-- FROM Insurance A
-- GROUP BY tiv_2015
-- HAVING COUNT(tiv_2015) > 2
-- ORDER BY A.pid, A.tiv_2015
-- )
-- SELECT 
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance i
JOIN
   (
   SELECT tiv_2015
   FROM Insurance
   GROUP BY tiv_2015
   HAVING COUNT(DISTINCT pid) > 1
   )t0
ON i.tiv_2015 = t0.tiv_2015
JOIN
   (
   SELECT CONCAT(lat, lon) lat_lon
   FROM Insurance
   GROUP BY CONCAT(lat, lon)
   HAVING COUNT(DISTINCT pid) = 1
   )t1
ON CONCAT(i.lat, i.lon) = t1.lat_lon