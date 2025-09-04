import pandas as pd
# 1. 각 유저별로 날짜와 2019년에 그들이 산 주문들의 수를 결합하고 리턴해라

def market_analysis(users: pd.DataFrame, orders: pd.DataFrame, items: pd.DataFrame) -> pd.DataFrame:
    
    df = (
        orders
        .assign(
            year = lambda d: d['order_date'].dt.year
        )
        .query('year == 2019')
        .groupby(['buyer_id'])['order_id'].count().reset_index(name='orders_in_2019')
    )

    df = (
        users[['user_id', 'join_date']]
        .merge(df, left_on='user_id', right_on='buyer_id', how='left')
        .assign(
            orders_in_2019 = lambda d: d['orders_in_2019'].fillna(0)
        )
        .drop(['buyer_id'], axis=1)
        .rename(columns={'user_id': 'buyer_id'})
    )

    return df