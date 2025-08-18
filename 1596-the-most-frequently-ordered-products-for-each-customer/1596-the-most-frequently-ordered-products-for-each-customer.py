import pandas as pd

def most_frequently_products(customers: pd.DataFrame, orders: pd.DataFrame, products: pd.DataFrame) -> pd.DataFrame:
    cnt_size = (
        orders
        .groupby(['customer_id', 'product_id']).size()
        .reset_index(name = 'size')
    )

    cnt_size['rank'] = (
        cnt_size
        .groupby(['customer_id'])['size'].rank(method = 'min', ascending=False)
    )

    customer_cnt_max = (
        cnt_size
        .loc[cnt_size['rank'] == 1]
    )

    result = (
        customer_cnt_max
        .merge(products, on = 'product_id', how = 'left')
        .merge(customers, on = 'customer_id', how = 'left')
    )
    return result[['customer_id', 'product_id', 'product_name']]