import pandas as pd

def count_students(student: pd.DataFrame, department: pd.DataFrame) -> pd.DataFrame:
    student_count = (
        student
        .groupby('dept_id')['student_id']
        .count()
        .reset_index(name='student_number')
    )

    result = (
        department
        .merge(student_count, on='dept_id', how='outer')
        .assign(student_number = lambda d: d['student_number'].fillna(0))
        .drop(['dept_id'], axis=1)
        .sort_values(['student_number', 'dept_name'], ascending=[False, True])
    )

    return result