import pandas as pd

def bank_account_summary(users: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    
    paid_by_tran = (
        transactions
        .groupby('paid_by', as_index=False)['amount'].sum()
        .rename(columns={'paid_by': 'user_id', 'amount': 'paid_by_amount'})
    )

    paid_to_tran = (
        transactions
        .groupby('paid_to', as_index=False)['amount'].sum()
        .rename(columns={'paid_to': 'user_id', 'amount': 'paid_to_amount'})
    )

    result = (
        users
        .merge(paid_by_tran, on='user_id', how='left')
        .merge(paid_to_tran, on='user_id', how='left')
        .assign(
            credit=lambda d:
                d['credit']
                - d['paid_by_amount'].fillna(0)
                + d['paid_to_amount'].fillna(0),
            credit_limit_breached = lambda d: np.where(d['credit'] < 0, 'Yes', 'No')
        )[["user_id", "user_name", "credit", "credit_limit_breached"]]
    )

    return result