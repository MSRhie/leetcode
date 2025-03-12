import pandas as pd

def find_employees(employee: pd.DataFrame) -> pd.DataFrame:
    df = employee.merge(employee, left_on = 'managerId', right_on = 'id', how = 'inner', suffixes = ['_ex','_manager'])
    return df.loc[df['salary_ex'] - df['salary_manager'] > 0 , ['name_ex']].rename({'name_ex' : 'Employee'}, axis = 1)
