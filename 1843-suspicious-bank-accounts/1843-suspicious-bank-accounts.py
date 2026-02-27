import pandas as pd

def suspicious_bank_accounts(accounts: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    # 실제 결과에 활용되지 않는 중간 과정의 변수는 접두사에 _ 붙이기
    # 행 갯수에 영향을 주는 조건식은 먼저 flag 변수로 흔적을 남기고, 의도한대로 잘 뽑혔는지 확인 후 조건 걸기
    # (문제에 해당) 날짜 조건으로 연속되는 조건이 필요하다면, 해당 날짜 조건의 단위(여기선 달)에 맞춰서 수치 변환해주기
    df = (
        transactions
        .query('type=="Creditor"')
        .assign(
                _year = lambda d: d['day'].dt.strftime('%Y').astype(int),
                _month = lambda d: d['day'].dt.strftime('%m').astype(int),
                months = lambda d: d['_year'] * 12 + d['_month'] # 날짜를 기준 월의 수치형 값으로 바꿔주기
        )
        .sort_values(['months'])
        .merge(accounts, on='account_id', how='left')
        .groupby(['account_id', 'max_income', 'months'], as_index=False)
        .agg(
            _sum_amount = ('amount', sum)
        )
        .assign(
            _flag_exceed = lambda d: np.where( d['_sum_amount'] > d['max_income'], 1, 0),
            _flag_consecutive_exceed = lambda d: np.where(
                (
                (d.groupby(['account_id'])['months'].shift(1) == (d['months']-1)) & # (1)
                (d['_flag_exceed'] == 1) & (d.groupby(['account_id'])['_flag_exceed'].shift(1) == 1)# (2)
                ), 1, 0) # (1)account_id 별로 날짜가 연속일때 (2)금액이 초과된 경우가 전날과, 현재일때 1 그외 0 
            )
        .query('_flag_consecutive_exceed==1') # 필터
        .loc[:][['account_id']]
        .drop_duplicates()
    )
    return df