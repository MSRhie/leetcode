import pandas as pd

def strong_friendship(friendship: pd.DataFrame) -> pd.DataFrame:

    friendswap = friendship.iloc[:,[1,0]]
    friendship.columns = friendswap.columns = ['user1_id', 'user2_id']
    df = pd.concat([friendship, friendswap])

    friend_set = (df.groupby('user1_id')['user2_id']
                    .agg(set).reset_index(name = 'user_set'))

    df = (df.merge(friend_set, on = 'user1_id')
            .merge(friend_set, left_on = 'user2_id', right_on = 'user1_id', suffixes = ('','_')))

    df['common_friend'] = df.apply(lambda x: x.user_set.intersection(x.user_set_), axis = 1).apply(len)

    return df[df.common_friend >= 3].loc[df.user1_id < df.user2_id].iloc[:,[0,1,5]]  