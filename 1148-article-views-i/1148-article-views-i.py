import pandas as pd

def article_views(views: pd.DataFrame) -> pd.DataFrame:
    df = views.loc[views['author_id'] == views['viewer_id'], ['author_id']]
    return df.drop_duplicates(['author_id']).sort_values(by = 'author_id', ascending=True).rename({'author_id' : 'id'}, axis = 1)
    