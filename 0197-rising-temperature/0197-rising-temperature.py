import pandas as pd

def rising_temperature(weather: pd.DataFrame) -> pd.DataFrame:
    # step 1. Converting recordDate to Datetime Type
    weather['recordDate'] = pd.to_datetime(weather['recordDate']) 
    
    # Step 2: Sorting the DataFrame
    weather.sort_values('recordDate', ascending = True, inplace = True)

    # Step 3: Creating Columns for Previous Day's Data
    weather['before_recordDate'] = weather['recordDate'].shift(1)
    weather['before_temperature'] = weather['temperature'].shift(1)
    # Step 4: Filtering for Days with Higher Temperature than the Previous Day
    result = weather[(weather['recordDate'] == weather['before_recordDate'] + pd.Timedelta(days = 1)) &
           (weather['temperature'] > weather['before_temperature'])
    ][['id']].rename({'id':'Id'})
  
    return result
