# tiv_2016의 전체 투자 합계를 구해라. 이때 보험계약자는
# 1) tiv_2025값을 하나나 하나이상의 보험계약자들을 가진다. > tiv_2015 값이 같다.
# 2) 서로다른 위치에 있다. > lat과 lon 가 같지 않다.

SELECT 
    *
FROM Insurance A
INNER JOIN Insurance B
    ON A.tiv_2015 = B.tiv_2015
    AND (A.pid <> B.pid AND A.lat <> B.lat AND A.lon <> B.lon)
#    AND (A.pid <> B.pid )
ORDER BY A.pid, A.tiv_2015