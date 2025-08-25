import pandas as pd

def immediate_food_delivery(delivery: pd.DataFrame) -> pd.DataFrame:
    result = (
        delivery
        .sort_values(['customer_id','order_date'])
        .drop_duplicates(['customer_id'], keep='first')
        .assign(
            order_date = lambda d: pd.to_datetime(d['order_date'], "%Y-%m-%d"),
            customer_pref_delivery_date = lambda d: pd.to_datetime(d['customer_pref_delivery_date'], "%Y-%m-%d"),
            imm_cnt = lambda d: np.where(d['order_date'] == d['customer_pref_delivery_date'], 1, 0)
        )
        .pipe(lambda d: pd.DataFrame({
                                    'immediate_percentage': [round(mean(d['imm_cnt'])*100,2)]
                                    })
        )
        
    )
        
    return result