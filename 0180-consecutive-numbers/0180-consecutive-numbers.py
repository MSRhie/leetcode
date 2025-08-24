import pandas as pd

def consecutive_numbers(logs: pd.DataFrame) -> pd.DataFrame:
    result = (
        logs
        .sort_values(['id'])['num'].reset_index()
        .assign(
            one_lag_num = lambda d: d['num'].shift(1),
            two_lag_num = lambda d: d['num'].shift(2)
            )
        .query('(num == one_lag_num) & (num == two_lag_num)')
        .loc[:, ['num']]
        .rename(columns={'num' : 'ConsecutiveNums'})
        .drop_duplicates('ConsecutiveNums')
    )
    
    return result