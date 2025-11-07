import pandas as pd

def count_apples_and_oranges(boxes: pd.DataFrame, chests: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        boxes
        .merge(chests, on='chest_id', how='left')
        .assign(
            sum_apple_count = lambda d: d['apple_count_x'].fillna(0) + d['apple_count_y'].fillna(0),
            sum_orange_count = lambda d: d['orange_count_x'].fillna(0) + d['orange_count_y'].fillna(0),
        )
        [['sum_apple_count', 'sum_orange_count']]
        .sum()
        .rename({'sum_apple_count': 'apple_count',
                'sum_orange_count': 'orange_count'})
        .to_frame().T
        .reset_index(drop=True)
    )

    return result