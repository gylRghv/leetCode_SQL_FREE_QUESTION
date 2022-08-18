# Write your MySQL query statement below
with ranked_salaries as (
    select departmentId, salary, dense_rank() over (partition by departmentId order by salary desc) as pos
    from Employee
)
, max_3_salaries as ( 
    select distinct departmentId, salary
    from ranked_salaries 
    where pos <= 3
)
, emp_dept as (
    select e.departmentId, e.name, e.salary
    from Employee e
    join max_3_salaries ms
    on e.departmentId = ms.departmentId
    and e.salary = ms.salary
)
, result as (
select d.name as 'Department', ed.name as `Employee`, ed.salary
    from emp_dept ed
    join department d
    on ed.departmentId = d.id
)
select * from result
