create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries values ('A','Bangalore','A@gmail.com',1,'CPU');
insert into entries values ('A','Bangalore','A1@gmail.com',1,'CPU');
insert into entries values ('A','Bangalore','A2@gmail.com',2,'DESKTOP');
insert into entries values ('B','Bangalore','B@gmail.com',2,'DESKTOP');
insert into entries values ('B','Bangalore','B1@gmail.com',2,'DESKTOP');
insert into entries values ('B','Bangalore','B2@gmail.com',1,'MONITOR');


select * from entries;


with max_floors as (
	select name, floor as max_floor_visited
	from (
	select name, floor, count(1) as floor_count, DENSE_RANK() over (PARTITION by name order by count(1) desc) as rk
	from entries
	group by 1, 2
	) x
	where rk = 1
	)
, resources as (
	select name, GROUP_CONCAT(distinct resources) as total_resources, count(1) as total_visits 
	from entries 
	group by 1
)
select r.*, mf.max_floor_visited 
from resources r
join max_floors mf
on r.name = mf.name
