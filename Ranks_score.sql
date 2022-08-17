# Write your MySQL query statement below

#M1
with cte as (
select id, num, lag(num, 1) over (order by id) as prev_num, lag(num, 2) over (order by id) as second_prev_num
from Logs
)
select distinct num as ConsecutiveNums
from cte  
where num = prev_num and num = second_prev_num;


SELECT distinct l1.num as ConsecutiveNums
FROM
     Logs l1,
     Logs l2,
     Logs l3
 WHERE
     l1.Id = l2.Id - 1
     AND l2.Id = l3.Id - 1
     AND l1.Num = l2.Num
     AND l2.Num = l3.Num
 ;
    

with cte as (
SELECT num, lead(num) over (order by id) as lead_num, lag(num) over (order by id) as lag_num 
FROM logs 
    )
    select distinct num as ConsecutiveNums
    from cte 
    where num = lead_num and num = lag_num
