import pandas as pd

def tree_node(tree: pd.DataFrame) -> pd.DataFrame:

    result = (
        tree
        .assign(
            is_id_in_pid = lambda d: d['id'].isin(d['p_id']),
            type = lambda d: np.select(
                [
                d['p_id'].isnull().eq(True),
                d['is_id_in_pid'].eq(False),
                ],
                ['Root', 'Leaf'],
                default='Inner'
            )
        )
        .loc[:, ['id', 'type']]
    )

    return result
