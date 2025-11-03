import pandas as pd

def recent_three_orders(customers: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    merge_df = (
        customers
        .merge(orders, left_on='customer_id', right_on='customer_id', how='left')
        .sort_values(['customer_id', 'order_date'], ascending=False)
    )

    result_le_three = (
        merge_df
        .assign(_filter = lambda d: d.groupby(['customer_id'])['name'].transform('count'))
        .loc[lambda d: (d['_filter'] <= 2) & (d['order_id'].notnull()), ['name', 'customer_id', 'order_id', 'order_date'] ]
    )

    result_gt_three = (
        merge_df
        .assign(_filter = lambda d: d.groupby(['customer_id'])['name'].transform('count'))
        .loc[lambda d: (d['_filter'] >= 3) ]
        .groupby(['customer_id']).head(3)[['name', 'customer_id', 'order_id', 'order_date']]
    )

    result = (
        pd.concat([result_le_three, result_gt_three])
        .sort_values(['name', 'customer_id', 'order_date'], ascending=[True, True, False])
        .rename(columns={'name': 'customer_name'})
    )

    return result