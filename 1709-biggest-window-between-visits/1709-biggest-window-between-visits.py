import pandas as pd

def biggest_window(user_visits: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        user_visits
        .sort_values(['user_id', 'visit_date'])
        .assign(
            shift_date = lambda d: d.groupby('user_id')['visit_date'].shift(-1).fillna('2021-01-01'),
            date_diff = lambda d: (d['shift_date']-d['visit_date']).dt.days
        )
        .groupby(['user_id'], as_index=False)['date_diff'].max()
        .rename(columns={'date_diff': 'biggest_window'})
    )

    return result
    