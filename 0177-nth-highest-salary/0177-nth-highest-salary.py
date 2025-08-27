import pandas as pd

def nth_highest_salary(employee: pd.DataFrame, N: int) -> pd.DataFrame:
    result = (
        employee
        .drop_duplicates('salary')
        .assign(rank = lambda d: d['salary'].rank(method='dense', ascending = False))
        .query("rank == @N")
        .loc[:, ['salary']]
        .rename(columns = {'salary' : 'getNthHighestSalary({})'.format(N)})
        .pipe(lambda d: d if len(d) >= 1 else pd.DataFrame({'getNthHighestSalary({})'.format(N):[None]}))
    )
    return result