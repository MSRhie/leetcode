import pandas as pd

# 영화의 가장 많은 rating을 가진 유저이름을 찾아라, 동점이면 username이 작은 순으로 나열해라
# 2월 2020년에 가장 높은 평균 레이팅을 가진 영화이름을 찾아라, 동점이면 영화이름이 작은 순으로 나열해라
def movie_rating(movies: pd.DataFrame, users: pd.DataFrame, movie_rating: pd.DataFrame) -> pd.DataFrame:
    
    movie_rating = (
        movie_rating
        .drop_duplicates().reset_index()
    )
    
    greatest_num_user_id = (
        movie_rating
        .groupby('user_id')['movie_id'].count().reset_index(name='id_cnt')
        .loc[lambda d: d['id_cnt']==max(d['id_cnt'])]
        .merge(users, on='user_id', how='left')
        .sort_values('name', ascending=True)
        .head(1)
        .loc[:, ['name']].rename(columns={'name':'results'})
    )

    highest_rating_movie_id = (
        movie_rating
        .pipe(lambda d: d.assign(created_at_ym = pd.to_datetime(d['created_at'], '%Y-%m-%d')))
        .query("(created_at_ym >= '2020-02') & (created_at_ym < '2020-03')")
        .groupby('movie_id')['rating'].mean().reset_index(name='avg_rating')
        .loc[lambda d: d['avg_rating']==max(d['avg_rating'])]
        .merge(movies, on='movie_id', how='left')
        .sort_values('title', ascending=True)
        .head(1)
        .loc[:, ['title']].rename(columns={'title':'results'})
    )

    result = (
        pd.concat([greatest_num_user_id, highest_rating_movie_id])
    )
    return result