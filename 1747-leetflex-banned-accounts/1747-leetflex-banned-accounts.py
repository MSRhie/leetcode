import pandas as pd

# 로그인 -> 아웃 사이에 다른 ip address가 2개 이상인 id들을 벤해라
# -> A의 ip주소의 로그인 이후 B의 로그인이 A의 로그아웃시간보다 작다면, 동시접속
# 결국 모든 경우의수를 차단하는 방법은...... cross join....
import pandas as pd


def leetflex_banned_accnts(log_info: pd.DataFrame) -> pd.DataFrame:

    result = (
        log_info
        .merge(log_info, on='account_id')
        .query('(ip_address_x != ip_address_y) & (login_x <= login_y <= logout_x)')[['account_id']]
        .drop_duplicates()
    )
    return result