import pandas as pd

# contacts_cnt
# 1. contacts 테이블의 user_id별 갯수
# trusted_contracts_cnt
# 1. contacts 테이블의 contact_name 이 customer_name에 있는 갯수

def count_trusted_contacts(customers: pd.DataFrame, contacts: pd.DataFrame, invoices: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        invoices
        .merge(customers[['customer_id','customer_name']], left_on='user_id', right_on='customer_id')
        .merge(contacts, on='user_id', how='left')
        .merge(customers[['customer_name','email']], left_on='contact_name', right_on='customer_name', how='left', suffixes=('_cust','_contact'))
        .assign(trusted = lambda d: d['email'].notnull().astype(int))
        .groupby(['invoice_id','customer_name_cust','price'], as_index=False)
        .agg(
            contacts_cnt = ('contact_name','count'),
            trusted_contacts_cnt = ('trusted','sum')
        )
        .rename(columns={'customer_name_cust':'customer_name'})
    )
    return result