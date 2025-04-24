# Follow 테이블
# 1. followee와 follower은 primary key이다.
# 2. 각 테이블의 행은 유저가 팔로워 이거나 팔로우 하는 유저이다.
# 3. 이들은 그들 스스로를 팔로잉 하지 않는다.
# 솔루션
# Second-degree follower는 한 유저다.
# 1) 적어도 한명을 팔로우 하거나
# 2) 적어도 한명에게 팔로우 당한 유저
# second-degree users를 작성하고 그들의 follower 수를 카운트해라.
# follower를 오름차순으로 정렬해라
# 이해 O/ 직풀 X / 1시간
# > 내 풀이 법 : 1)와 2) 풀기 위해 각 key id별로 GROUP BY로 COUNT 하여 서로 포함되는지 여부 판단
# -> 코드 길이가 너무 길어지며 중간에 코드가 엉켜버림
# -> 또 1)와 2)의 조건이 AND조건인데 OR조건으로 풀었음.
# > 정답지 풀이 :
# 1), 2)를 서로 키 값이 하나 이상 포함되는 경우 = INNER JOIN으로 풀이
# 이후 여기서 구하고자하는건 follower 수이므로, follower 기준 count함.
SELECT
    f1.follower, COUNT(DISTINCT f2.follower) AS num
FROM follow f1
INNER JOIN follow f2 ON f1.follower = f2.followee
GROUP BY f1.follower
ORDER BY f1.follower
