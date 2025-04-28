# Frendship
# 1) user1_id와 user2_id의 결합키는 PK다.
# 2) 각행은 user1_id와 user2_id의 친밀관계를 나타냄.
# Likes
# 1) user_id와 page_id는 결합시 PK이다.
# 2) 이 테이블의 각행은 user_id가 page_id를 좋아하는 것을 나타낸다.
# 솔루션
# user_id=1에게 페이지를 추천해라. 너의 친구가 좋아한 패이지를 사용해서.
# 이는 이미 너가 좋아한 페이지를 추천해선 안됨.
# 중복없이 어떤 순서라든지 정렬해라
# 이해 O / 직풀 O / 20분
WITH base_user2_id AS(
SELECT
    B.page_id
FROM Friendship AS A
LEFT JOIN Likes AS B
ON A.user2_id = B.user_id
WHERE A.user1_id = 1 
UNION ALL
SELECT
    B.page_id
FROM Friendship AS A
LEFT JOIN Likes AS B
ON A.user1_id = B.user_id
WHERE A.user2_id = 1 
)
SELECT
    DISTINCT
    page_id AS 'recommended_page'
FROM base_user2_id
WHERE (page_id NOT IN (SELECT page_id FROM Likes WHERE user_id = 1)) AND page_id IS NOT NULL