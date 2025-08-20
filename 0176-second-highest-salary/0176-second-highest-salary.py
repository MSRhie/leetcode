import pandas as pd

def second_highest_salary(employee: pd.DataFrame) -> pd.DataFrame:
    result = (
        employee
        .drop_duplicates(['salary'])
        .assign(rank = lambda d: d['salary'].rank(method = 'min', ascending = False))
        .query('rank == 2')
        .loc[:, 'salary'].reset_index()
        .rename(columns = {'salary' : 'SecondHighestSalary'})
        .drop('index', axis = 1)
        .pipe(lambda d: d if len(d) > 0 else pd.DataFrame({'SecondHighestSalary' : [None]}))
    )


    return result