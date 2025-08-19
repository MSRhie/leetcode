import pandas as pd

def restaurant_growth(customer: pd.DataFrame) -> pd.DataFrame:
    result = (
        customer
        .groupby('visited_on')['amount'].sum().reset_index(name = 'sum_amount')
        .assign(
                amount = lambda d: d['sum_amount'].rolling(7, min_periods = 7).sum().round(2),
                average_amount = lambda d: d['sum_amount'].rolling(7, min_periods = 7).mean().round(2)
                )
        .query('amount.notnull()')
        .drop(['sum_amount'], axis = 1)
    )
    return result