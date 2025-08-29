import pandas as pd

def find_customers(customer: pd.DataFrame, product: pd.DataFrame) -> pd.DataFrame:
    product = (
        product
        .rename(columns={'product_key':'product_key_P'})
    )
    result = (
        customer
        .drop_duplicates()
        .merge(product, right_on='product_key_P', left_on='product_key', how='left')
        .groupby('customer_id', as_index=False)
        .agg(
            cnt_product = ('product_key_P', 'count')
        )
        .loc[lambda d: d['cnt_product'] == len(product), ['customer_id']]
    )
    
    return result