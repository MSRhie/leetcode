import pandas as pd

def eval_expression(variables: pd.DataFrame, expressions: pd.DataFrame) -> pd.DataFrame:
    result = (
        expressions
        .merge(variables, left_on='left_operand', right_on='name')
        .rename(columns={'name': 'left_name'})
        .merge(variables, left_on='right_operand', right_on='name')
        .rename(columns={'name': 'right_name'})
        .assign(
            value = lambda d:
            np.select(
                [d['operator'].eq('>'), d['operator'].eq('<'), d['operator'].eq('=')],
                [d['value_x'].gt(d['value_y']), d['value_x'].lt(d['value_y']), d['value_x'].eq(d['value_y'])]
            ).astype('bool').astype('str')
        )
        .assign(
            value = lambda d:
            np.select(
                [d['value'].eq('False'), d['value'].eq('True')],
                ['false', 'true']
            )
        )
        .drop(columns=['left_name', 'value_x', 'right_name', 'value_y'])
    )


    return result