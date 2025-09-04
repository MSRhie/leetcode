import pandas as pd

def winning_candidate(candidate: pd.DataFrame, vote: pd.DataFrame) -> pd.DataFrame:

    result = (
        vote
        .groupby('candidateId')['id'].count().reset_index(name='votes')
        .sort_values('votes')
        .tail(1)[['candidateId']]
    )

    result = (
        candidate
        .merge(result, left_on='id', right_on='candidateId', how='left')
        .query('candidateId.notnull()')[['name']]
    )

    return result
    