# Write your MySQL query statement below

#M1
with max_salaries as (
    select e.departmentId, d.name as Department, max(e.salary) as max_salary
    from Employee e
    join Department d
    on e.departmentId = d.id
    group by e.departmentId, d.name
    
)

select ms.Department, e.name as Employee, e.salary as Salary
from Employee e
join max_salaries ms
on e.departmentId = ms.departmentId
where e.salary = ms.max_salary;

#M2 -> join condition different
with max_salaries as (
    select e.departmentId, max(e.salary) as max_salary
    from Employee e
    group by e.departmentId  
)

select d.name as `Department`, e.name as Employee, e.salary as Salary
from Employee e
join Department d 
on e.departmentId = d.id
join max_salaries ms
on e.departmentId = ms.departmentId and e.salary = ms.max_salary;

#M3 -> coorelated queries
select d.name as Department, e1.name as Employee, e1.salary as Salary
from Employee e1
join Department d
on e1.departmentId = d.id
where e1.salary IN (
    select max(e2.salary)
    from Employee e2
    where e2.departmentId = e1.departmentId
);
