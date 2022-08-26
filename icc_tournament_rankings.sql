with cte as (
	select distinct team 
	from (
	select team_1 as team
	from icc_world_cup a1
	union 
	select team_2 as team
	from icc_world_cup a2
	) teams
)
, all_matches as (
	select t.*, icc.* 
	from icc_world_cup icc
	join cte t
	on t.team = icc.team_1 
	union 
	select t.*, icc.* 
	from icc_world_cup icc
	join cte t
	on t.team = icc.team_2
)
select team, count(team)
, sum(case when Winner = team then 1 else 0 end) as no_of_wins 
, sum(case when Winner = team then 0 else 1 end) as no_of_losses
from all_matches
group by 1
