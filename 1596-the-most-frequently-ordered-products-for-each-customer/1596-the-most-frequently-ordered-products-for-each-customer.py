import pandas as pd

def most_frequently_products(customers: pd.DataFrame, orders: pd.DataFrame, products: pd.DataFrame) -> pd.DataFrame:
    cnt_size = (
        orders
        # customer_id, product_id 별 카운트 / 이때 reset_index로 size 생성 변수 이름 지정 -> groupby이므로 cusotmer_id, product_id 두개 변수 추가 됨
        .groupby(['customer_id', 'product_id']).size()
        .reset_index(name = 'size')
    )
    # 결과가 series 일때 아래와 같이 변수 추가 가능 -> rank 변수 cnt_size 데이터에 추가
    cnt_size['rank'] = (
        cnt_size
        .groupby(['customer_id'])['size'].rank(method = 'min', ascending=False)
    )
    # 필터 
    customer_cnt_max = (
        cnt_size
        .loc[cnt_size['rank'] == 1]
    )

    result = (
        customer_cnt_max
        .merge(products, on = 'product_id', how = 'left')
        .merge(customers, on = 'customer_id', how = 'left')
    )
    return result[['customer_id', 'product_id', 'product_name']]