import pandas as pd

# boss와 직접/ 간접으로 리포트를 보낸 사람

def find_reporting_people(employees: pd.DataFrame) -> pd.DataFrame:
    
    boss_direct_id = (
        employees
        .loc[lambda d: (d['manager_id'] == 1) & ~(d['employee_id'] == 1)]
        .drop_duplicates()[['employee_id']]
    )

    indirect_list = []

    for i in range(3) :
        
        if i==0 :
            df = (
                    employees[['employee_id', 'manager_id']]
                    .merge(boss_direct_id, left_on='manager_id', right_on='employee_id', how='inner')[['employee_id_x']]
                    .rename(columns={'employee_id_x': 'employee_id'})
                    .drop_duplicates()
                )

        elif i>=1 :
            before_df = indirect_list[i-1]
            df = (
                    employees[['employee_id', 'manager_id']]
                    .merge(before_df, left_on='manager_id', right_on='employee_id', how='inner')[['employee_id_x']]
                    .rename(columns={'employee_id_x': 'employee_id'})
                    .drop_duplicates()
                )
        indirect_list.append(df)

    result = (
        pd.concat([boss_direct_id]+indirect_list)
        .drop_duplicates()
    )

    return result
    