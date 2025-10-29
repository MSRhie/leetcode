import pandas as pd

def apples_oranges(sales: pd.DataFrame) -> pd.DataFrame:
    df = (
        sales
        .groupby(['sale_date', 'fruit'], as_index=False)['sold_num'].sum()
    )
    
    apples = (
        df
        .loc[lambda d: d['fruit']=='apples']
        .rename(columns={'sold_num': 'apple_sold_num'})
    )

    oranges = (
        df
        .loc[lambda d: d['fruit']=='oranges']
        .rename(columns={'sold_num': 'orange_sold_num'})
    )

    result = (
        apples
        .merge(oranges, on='sale_date', how='left')
        .assign(
            diff = lambda d: d['apple_sold_num'] - d['orange_sold_num']
        )
        .sort_values(['sale_date'])
        .loc[:, ['sale_date', 'diff']]
    )

    return result