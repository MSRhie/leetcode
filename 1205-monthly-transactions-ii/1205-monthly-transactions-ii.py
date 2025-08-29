import pandas as pd

def monthly_transactions(transactions: pd.DataFrame, chargebacks: pd.DataFrame) -> pd.DataFrame:
    tran_groupby=(
        transactions
        .assign(
            month = lambda d: d['trans_date'].dt.strftime('%Y-%m'),
            ls_approved = lambda d: np.where(d['state'] == 'approved', 1, 0),
            ls_approved_amount = lambda d: np.where(d['state'] == 'approved', d['amount'], 0)
            )
        .groupby(['country', 'month'], as_index=False)
        .agg(
            approved_count = ('ls_approved', 'sum'),
            approved_amount = ('ls_approved_amount', 'sum')
        )
    )
    
    charge_groupby=(
        chargebacks
        .merge(transactions[['id', 'country', 'amount']], left_on='trans_id', right_on='id', how='left')
        .assign(
            month = lambda d: d['trans_date'].dt.strftime('%Y-%m'),
            ls_trans_id = lambda d: np.where(d['trans_id'].notnull(), 1, 0),
            ls_chargeback_count = lambda d: np.where(d['trans_id'].notnull(), 1, 0),
        )
        .groupby(['month', 'country'], as_index=False)
        .agg(
            chargeback_count = ('ls_chargeback_count', 'sum'),
            chargeback_amount = ('amount', 'sum')
        )
        .rename(columns={'amount':'chargeback_amount'})
    )

    merge_df=(
        tran_groupby
        .merge(charge_groupby, on=['month','country'], how='outer')
        .fillna(
            {
                'approved_count':0,
                'approved_amount':0,
                'chargeback_count':0,
                'chargeback_amount':0
            }
        )
        #.loc[:, ['month', 'country', 'approved_count', 'approved_amount', 'chargeback_amount']]
    )


    return merge_df

