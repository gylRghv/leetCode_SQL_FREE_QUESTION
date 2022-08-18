# Write your MySQL query statement below
with prev_temps as (
    select id, recordDate, temperature, lag(temperature) over (order by recordDate asc) as prev_temp
    from Weather 
)
select id
from prev_temps
where temperature > prev_temp
and date_add(recordDate, interval -1 day) in (select distinct recordDate from Weather)
