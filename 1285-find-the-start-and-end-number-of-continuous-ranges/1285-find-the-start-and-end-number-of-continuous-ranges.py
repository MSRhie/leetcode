import pandas as pd

def find_continuous_ranges(logs: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        logs['log_id']
        .reset_index(name='log_id')
        .assign(
            diff = lambda d: d['log_id'] - d['index'],
        )
        .groupby(['diff'], as_index=True)
        .agg(
            start_id=("log_id","min"),
            end_id=("log_id","max")
        )
    )
    
    return result
    
