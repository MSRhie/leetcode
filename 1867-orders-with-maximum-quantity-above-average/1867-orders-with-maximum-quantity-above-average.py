import pandas as pd

def orders_above_average(orders_details: pd.DataFrame) -> pd.DataFrame:
    
    order_df = (
        orders_details
        .assign(
                average = lambda d: d.groupby(['order_id'])['quantity'].transform('mean'),
                max_order = lambda d: d.groupby(['order_id'])['quantity'].transform('max'),
                flag_exceed = lambda d: np.where(d['max_order'] > d['average'].max(), 1, 0)
        )
        .query('flag_exceed == 1')
        .loc[:][['order_id']].drop_duplicates()
    )

    return order_df