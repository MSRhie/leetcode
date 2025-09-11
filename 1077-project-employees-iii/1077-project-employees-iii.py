import pandas as pd

def project_employees(project: pd.DataFrame, employee: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        project
        .merge(employee, on='employee_id', how='left')
        .assign(
            max_year = lambda d: d.groupby('project_id')['experience_years'].transform('max')
        )
        .loc[lambda d: d['experience_years'] == d['max_year'], ['project_id', 'employee_id']]
    )
    return result