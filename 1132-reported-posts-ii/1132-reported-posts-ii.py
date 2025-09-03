import pandas as pd

# 스펨으로 보고된후 제거된 포스트들의 일별 평균을 찾아라.
# 1. removals와 actions 결합 : 
def reported_posts(actions: pd.DataFrame, removals: pd.DataFrame) -> pd.DataFrame:
    
    df = (
        actions
        .loc[lambda d: d['extra'] == 'spam', ['extra', 'post_id', 'action_date']]
        .drop_duplicates()
        .merge(removals, on='post_id', how='left')
        .groupby('action_date', as_index=False)
        .agg(
            count_spam = ('extra', 'count'),
            count_remove_spam = ('remove_date', 'count'),
        )
        .assign(
            average_daily_percent = lambda d: round((d['count_remove_spam'] / d['count_spam'])*100, 2)
        )
        .agg(
            average_daily_percent = ('average_daily_percent', 'mean')
        )
        .assign(
            average_daily_percent = lambda d: round(d['average_daily_percent'], 2)
        )
    )

    return df