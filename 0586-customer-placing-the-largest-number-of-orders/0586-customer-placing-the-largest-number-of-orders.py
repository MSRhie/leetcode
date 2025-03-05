import pandas as pd

def largest_orders(orders: pd.DataFrame) -> pd.DataFrame:
    # 고객별 order_number 합계 계산
    customer_order_mod = orders['customer_number'].mode().to_frame()
    return customer_order_mod