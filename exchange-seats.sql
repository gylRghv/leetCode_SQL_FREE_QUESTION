# Write your MySQL query statement below
select id, student_temp as student from (
    select
    s1.id, 
    case
        when (s1.id = (select max(s2.id) from Seat s2)) and (mod((select max(s2.id) from Seat s2) ,2) = 1) then s1.student
        when (mod(s1.id,2) = 1 and mod(s1.id+1, 2) = 0) then (select s2.student from Seat s2 where s2.id = s1.id+1)
        when (mod(s1.id-1,2) = 1 and mod(s1.id, 2) = 0) then (select s2.student from Seat s2 where s2.id = s1.id-1)
        else s1.student
    end as student_temp
    from Seat s1
) X
order by 1


--M2 (FAST)
with cte as (
    select id, student, lag(student) over(order by id) as lag_student, lead(student) over(order by id) as lead_student, mod(id,2) as odd_even, (select max(id) from Seat x) as max_id
    from Seat    
)
select 
    id,
    case 
        when odd_even = 1 and id = max_id then student 
        when odd_even = 1 and id < max_id then lead_student
        when odd_even = 0 then lag_student
        else student
    end as student
from cte
order by 1

--M3
SELECT
    IF(id < (SELECT MAX(id) FROM Seat), IF(id % 2 = 0, id-1, id+1), IF(id % 2 = 0, id-1, id)) AS id,
    student
-- from clause:
FROM Seat
-- order by id ascending order:
ORDER BY id ASC;

--M4
select 
    id,
    case 
        when mod(id, 2) = 0 then lag(student) over(order by id)
        else lead(student, 1, student) over(order by id)
    end as Student
from Seat
order by 1

