# Write your MySQL query statement below

# M1
select distinct email as Email
from (
    select email, count(email) as email_count
    from Person p
    group by 1 
) x
where email_count > 1;

# M2
with emails_counts as (
    select email, count(email) as email_count
    from Person p
    group by 1
)

select distinct email as Email 
from emails_counts
where email_count > 1;

#M3
select Email
from Person
group by Email
having count(Email) > 1;
