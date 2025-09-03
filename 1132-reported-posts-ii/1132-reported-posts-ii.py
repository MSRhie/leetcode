import pandas as pd

# 스펨으로 보고된후 제거된 포스트들의 일별 평균을 찾아라.
# 1. removals와 actions 결합 : 
def reported_posts(actions: pd.DataFrame, removals: pd.DataFrame) -> pd.DataFrame:
    
    df = (
        actions
        # 1) 스팸 신고만 남기고 필요한 열만
        .loc[lambda d: (d['action'].eq('report')) & (d['extra'].eq('spam')),
             ['action_date', 'post_id']]
        # 2) 같은 날 같은 게시글 중복 신고 제거 → ‘게시글’ 단위로 카운트
        .drop_duplicates(subset=['action_date', 'post_id'])
        # 3) 제거 여부 붙이기
        .merge(removals, on='post_id', how='left')
        # 4) 날짜별 집계 (신고된 게시글 수 / 그중 제거된 게시글 수)
        .groupby('action_date', as_index=False)
        .agg(
            reported=('post_id', 'size'),
            removed=('remove_date', lambda s: s.notna().sum())
        )
        # 5) 일별 퍼센트 (반올림 X)
        .assign(average_daily_percent=lambda d: d['removed'] / d['reported'] * 100)
        # 6) 일별 퍼센트의 평균만 최종 반올림
        .agg(average_daily_percent=('average_daily_percent', 'mean'))
        .round(2)
    )

    return df