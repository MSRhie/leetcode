import pandas as pd

def activity_participants(friends: pd.DataFrame, activities: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        friends
        .assign(
            cnt_activity = lambda d: d.groupby(['activity'])['id'].transform('count'),
            max_cnt = lambda d: np.where(
                                        (d['cnt_activity'] == max(d['cnt_activity']))
                                        | (d['cnt_activity'] == min(d['cnt_activity']))
                                        , 1, 0)
        )
        .loc[lambda d: d['max_cnt'] == 0, ['activity']]
        .drop_duplicates()
    )

    
    return result 