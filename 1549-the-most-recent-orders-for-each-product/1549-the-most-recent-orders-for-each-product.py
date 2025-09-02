import pandas as pd
# 각 제품별 가장 최근 주문을 찾아라.
# product_name으로 오름차순정렬 하고 동점일 경우 product_id를 오름차순으로 정렬해라.
# 만약 여전히 동점이면, order_id를 오름차순해라
def most_recent_orders(customers: pd.DataFrame, orders: pd.DataFrame, products: pd.DataFrame) -> pd.DataFrame:
    
    recent_order = (
        orders
        #.sort_values(['product_id', 'order_date'], ascending=False)
        .assign(
            max_order_date = lambda d: d.groupby('product_id')['order_date'].transform('max')
        )
        .query('max_order_date.eq(order_date)')
        .merge(customers, on='customer_id', how='left')
        .merge(products, on='product_id', how='left')
        .loc[:, ['product_name', 'product_id', 'order_id', 'order_date']]
        .sort_values(['product_name', 'product_id', 'order_id'], ascending=[True,True,True])
    )
    return recent_order