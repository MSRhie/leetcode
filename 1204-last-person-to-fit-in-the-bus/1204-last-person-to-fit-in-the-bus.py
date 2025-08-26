import pandas as pd

# 무게 1000 키로제한
# 무게 제한을 초과없이 버스에 딱 맞게 탑승하는 마지막 사람의 person_name을 구해라

def last_passenger(queue: pd.DataFrame) -> pd.DataFrame:
    result = (
        queue
        .sort_values('turn')
        .assign(weight_cumsum = lambda d: d['weight'].cumsum())
        .query('weight_cumsum <= 1000').reset_index()
        .pipe(lambda d: d.loc[[len(d)-1], ['person_name']])
        
    )
    return result