import pandas as pd
# 같은 salay를 가진 팀으로 구성하려고 함
# 조건
#  1) 각 팀은 최소 2명 이상, 한명은 제외됨
#  2) 팀 id가 오름차순으로 salary가 높음
#     단, 제외된 사람을 팀 id RANK에 제외할 것
# team_id별 오름차순, 동점일땐 employee_id의 오름차순으로.
def employees_of_same_salary(employees: pd.DataFrame) -> pd.DataFrame:
    
    result_df = (
        employees
        .assign(
            flag_unique_salary = lambda d: d.groupby(['salary'])['employee_id'].transform('count')
        )
        .query('flag_unique_salary >= 2')
        .assign(
            team_id = lambda d: d['salary'].rank(method='dense')
        )
        .sort_values(['salary', 'team_id'], ascending=[True, True])[['employee_id', 'name', 'salary', 'team_id']]
    )

    return result_df