import pandas as pd

def article_views(views: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        views
        .loc[:, ['article_id', 'viewer_id', 'view_date']]
        .sort_values(['viewer_id', 'view_date', 'article_id'])
        .drop_duplicates() # 중복 article_id 제거
        .assign(article_id_cnt = lambda d: d.groupby(['viewer_id', 'view_date'])['article_id'].transform('count'))
        .loc[lambda d: d['article_id_cnt'] >= 2, ['viewer_id']]
        .drop_duplicates()
        .rename(columns={'viewer_id': 'id'})
    )

    return result