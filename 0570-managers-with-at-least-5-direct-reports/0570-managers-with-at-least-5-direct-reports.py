import pandas as pd
# 적어도 5개의 직접 보고된 managerId를 찾아라
def find_managers(employee: pd.DataFrame) -> pd.DataFrame:
    result = (
        employee
        .groupby(['managerId']).size().reset_index(name = 'cnt_managerId')
        .query('cnt_managerId >= 5')
        .merge(employee, left_on = 'managerId', right_on = 'id', how = 'inner')
        .loc[:, ['name']]
        .pipe(lambda d: d if len(d) >= 1 else pd.DataFrame(columns = ['name']))
    )
    return result
