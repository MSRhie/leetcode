import pandas as pd

def find_managers(employee: pd.DataFrame) -> pd.DataFrame:
    df = employee.groupby('managerId')['name'].size().reset_index(name='Count')
    df = df[df['Count'] >= 5]
    df_name = pd.merge(employee, df, left_on = 'id', right_on = 'managerId', how = 'inner')
    return df_name[['name']]
