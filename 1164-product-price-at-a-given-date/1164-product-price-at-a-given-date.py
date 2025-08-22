import pandas as pd

def price_at_given_date(products: pd.DataFrame) -> pd.DataFrame:
    # 1) product_id 유니크
    unique_id = products[['product_id']].drop_duplicates()

    cut_off = pd.Timestamp('2019-08-16')

    duplicated_date = (
        products
        .loc[lambda d: d['change_date'] <= cut_off]
        .sort_values(['product_id', 'change_date'], ascending=False)
        .drop_duplicates(['product_id'], keep='first')
    )

    result = (
        unique_id
        .merge(duplicated_date, on='product_id', how='left')
        .assign(price = lambda d: d['new_price'].fillna(10))
        .loc[:, ['product_id', 'price']]
    )


    return result