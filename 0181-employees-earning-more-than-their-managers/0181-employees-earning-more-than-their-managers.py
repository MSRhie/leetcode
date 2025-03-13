import pandas as pd

def find_employees(employee: pd.DataFrame) -> pd.DataFrame:
    df = employee.merge(employee, left_on = 'managerId', right_on = 'id', suffixes = ('_emp', "_mgr"))
    result = df[df["salary_emp"] > df["salary_mgr"]][["name_emp"]]
    result.rename(columns = {'name_emp' : 'Employee'}, inplace = True)
    return result

    