import pandas as pd

def rising_temperature(weather: pd.DataFrame) -> pd.DataFrame:
    df = weather.copy()
    df['id'] = weather['id'] + 1
    df2 = weather.merge(df, left_on = 'id', right_on = 'id', how = 'left', suffixes  = ['_af', '_bf'])
    df3 = df2.loc[df2['temperature_af'] - df2['temperature_bf'] > 0, ['id']].rename({'id':'Id'}, axis = 1)
    return df3
