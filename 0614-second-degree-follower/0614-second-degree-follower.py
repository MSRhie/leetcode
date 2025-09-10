import pandas as pd
# 적어도 followee와 follower가 한명씩 있는 사람 찾을 것
# follower 수가 많은 상위 두명을 follower의 알파벳순으로 정렬해서리턴해라
def second_degree_follower(follow: pd.DataFrame) -> pd.DataFrame:

    follower = (
        follow
        .groupby(['followee'])['follower'].count().reset_index(name='follower_count')
    )

    followee = (
        follow
        .groupby(['follower'])['followee'].count().reset_index(name='followee_count')
    )

    result = (
        followee
        .merge(follower, left_on='follower', right_on='followee', how='inner')
        .drop(['followee_count', 'followee'], axis=1)
        .rename(columns={'follower_count': 'num'})
        .sort_values('follower', ascending=True)
    )
    return result
    