import pandas as pd

def suspicious_bank_accounts(accounts: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    
    tran_df = (
        transactions
        .query('type == "Creditor"')
        .merge(accounts, on='account_id', how='left')
        .assign(
                date = lambda d: (d['day'].dt.year - 2020) * 12 + d['day'].dt.month # 달로 전환
                )
        .sort_values(['account_id', 'date'], ascending=True)
        .groupby(['account_id', 'date', 'max_income'], as_index=False)
        .agg(
            sum_amount=('amount', 'sum'),
        )
        .assign(
                flag_susp = lambda d: np.where(d['max_income'] < d['sum_amount'], 1, 0),
                flag_consecutive_susp = lambda d: np.where(d.groupby(['account_id'])['flag_susp'].shift(1) == d.groupby(['account_id'])['flag_susp'].shift(0), 1, 0),
                flag_date = lambda d: np.where((d['date'] == d['date'].shift(1) + 1), 1, 0),
                
                target_susp = lambda d: np.where(
                                                    (
                                                    (d['flag_susp'] == 1) &
                                                    (d['flag_consecutive_susp'] == 1) &
                                                    (d['flag_date'] == 1)
                                                    ), 1, 0)
                )
        .query('target_susp == 1')[['account_id']]
        .drop_duplicates()
    )
    return tran_df