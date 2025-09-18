import pandas as pd

def team_scores(teams: pd.DataFrame, matches: pd.DataFrame) -> pd.DataFrame:

    # score 생성 #
    score_match = (
        matches
        .assign(
            host_win = lambda d: np.where(d['host_goals'] > d['guest_goals'], 3, 0),
            guest_win = lambda d: np.where(d['guest_goals'] > d['host_goals'], 3, 0),
            draw = lambda d: np.where(d['host_goals'] == d['guest_goals'], 1, 0),
        )
    )

    # host score 생성 #
    host_team = (
        score_match
        .groupby('host_team', as_index=False)
        .agg(
            sum_win = ('host_win', sum),
            sum_draw = ('draw', sum)
        )
    )

    # guest score 생성 #
    guest_team = (
        score_match
        .groupby('guest_team', as_index=False)
        .agg(
            sum_win = ('guest_win', sum),
            sum_draw = ('draw', sum)
        )
    )

    # 키 두개일때, 반드시 키 하나로 통일 #
    team_list = (
        pd.concat([matches['host_team'], matches['guest_team']])
        .drop_duplicates()
        .reset_index(name='team_id')
    )

    # host, guest 결합 #
    sum_score = (
        team_list
        .merge(guest_team, left_on='team_id', right_on='guest_team', how='left')
        .merge(host_team, left_on='team_id', right_on='host_team', how='left')
        .fillna(0)
        .assign(num_points = lambda d: sum([d['sum_win_x'], d['sum_draw_x'], d['sum_win_y'], d['sum_draw_y']]))
    )

    # 후처리 #
    result = (
        teams
        .merge(sum_score[['team_id', 'num_points']], on='team_id', how='left')
        .fillna(0)
        .sort_values(['num_points', 'team_id'], ascending=[False, True])
    )

    return result