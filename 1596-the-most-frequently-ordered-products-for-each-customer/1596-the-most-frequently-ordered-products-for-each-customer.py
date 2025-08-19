import pandas as pd

def most_frequently_products(customers: pd.DataFrame, orders: pd.DataFrame, products: pd.DataFrame) -> pd.DataFrame:
    result = (
        orders
        .groupby(['customer_id', 'product_id'])['product_id'].size().reset_index(name = 'size')
        .assign(rank = lambda d: d.groupby('customer_id')['size'].rank(method = 'min', ascending = False))
        .query('rank == 1')
        .merge(customers, on = 'customer_id', how = 'left')
        .merge(products, on = 'product_id', how = 'left')
        .loc[:, ['customer_id', 'product_id', 'product_name']]
    )
    return result