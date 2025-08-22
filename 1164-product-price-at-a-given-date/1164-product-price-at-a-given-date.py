import pandas as pd

def price_at_given_date(products: pd.DataFrame) -> pd.DataFrame:
    unique_id = (
        products
        .drop_duplicates('product_id')
        .loc[:, ['product_id']]
    )

    query_products = (
        products
        .assign(date = lambda d: pd.to_datetime(d['change_date']))
        .query('date <= "2019-08-16" ')
        .assign(rank = lambda d: d.groupby('product_id')['date'].rank(method='dense', ascending=False))
        .query('rank == 1 ')
    )

    result = (
        unique_id
        .merge(query_products, on = 'product_id', how='left')
        .assign(price = lambda d: d['new_price'].where(d['new_price'].isnull() == False, 10))
        .loc[:, ['product_id', 'price']]
    )

    return result