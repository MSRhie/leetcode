import pandas as pd
# 첫번째 로그인 후에 다음날에 다시 로그인한 플레이어들의 fraction을 보고해라
# 소수점 두번째 자리에서 반올림
# 그 후 전체 플레이어수 중 해당 플레이어들의 수를 나눠라

def gameplay_analysis(activity: pd.DataFrame) -> pd.DataFrame:
    # 중복 제거 & 정렬
    activity = (
        activity
        .sort_values(['player_id','event_date'])
        .drop_duplicates(['player_id','event_date'])
        .assign(
                num = 1,
                id_cnt = lambda d: d.groupby('player_id')['num'].cumsum()
        )
        .query('id_cnt <= 2')
        .drop(['num', 'id_cnt'], axis=1)
    )

    # 하루 차이 여부 계산
    activity = activity.assign(
        lag_event_date=lambda d: d.groupby("player_id")["event_date"].shift(),
        diff_date=lambda d: (pd.to_datetime(d["event_date"]) - pd.to_datetime(d["lag_event_date"])).dt.days,
        is_diff_one=lambda d: (d["diff_date"] == 1).astype(int)
    )

    # 유저별로 하루 차이 여부 확인
    user_flags = activity.groupby("player_id")["is_diff_one"].max()

    # fraction
    fraction = round(user_flags.sum() / user_flags.count(), 2)
    return pd.DataFrame({"fraction": [fraction]})


