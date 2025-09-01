import pandas as pd

def tree_node(tree: pd.DataFrame) -> pd.DataFrame:
    root = (
        tree
        .assign(
            ls_id = lambda d: d['id'].isin(d['p_id']),
            type = lambda d: np.select(
            [
                d['p_id'].isna().to_numpy(),                 # True/False ndarray
                d['ls_id'].eq(False)
            ],
            ['Root', 'Leaf'],
            default='Inner'
        ))
        .drop(['p_id', 'ls_id'], axis=1)
    )
    return root
# d['p_id'].eq(2).fillna(False).to_numpy()     # NA → False 후 ndarray