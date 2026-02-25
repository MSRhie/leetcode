import pandas as pd

def league_statistics(teams: pd.DataFrame, matches: pd.DataFrame) -> pd.DataFrame:
    
    matches_result = (
        matches
        .assign(score_result = lambda d: np.select(
            [(d['home_team_goals'] > d['away_team_goals']),
            (d['home_team_goals'] < d['away_team_goals']),
            (d['home_team_goals'] == d['away_team_goals']),],
            ['home_win', 'away_win', 'draw']
            )
        )
        .assign(home_score = lambda d: np.select(
            [d['score_result'] == 'home_win',
            d['score_result'] == 'draw'],
            [3, 1])
        )

        .assign(away_score = lambda d: np.select(
            [d['score_result'] == 'away_win',
            d['score_result'] == 'draw'],
            [3, 1])
        )
    )

    home_team_df = (
                    matches_result[['home_team_id', 'home_score', 'home_team_goals', 'away_team_goals']]
                    .rename(columns={'home_team_id': 'team_id',
                            'home_score': 'score',
                            'home_team_goals': 'goals_for',
                            'away_team_goals': 'goals_against'
                            })
    )
    
    away_team_df = (
                    matches_result[['away_team_id', 'away_score', 'home_team_goals', 'away_team_goals']]
                    .rename(columns={'away_team_id': 'team_id',
                            'away_score': 'score',
                            'home_team_goals': 'goals_against',
                            'away_team_goals': 'goals_for'
                            }) # TEAM KEY관점으로 변수이름 바꿔주는게 포인트 
    )

    reuslt = (
        pd.concat([home_team_df, away_team_df])
        .fillna(0)
        .merge(teams, left_on='team_id', right_on='team_id', how='left')
        .groupby(['team_name'], as_index=False)
        .agg(
            matches_played=('team_id', 'count'),
            points=('score', 'sum'),
            goal_for=('goals_for', 'sum'),
            goal_against=('goals_against', 'sum'),
        )
        .assign(goal_diff = lambda d: d['goal_for'] - d['goal_against'])
        .sort_values(['points', 'goal_diff', 'team_name'], ascending=[False, False, True])
    )

    return reuslt