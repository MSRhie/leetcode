import pandas as pd

def highest_grade(enrollments: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        enrollments
        .sort_values(['student_id', 'grade', 'course_id'], ascending=[True, False, True])
        .groupby('student_id').head(1)
    )
    return result