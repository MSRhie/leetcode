import pandas as pd

def active_users(accounts: pd.DataFrame, logins: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        logins
        .sort_values(['id', 'login_date'])
        .assign(
            login_date = lambda d: pd.to_datetime(d['login_date']),
            shift_date = lambda d: d.groupby('id', as_index=False)['login_date'].shift(),
        )
        .loc[lambda d: ~(d['login_date'] == d['shift_date'])] # 같은날 접속은 제외
        .assign(
            diff = lambda d: (d['login_date'] - d['shift_date']).dt.days,

            # “연속으로 이어지는 지점인가?” NaT/NaN 등은 연속 아님(끊김) 으로 처리
            _m=lambda d: d['diff'].eq(1).fillna(False),

            # 위에서 만든 마스크 _m을 뒤집어서(~) diff != 1(= 끊김)인 곳을 True로 바꿉니다. 그런 다음, id별로 이 True(=끊김)를 누적합해서 블록 번호를 만듭니다.
            # 끊김이 나올 때마다 누적합이 1씩 증가 → 그 다음 구간(연속 구간)의 새 블록 번호
            # 반대로 diff == 1인 구간에서는 ~_m이 False(0)이므로 cumsum 값이 고정 → 같은 블록으로 묶입니다.
            # 결과적으로 _blk는 “동일 id 내에서 연속 구간을 구분하는 레이블” 역할
            _blk=lambda d: (~d['_m']).groupby(d['id']).cumsum(),

            # 이제 같은 (id, _blk) 블록 안에서만 _m(True=1, False=0)의 누적합을 구합니다.
            # 불리언의 cumsum은 True를 1로 보아 연속 길이가 됩니다.
            streak=lambda d: d['_m'].groupby([d['id'], d['_blk']]).cumsum().astype(int)
        )
        .loc[lambda d: d['streak']==4][['id']]  # 5일 연속 필터
        .drop_duplicates(['id'], keep='first')
        .merge(accounts, on='id', how='left')
        .sort_values(['id'])
    )

    return result