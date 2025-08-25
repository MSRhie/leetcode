import pandas as pd

def exchange_seats(seat: pd.DataFrame) -> pd.DataFrame:

    even_result = (
        seat
        .query('id % 2 == 0')
        .assign(id = lambda d: d['id'] - 1)
    )

    odd_result = (
        seat
        .query('id % 2 != 0')
        .assign(id = lambda d: d['id'] + 1)
    )

    result = (
        pd.concat([even_result, odd_result])
        .sort_values(['id'])
        .assign(id = lambda d: np.where(d['id'] == d['id'].max(), len(d), d['id']))
        # np.where 또는 .loc 으로 해결
    )

    return result