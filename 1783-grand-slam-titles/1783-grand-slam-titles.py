import pandas as pd

def grand_slam_titles(players: pd.DataFrame, championships: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        pd.concat([championships['Wimbledon'], championships['Fr_open'], championships['US_open'], championships['Au_open']])
        .to_frame()
        .rename(columns={0: 'player_id'})
        .groupby(['player_id'], as_index=False)
        .agg( grand_slams_count = ('player_id', 'count'))
        .merge(players, on='player_id', how='left')
    )

    return result