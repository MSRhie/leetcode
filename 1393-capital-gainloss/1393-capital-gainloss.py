import pandas as pd

def capital_gainloss(stocks: pd.DataFrame) -> pd.DataFrame:
    
    result = (
        stocks
        .sort_values(['stock_name', 'operation_day'])
        .assign(
            price = lambda d: np.select(

                [(d['operation'] == 'Buy'),
                (d['operation'] == 'Sell')],

                [d['price'] * -1, d['price']]
            ),

            capital_gain_loss = lambda d: d.groupby('stock_name')['price'].cumsum()
        )
        .groupby('stock_name').tail(1)[['stock_name', 'capital_gain_loss']]
    )
    return result