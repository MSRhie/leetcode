# Views 테이블
# 1) 중복행이 있다.
# 2) 이 테이블의 각행은 몇몇의 리뷰어가 몇몇 다른 리뷰어들에 의해 씌여진 기사를 검토했다.
# 3) author_id와 viewer_id가 동일한 사람은 같은 사람이란 의미다.
# 솔루션
# 1) 같은 날에 하나 이상의 기사를 검토한 모든 사람들을 찾아라.
# 2) id를 오름차순 기준으로 정렬해라.
# 이해 O / 직풀 O / 6분 30초
SELECT
    DISTINCT
    viewer_id AS id
FROM
(
SELECT
    DISTINCT *
FROM Views
) A
GROUP BY viewer_id, view_date
HAVING COUNT(viewer_id) >= 2
ORDER BY id
