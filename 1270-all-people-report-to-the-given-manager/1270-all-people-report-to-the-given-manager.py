import pandas as pd

# boss와 직접/ 간접으로 리포트를 보낸 사람

def find_reporting_people(employees: pd.DataFrame) -> pd.DataFrame:
    
    boss_direct_id = (
        employees
        .loc[lambda d: (d['manager_id'] == 1) & ~(d['employee_id'] == 1)]
        .drop_duplicates()[['employee_id']]
    )

    boss_indirect_id_1 = (
        employees[['employee_id', 'manager_id']]
        .merge(boss_direct_id, left_on='manager_id', right_on='employee_id', how='inner')[['employee_id_x']]
        .rename(columns={'employee_id_x': 'employee_id'})
        .drop_duplicates()
    )

    boss_indirect_id_2 = (
        employees[['employee_id', 'manager_id']]
        .merge(boss_indirect_id_1, left_on='manager_id', right_on='employee_id', how='inner')[['employee_id_x']]
        .rename(columns={'employee_id_x': 'employee_id'})
        .drop_duplicates()
    )

    boss_indirect_id_3 = (
        employees[['employee_id', 'manager_id']]
        .merge(boss_indirect_id_2, left_on='manager_id', right_on='employee_id', how='inner')[['employee_id_x']]
        .rename(columns={'employee_id_x': 'employee_id'})
        .drop_duplicates()
    )

    result = (
        pd.concat([boss_direct_id, boss_indirect_id_1, boss_indirect_id_2, boss_indirect_id_3])
        .drop_duplicates()
    )

    return result
    