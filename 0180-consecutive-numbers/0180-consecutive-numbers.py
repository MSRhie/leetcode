import pandas as pd

def consecutive_numbers(logs: pd.DataFrame) -> pd.DataFrame:
    s = logs.sort_values('id')['num']             # ① id 기준 정렬
    mask = s.eq(s.shift(1)) & s.eq(s.shift(2))    # ② 같은 값이 3행 연속인지
    return s[mask].drop_duplicates().to_frame('ConsecutiveNums')