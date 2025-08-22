import pandas as pd

def price_at_given_date(products: pd.DataFrame) -> pd.DataFrame:
    # 1) product_id 유니크
    unique_id = products[['product_id']].drop_duplicates()
    
    cutoff = pd.Timestamp('2019-08-16')

    query_products = (
        products
        .assign(date = lambda d: pd.to_datetime(d['change_date']))
        .loc[lambda d: d['date'] <= cutoff]
        .sort_values(['product_id', 'date'], ascending = [True, False])
        .drop_duplicates(['product_id'], keep='first')
    )

    result = (
        unique_id
        .merge(query_products, on = 'product_id', how='left')
        .assign(price = lambda d: d['new_price'].where(d['new_price'].isnull() == False, 10))
        .loc[:, ['product_id', 'price']]
    )

    return result