import pandas as pd

def sum_daily_odd_even(transactions: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        transactions
        .sort_values(['transaction_date'])
        .groupby('transaction_date', as_index=False)
        .agg(
            odd_sum = ('amount', lambda s: s[s % 2 != 0].sum()),
            even_sum = ('amount', lambda s: s[s % 2 == 0].sum())
        )
    )
    return result