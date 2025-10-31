import pandas as pd

def find_safe_countries(person: pd.DataFrame, country: pd.DataFrame, calls: pd.DataFrame) -> pd.DataFrame:
    
    person_code = (
        person
        .assign(code = lambda d: 
            d['phone_number'].str[:3]
        )
        .merge(country, left_on='code', right_on='country_code', how='left')[['id', 'name_y']]
    )

    calls_id = (
        pd.DataFrame(pd.concat([calls['caller_id'], calls['callee_id']]))
        .rename(columns={0: 'call_id'})
        .drop_duplicates()
        .assign(global_avg = (2 * calls['duration'].sum()) / (2 * calls['duration'].count()))
    )

    id_df = (
        calls_id
        .merge(person_code, left_on='call_id', right_on='id', how='left')
        .drop(columns='id')
    )

    person_caller = (
        id_df
        .merge(calls, left_on='call_id', right_on='caller_id', how='left')
        .groupby(['name_y', 'global_avg'], as_index=False).agg(
           sum_duration = ('duration', 'sum'),
           count_duration = ('duration', 'count')
        )
    )

    person_callee = (
        id_df
        .merge(calls, left_on='call_id', right_on='callee_id', how='left')
        .groupby(['name_y'], as_index=False).agg(
            sum_duration = ('duration', 'sum'),
            count_duration = ('duration', 'count')
        )
    )

    result = (
        person_caller
        .merge(person_callee, on='name_y', how='left')
        .assign(avg_duration = lambda d: (d['sum_duration_x'] + d['sum_duration_y']) / (d['count_duration_x'] + d['count_duration_y']))
        .loc[lambda d: d['avg_duration'] > d['global_avg']]
        .rename(columns={'name_y': 'country'})[['country']]
    )

    return result