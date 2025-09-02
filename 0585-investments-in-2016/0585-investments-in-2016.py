import pandas as pd

# tiv_2016의 총 합계를 내라. 이때 두번째 자리에서 반올림할 것.
# 조건 1. tiv_2025가 다른 보험금이 하나이상 같아야 할 것
# 조건 2. 다른 보험소유자와 같은 위치에 있지 않을것

def find_investments(insurance: pd.DataFrame) -> pd.DataFrame:

    con1 = (
        insurance
        .assign( count = lambda d: d.groupby(['lat', 'lon'])['pid'].transform('count'))
        .query('count < 2')[['pid']]
    )

    con2 = (
        insurance
        .assign( count = lambda d: d.groupby(['tiv_2015'])['pid'].transform('count'))
        .query('count >= 2')[['pid']]
    )

    con = (
        con1
        .merge(con2, on='pid', how='inner')
        .drop_duplicates()
    )

    result = (
        insurance
        .merge(con,  on='pid', how='inner')
        .agg(tiv_2016 = ('tiv_2016', 'sum'))
        .round(2)
    )
    return result

    # latlon = lambda d: d[['lat', 'lon']].astype(str).agg("_".join, axis=1)