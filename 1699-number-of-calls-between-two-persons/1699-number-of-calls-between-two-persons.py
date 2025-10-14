import pandas as pd
# person1과 person2의 유닉한 사람들사이의 총 통화 기간과 통화 횟수를 보고해라.
# 단, person1 < peron2 일때.

def number_of_calls(calls: pd.DataFrame) -> pd.DataFrame:

    df = (
        calls
        .assign(
            person1 = lambda d: np.where(d['from_id'] > d['to_id'], d['to_id'], d['from_id']),
            person2 = lambda d: np.where(d['from_id'] > d['to_id'], d['from_id'], d['to_id'])
        )
        .groupby(['person1', 'person2'], as_index=False)
        .agg(
            call_count = ('duration', 'count'),
            total_duration = ('duration', 'sum')
        )
    )
    
    return df