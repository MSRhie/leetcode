import pandas as pd

def find_managers(employee: pd.DataFrame) -> pd.DataFrame:
    df = employee.groupby('managerId').size().reset_index(name = 'count')
    df = df[df['count'] >= 5]
    managers_info = pd.merge(df, employee, left_on='managerId', right_on='id', how='inner')
    return managers_info[['name']]
