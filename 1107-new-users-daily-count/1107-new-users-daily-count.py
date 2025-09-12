import pandas as pd

def new_users_daily_count(traffic: pd.DataFrame) -> pd.DataFrame:
    
    today = pd.to_datetime('2019-06-30')
    month_age_today = today - pd.DateOffset(days=90)

    result = (
        traffic
        .assign(
            with_90days = lambda d: ((d['activity_date'] >= month_age_today) & (d['activity_date'] <= today)).astype(int)
        )
        .sort_values(['user_id', 'activity_date'])
        .loc[lambda d: d['activity'] == 'login']
        .groupby('user_id').head(1)
        .loc[lambda d: d['with_90days'] == 1]
        .groupby(['activity_date'])['activity_date'].count().reset_index(name='user_count')
        .rename(columns={'activity_date': 'login_date'})
    )

    return result