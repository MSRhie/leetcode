import pandas as pd

def second_highest_salary(employee: pd.DataFrame) -> pd.DataFrame:
    df = employee.drop_duplicates('salary', keep = 'first')
    if len(df['salary'].unique()) < 2 :
        return pd.DataFrame({'SecondHighestSalary' : [np.NaN]})
    df = df.sort_values('salary', ascending = False).rename({'salary':'SecondHighestSalary'}, axis=1)
    df.drop("id", axis = 1, inplace = True)
    return df.head(2).tail(1)