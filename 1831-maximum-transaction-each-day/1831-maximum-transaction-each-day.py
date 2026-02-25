import pandas as pd

def find_maximum_transaction(transactions: pd.DataFrame) -> pd.DataFrame:
    result = (
        transactions
        .assign(day = lambda d: d['day'].dt.date)
        .assign(rank = lambda d: d.groupby('day')['amount'].rank(axis=0, method='dense', ascending=False))
        .query('rank == 1')
        .sort_values('transaction_id', ascending=True)[['transaction_id']]
    )
    return result