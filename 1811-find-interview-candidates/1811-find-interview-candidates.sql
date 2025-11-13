# Write your MySQL query statement below

# 유저들은 3개나 그 이상의 콘테스트에서의 어떠한 메달을 가집니다
# 또는 3개이상의 다른 콘테스트에서 골드메달을 가집니다.
# 시간초과 못품 x
# 원인 : 문제 조건 하나를 뒤늦게 파악

with t0 as (
    select gold_medal as user, contest_id 
    from contests 
    union all 
    select silver_medal as user, contest_id 
    from contests 
    union all 
    select bronze_medal as user, contest_id 
    from contests 
)
, t1 as (
    select user, contest_id, row_number() over(partition by user order by contest_id) as rn 
    from t0 
)
, t2 as (
    select user as user_id -- consecutive medal winners
    from t1 
    group by user, contest_id - rn 
    having count(*) >= 3 -- replace 3 with any number to solve the N problem
    union all
    select gold_medal as user_id  -- gold medal winners
    from contests 
    group by gold_medal 
    having count(*) >= 3
)
select distinct u.name, u.mail 
from t2 
inner join users u
on t2.user_id = u.user_id