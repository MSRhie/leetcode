import pandas as pd

def count_salary_categories(accounts: pd.DataFrame) -> pd.DataFrame:
    
    category = (
        pd.DataFrame({'category' : ['Low Salary', 'Average Salary', 'High Salary']})
    )
    
    account_groupby = (
        accounts
        .assign(category = lambda d: np.select(
            [
                d['income'] < 20000,
                (d['income'] >= 20000) & (d['income'] <= 50000),
                d['income'] > 50000

            ],
            ['Low Salary', 'Average Salary', 'High Salary'],
            default = 'Unknown'
        ))
        .groupby('category', as_index=False)
        .agg(
            accounts_count = ('account_id', 'count')
        )
    )
    result = (
        category
        .merge(account_groupby, on='category', how='outer')
        .fillna(
            {'accounts_count':0}
        )
    )
    return result