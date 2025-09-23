import pandas as pd

# 각날의 성별에 대한 총합계를 찾아라
# 성별과 day를 오름차순으로 정렬

def running_total(scores: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        scores
        .sort_values(['gender', 'day'])
        .groupby(['gender', 'day'], as_index=False)
        .agg(
            sum_total = ('score_points', 'sum')
        )
        .assign(total = lambda d: d.groupby(['gender'])['sum_total'].cumsum())
        .loc[:, ['gender', 'day', 'total']]
    )

    return result