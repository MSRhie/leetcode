import pandas as pd

# 1. user1_id와 user2_id 가 공통 user1==1 인 행을 뽑고, 그 user_id별 cocnat 진행 : 2,3,4,1
# 2. likes를 left join page_id가 붙음
# 3. 1에 user_id에 다시 likes 테이블에 user_id가 1인 조건으로 page_id 붙임 -> 붙인값과 2에서 join한값이 같으면 삭제


def page_recommendations(friendship: pd.DataFrame, likes: pd.DataFrame) -> pd.DataFrame:

    condition_df = (
        friendship
        .loc[lambda d: (d['user1_id'] == 1) | (d['user2_id'] == 1)]
    )

    id_df = (
        pd.concat([condition_df['user1_id'], condition_df['user2_id']])
        .drop_duplicates()
        .to_frame(name='id')
        .sort_values('id')
    )

    likes_id1 = likes.loc[lambda d: d['user_id']==1]['page_id'].drop_duplicates()
    
    likes_df = (
        id_df
        .merge(likes, left_on='id', right_on='user_id', how='left')
        .loc[lambda d: ~d['page_id'].isin(likes_id1), ['page_id']]
        .drop_duplicates()
        .dropna()
        .rename(columns={'page_id': 'recommended_page'})
    )

    return likes_df