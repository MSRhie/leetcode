# Leetflex에서 밴한 계정들의 account_id를 찾아라.
# 계정은 두개의 다른 IP주소로부터 같이 로그인하면 밴한다.
# > 같이 로그인한다 > 로그인한 account_id의 로그아웃까지 같은 account_id가 접속한다는 것을 의미
# 이해 O / 직풀 X
# 각 행마다의 ip address를 비교하는 방법  > CROSS JOIN

SELECT
    DISTINCT
    a.account_id
FROM loginfo a
CROSS JOIN loginfo b
ON a.account_id = b.account_id
    AND a.ip_address != b.ip_address
    AND b.login BETWEEN a.login AND a.logout
