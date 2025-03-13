import pandas as pd

def find_customer_referee(customer: pd.DataFrame) -> pd.DataFrame:
    customer['referee_id'].fillna(1, inplace = True)
    print(customer)
    return customer.loc[customer['referee_id'] != 2, ['name']]
    
    