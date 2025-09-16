import pandas as pd

def active_businesses(events: pd.DataFrame) -> pd.DataFrame:
    
    group_event = (
        events
        .assign(avg = lambda d: d.groupby('event_type')['occurrences'].transform('mean'))
        .loc[lambda d : d['occurrences'] > d['avg']]
        .groupby('business_id')['event_type'].count().reset_index(name='cnt')
        .loc[lambda d: d['cnt'] >= 2, ['business_id']]
        .drop_duplicates()
    )

    return group_event