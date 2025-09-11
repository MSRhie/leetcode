import pandas as pd

def unpopular_books(books: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    books = books[books['available_from'] < '2019-05-23']
    orders = orders[orders['dispatch_date'] > '2018-06-23']
    orders = orders.groupby('book_id')['quantity'].sum()
    orders = orders[orders >= 10]
    return books[~books['book_id'].isin(orders.index)][['book_id', 'name']]