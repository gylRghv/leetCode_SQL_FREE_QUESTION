# Please write a DELETE statement and DO NOT write a SELECT statement.
# Write your MySQL query statement below


with min_ids as (
    select min(id) as min_id from person
    group by email
)
delete from Person p2 where id not in (
    select min_id
    from min_ids 
)
