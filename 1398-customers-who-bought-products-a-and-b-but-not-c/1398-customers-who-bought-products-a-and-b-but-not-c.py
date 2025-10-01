import pandas as pd
# A,B를 사나 C를 안산 사람 뽑기
def find_customers(customers: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    # A or B 조건 뽑고
    AB_in = (
        orders 
        .loc[lambda d: (d['product_name'].isin(['A', 'B'])) , ['customer_id', 'product_name']]
        .drop_duplicates()
    )

    # A & B 조건 적용 
    AB_in = (
        AB_in
        .groupby(['customer_id'])
        .filter(lambda d: d['product_name'].nunique()==2)[['customer_id']]
        .drop_duplicates()
    )


    C_in = (
        orders 
        .loc[lambda d: (d['product_name'].isin(['C'])), ['customer_id']]
        .drop_duplicates()['customer_id']
        .tolist()
    )

    result = (
        AB_in
        .loc[lambda d: ~d['customer_id'].isin(C_in)]
        .merge(customers[['customer_id', 'customer_name']], on='customer_id', how='left')
    )


    return result