import pandas as pd

# 1. 질문의 응답비율은 유저가 질문에 답변한 횟수다. 유저가 질문을 본(show) 횟수에의해.
# 만약 복수의 질문이 같은 ansower rate를 가진다면, 가장작은 question_id를 보고해라
# 집계낼때 특정 조건을 만족할때 count를 내는 방법 공부 필요
def get_the_question(survey_log: pd.DataFrame) -> pd.DataFrame:

    result_agg = (
        survey_log
        .groupby('question_id', as_index=False)
        .agg(
            summary = ('action', lambda s: (s == 'answer').sum() / (s == 'show').sum())
        )
        .sort_values(['summary', 'summary'], ascending=[False, True])
        .head(1)[['question_id']]
        .rename(columns={'question_id':'survey_log'})
    )
    return result_agg

        #     .assign(
        #     is_answer = lambda d: np.where(d['action'] == 'answer', 1, 0),
        #     is_show = lambda d: np.where(d['action'] == 'show', 1, 0)
        # )