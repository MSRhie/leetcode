# 연속 5일이상 그들의 계좌에 연속으로 로그인한 Active uer들을 구해라
# id별로 정렬해라
# 이해 O / 직풀 X / 1시간
# id별로 파티션을 나눠야 할 경우 LAG() 함수를 사용해서 DATEDIFF나 DATE_SUB로 계산해야 한다.
# 첫번째 : 파티션 id를 나눌 것 Self JOIN의 id로 해결 (INNER JOIN Logins l2 ON l1.id = l2.id)
# 두번째 : 날짜차이가 1에서부터 4까지(5일 연속) AND DATEDIFF(l2.login_date, l1.login_date) BETWEEN 1 AND 4
# 세번째 : 두번쨰에서 1~4까지했을 때 조건이되는 값이 4개 이상이면 1일차이가 최소 4일 이상 반복되었다는 것을 의미 HAVING COUNT(DISTINCT l2.login_date) >= 4
SELECT DISTINCT l1.id,
(SELECT name FROM Accounts WHERE id = l1.id) AS name
FROM Logins l1
INNER JOIN Logins l2 ON l1.id = l2.id AND DATEDIFF(l2.login_date, l1.login_date) BETWEEN 1 AND 4
GROUP BY l1.id, l1.login_date
HAVING COUNT(DISTINCT l2.login_date) >= 4