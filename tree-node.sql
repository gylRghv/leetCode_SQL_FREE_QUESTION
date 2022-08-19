# Write your MySQL query statement below
select
id, 
case 
    when p_id is null then 'Root'
    when id in (select distinct p_id from Tree x) then 'Inner'
    else 'Leaf'
end as type
from Tree y
order by id


# x NOT IN (...) is defined as a series of comparisons between x and each of the values returned by the subquery. 
# SQL uses three-value logic, for which the three possible values of a logical expression are true, false or unknown. 
# Comparison of a value to a NULL is unknown and if any one of those NOT IN comparisons is unknown then the result is also deemed to be unknown.
