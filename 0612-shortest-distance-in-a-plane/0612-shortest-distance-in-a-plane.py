import pandas as pd

def shortest_distance(point2_d: pd.DataFrame) -> pd.DataFrame:

    cross_merge = (
        point2_d
        .merge(point2_d,  how='cross')
        .loc[lambda d: (d['x_x'] == d['x_y']) & (d['y_x'] == d['y_y'])==False]
        .assign(
            shortest = lambda d: np.sqrt((d['x_x']-d['x_y'])**2 + (d['y_x']-d['y_y'])**2).round(2)
            )
        .pipe(lambda d: d.loc[d['shortest'] == d['shortest'].min(), ['shortest']])
        .drop_duplicates()
    )

    return cross_merge
    