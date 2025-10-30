import pandas as pd

# def calculate_salaries(salaries: pd.DataFrame) -> pd.DataFrame:
#     taxes = (
#         salaries
#         .groupby(['company_id'], as_index=False)['salary'].max()
#         .assign(_jurging = lambda d: np.select(
#             [d['salary'].lt(1000), (d['salary'].ge(1000) & d['salary'].le(10000)), d['salary'].gt(10000)],
#             [0.00, 0.24, 0.49]
#             )
#         )[['company_id', '_jurging']]
#     )

#     result = (
#         salaries
#         .merge(taxes, on='company_id', how='left')
#         .assign(salary = lambda d: (d['salary'] - d['salary']*d['_jurging']).round(0).astype(int))
#         .drop(columns='_jurging')
#     )

#     return result


    
def calculate_salaries(salaries: pd.DataFrame) -> pd.DataFrame:
    
    # Find max salary for all companies 
    salaries['max_sal'] = salaries.groupby('company_id')['salary'].transform('max')

    # Create a tax rate column (1 - tax rate)
    salaries['tax_rate'] = salaries['max_sal'].apply(lambda x: 1 if x < 1000 else(.76 if x <= 10000 else (.51)))

    # Multiply salary by tax_rate 
    salaries['post_tax'] = (salaries['salary'] * salaries['tax_rate']).apply(lambda x: round(x) if x % 1 != 0.5 else (np.ceil(x)))

    salaries = salaries.drop(columns=['salary','max_sal','tax_rate']).rename(columns={'post_tax':'salary'})

    return salaries