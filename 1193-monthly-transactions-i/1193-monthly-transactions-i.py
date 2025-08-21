import pandas as pd
# 
def monthly_transactions(transactions: pd.DataFrame) -> pd.DataFrame:
    df = (
        transactions
        .assign(
            month = lambda d: pd.to_datetime(d['trans_date']).dt.strftime('%Y-%m'),
            is_approved = lambda d: (d['state'] == 'approved').astype(int), # 1, 0으로 변환
            amt_approved = lambda d: d['amount'].where(d['state'] == 'approved', 0)
        )
    )
    
    out = (
        df
        .groupby(['month', 'country'], dropna=False, as_index=False)
        .agg(
            trans_count = ('id', 'count'),
            approved_count = ('is_approved', 'sum'),
            trans_total_amount = ('amount', 'sum'),
            approved_total_amount = ('amt_approved', 'sum')
        )
        .sort_values(['month', 'country'])
        .reset_index(drop=True)
    )
    
    return out