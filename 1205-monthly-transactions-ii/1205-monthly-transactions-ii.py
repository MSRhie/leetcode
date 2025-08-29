import pandas as pd

def monthly_transactions(transactions: pd.DataFrame, chargebacks: pd.DataFrame) -> pd.DataFrame:
    # 1) 승인 집계 (월 = transactions.trans_date의 월)
    t = transactions.assign(
        month=lambda d: pd.to_datetime(d['trans_date']).dt.to_period('M').astype(str)
    )
    approved = (
        t.loc[t['state'].eq('approved')]
         .groupby(['month','country'], as_index=False)
         .agg(
             approved_count=('id', 'count'),
             approved_amount=('amount', 'sum')
         )
    )

    # 2) 차지백 집계 (월 = chargebacks.trans_date의 월)
    #    차지백은 chargebacks를 기준으로, 금액/국가를 transactions에서 조인해 가져옵니다.
    c = chargebacks.assign(
        month=lambda d: pd.to_datetime(d['trans_date']).dt.to_period('M').astype(str)
    ).merge(
        transactions[['id','country','amount']],
        left_on='trans_id', right_on='id', how='left'
    )
    chargeback = (
        c.groupby(['month','country'], as_index=False)
         .agg(
             chargeback_count=('trans_id', 'count'),
             chargeback_amount=('amount', 'sum')
         )
    )

    # 3) 두 집계를 월×국가 키로 outer merge
    result = (
        approved.merge(chargeback, on=['month','country'], how='outer')
                .fillna({
                    'approved_count': 0, 'approved_amount': 0,
                    'chargeback_count': 0, 'chargeback_amount': 0
                })
    )

    # 4) 타입 정리 & 정렬 (LeetCode 채점에서 종종 요구)
    for col in ['approved_count', 'chargeback_count']:
        result[col] = result[col].astype(int)
    for col in ['approved_amount', 'chargeback_amount']:
        result[col] = result[col].astype(int)

    return result.sort_values(['month','country']).reset_index(drop=True)


    # .assign(
#     trans_date_trans = lambda d: pd.to_datetime(d['trans_date_trans']).dt.strftime('%Y-%m'),
#     trans_date_charge = lambda d: pd.to_datetime(d['trans_date_charge']).dt.strftime('%Y-%m'),
#     month = lambda d: np.where(d['trans_date_charge'].isnull(), d['trans_date_trans'], d['trans_date_charge']),
#     ls_approved = lambda d: np.where(d['state']=='approved', 1, 0),
#     approved_amount = lambda d: np.where(d['state']=='approved', d['amount'], 0),
#     ls_charge = lambda d: np.where(d['trans_id'].isnull()==False, 1, 0),
#     chargeback_amount = lambda d: np.where(d['trans_id'].isnull()==False, d['amount'], 0)
# )
# # .groupby(['month','country'], as_index=False)
# # .agg(
# #     approved_count = ('ls_approved', 'sum'),
# #     approved_amount = ('approved_amount', 'sum'),
# #     chargeback_count = ('ls_charge', 'sum'),
# #     chargeback_amount = ('chargeback_amount', 'sum')
# # )