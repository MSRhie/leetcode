import pandas as pd
# player_id별 날짜별로 played한 횟수를 구하고
# games_played_so_far로 누적합을 구해라

def gameplay_analysis(activity: pd.DataFrame) -> pd.DataFrame:

    activity = (
        activity
        .sort_values(['player_id', 'event_date'])
        .assign(
            games_played_so_far = lambda d: d.groupby('player_id')['games_played'].cumsum()
        )
        .drop(['device_id', 'games_played'], axis=1)
        .sort_values(['player_id', 'event_date'], ascending=[True, False])
    )
    return activity
    