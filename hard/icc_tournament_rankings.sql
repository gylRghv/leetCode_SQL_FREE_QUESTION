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

----BETTER APPROACH-----

with all_matches as (
	SELECT team_1 as team_name, case when team_1 = winner then 1 else 0 end as winner_flag
	from icc_world_cup
	UNION all
	select team_2 as team_name, case when team_2 = winner then 1 else 0 end as winner_flag
	from icc_world_cup
)
select team_name
, count(1) as total_games
, sum(winner_flag) as no_of_wins 
, count(1) - sum(winner_flag) as no_of_losses
from all_matches
group by 1
order by no_of_wins desc 
