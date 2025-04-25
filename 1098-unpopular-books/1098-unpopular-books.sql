# 솔루션
# 지난해에 10부 이하로 팔린 책들을 보고하라
# 오늘로부터 한달 이하간 이용가능한 책들은 제외해라. 오늘 기준 2019-06-23
# 이해 O / 직풀 O / 시간초과
WITH books_w AS
(
SELECT
    DISTINCT
    A.book_id
FROM Books AS A
WHERE available_from >= '2019-05-23'
),
Orders_w AS
(
SELECT
    DISTINCT
    A.book_id
FROM Orders AS A
WHERE (dispatch_date BETWEEN DATE_SUB('2019-06-23', INTERVAL 1 YEAR) AND '2019-06-23')
GROUP BY A.book_id
HAVING SUM(quantity) >= 10
)
SELECT
    DISTINCT
    A.book_id,
    A.name
FROM Books AS A
LEFT JOIN books_w AS B ON A.book_id = B.book_id
LEFT JOIN Orders_w AS C ON A.book_id = C.book_id
WHERE (B.book_id IS NULL) AND (C.booK_id IS NULL) 