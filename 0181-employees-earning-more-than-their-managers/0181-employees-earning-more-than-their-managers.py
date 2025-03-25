import pandas as pd

def find_employees(employee: pd.DataFrame) -> pd.DataFrame:
    employee = pd.merge(employee,employee, left_on = 'managerId', right_on = 'id', how = 'inner', suffixes = ['_ex','_af'])
    return employee.loc[employee['salary_af'] < employee['salary_ex'], ['name_ex']].rename({'name_ex':'Employee'}, axis=1)
