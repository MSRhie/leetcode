import pandas as pd
# 
def monthly_transactions(transactions: pd.DataFrame) -> pd.DataFrame:
    df = (
        transactions
        .assign(
            month = lambda d: pd.to_datetime(d['trans_date']).dt.strftime('%Y-%m'),
            Is_approved = lambda d: (d['state'] == 'approved').astype(int),
            sum_approved_amount = lambda d: d['amount'].where(d['state'] == 'approved', 0)
        )
    )
    
    out = (
        df
        .groupby(['month', 'country'], dropna=False, as_index=False)
        .agg(
            trans_count = ('id', 'count'),
            approved_count = ('Is_approved', 'sum'),
            trans_total_amount = ('amount', 'sum'),
            approved_total_amount = ('sum_approved_amount', 'sum')
        )
    )
    
    return out