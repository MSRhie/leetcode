import pandas as pd

def find_continuous_ranges(logs: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        logs['log_id']
        .reset_index(name='log_id')
        .assign(
            diff = lambda d: d['log_id'] - d['index'], # 연속이 아닌 값 그룹핑위해 diff 변수 생성
        )
        .groupby(['diff'], as_index=True)
        .agg(
            start_id=("log_id","min"), # 그룹핑 중 최솟값이 start
            end_id=("log_id","max") # 그룹핑 중 최댓값이 end
        )
    )
    
    return result
    
