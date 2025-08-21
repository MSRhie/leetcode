import pandas as pd

def order_scores(scores: pd.DataFrame) -> pd.DataFrame:
    result = (
        scores
        .assign(rank = lambda d: d['score'].rank(method = 'dense', ascending = False))
        .sort_values(['score'], ascending = False)
        .loc[:,['score', 'rank']]
    )
    return result