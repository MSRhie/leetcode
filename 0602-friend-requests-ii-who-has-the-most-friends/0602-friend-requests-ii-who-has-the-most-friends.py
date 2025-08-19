import pandas as pd

def most_friends(request_accepted: pd.DataFrame) -> pd.DataFrame:
    result = (
        pd.concat([ # union all 과 pd.concat은 같은 역할 
            request_accepted[['requester_id']].rename(columns={'requester_id':'id'}),
            request_accepted[['accepter_id']].rename(columns={'accepter_id':'id'})
        ], ignore_index=True)
        .groupby('id').size().reset_index(name='num')
        .query("num == num.max()")
    )
    return result