# 1. 많은 수의 영화를 평가한  유저의 이름을 찾아라.
#  1) 동점인 경우 사전적으로 가장작은 유저이름을 리턴해라.
# 2. 2020년 2월에 가장 높은 평균으로 점수를 가진 영화를 찾아라.
#  1) 동점인 경우 발생할 경우 사전적으로 가장작은 영화이름을 리턴해라. 
# 이해 O /직풀 O
# MAX()값을 새로운 테이블 생성없이 비교시 -> window함수 사용!
#  -> MAX(COUNT(rating)) OVER () AS 'max_cnt_rating'

# 1번 풀이
WITH solution_one AS (
SELECT B.name AS 'results'
FROM (
SELECT
    user_id,
    COUNT(rating) AS cnt_rating,
    MAX(COUNT(rating)) OVER () AS 'max_cnt_rating'
FROM MovieRating
GROUP BY user_id
) A
INNER JOIN Users B ON A.user_id = B.user_id
WHERE max_cnt_rating = cnt_rating
ORDER BY results
LIMIT 1
) , solution_two AS
(
SELECT B.title AS 'results'
FROM (
SELECT
    movie_id,
    AVG(rating) AS 'avg_rating',
    MAX(AVG(rating)) OVER () AS 'max_avg_rating'
FROM MovieRating
WHERE created_at LIKE '2020-02%'
GROUP BY movie_id
) A
INNER JOIN Movies AS B ON A.movie_id = B.movie_id
WHERE avg_rating = max_avg_rating
ORDER BY results
LIMIT 1
)
SELECT results
FROM solution_one
UNION ALL
SELECT results
FROM solution_two
;

