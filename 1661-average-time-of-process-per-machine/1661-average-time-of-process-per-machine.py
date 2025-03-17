import pandas as pd

def get_average_time(activity: pd.DataFrame) -> pd.DataFrame:

    activity.loc[activity['activity_type'] == 'start', 'timestamp'] *= -1
    sum_machine_process = activity.groupby(['machine_id', 'process_id'], as_index=False)['timestamp'].sum()

    mean_machine = sum_machine_process.groupby(['machine_id'], as_index=False)['timestamp'].mean().round(3).rename(columns = {'timestamp': 'processing_time'})
    
    return mean_machine