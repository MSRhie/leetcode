import pandas as pd

def find_customers(customer: pd.DataFrame, product: pd.DataFrame) -> pd.DataFrame:

    result = (
        customer
        .drop_duplicates()
        .groupby('customer_id', as_index=False)
        .agg(
            cnt_product = ('product_key', 'count')
        )
        .loc[lambda d: d['cnt_product'] == len(product), ['customer_id']]
    )
    
    return result