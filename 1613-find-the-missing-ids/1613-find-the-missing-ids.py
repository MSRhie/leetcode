import pandas as pd

def find_missing_ids(customers: pd.DataFrame) -> pd.DataFrame:

    list_id = customers['customer_id'].to_list()
    under_100 =[x for x in list_id if x <= 100]

    all_id = []
    for i in range(1, max(under_100)+1) :
        all_id.append(i)

    df_under_id = pd.DataFrame({'id_under': under_100}) # 시리즈 결합시 Join key 이름을 다르게 해야 함
    df_all_id = pd.DataFrame({'id': all_id})

    result = (
        df_all_id
        .merge(df_under_id, left_on='id', right_on='id_under', how='left')
        .loc[lambda d: d['id_under'].isnull()]
        .drop(['id_under'], axis=1)
        .rename(columns={'id': 'ids'})
    )
    return result