-- create table players
-- (player_id int,
-- group_id int);

-- insert into players values (15,1);
-- insert into players values (25,1);
-- insert into players values (30,1);
-- insert into players values (45,1);
-- insert into players values (10,2);
-- insert into players values (35,2);
-- insert into players values (50,2);
-- insert into players values (20,3);
-- insert into players values (40,3);

-- create table matches
-- (
-- match_id int,
-- first_player int,
-- second_player int,
-- first_score int,
-- second_score int
-- );

-- insert into matches values (1,15,45,3,0);
-- insert into matches values (2,30,25,1,2);
-- insert into matches values (3,30,15,2,0);
-- insert into matches values (4,40,20,5,2);
-- insert into matches values (5,35,50,1,1);

select * from players;
select * from matches;

-- write a query to find the winner in each group.
-- winner -> player who scored the maximum total points within the group within the group. in the case of tie,
-- the lowest player_id wins.

with individual_scores as (
	select first_player as player, first_score as score
	from matches 
	union all
	select second_player as player, second_score as score
	from matches 
)
, total_scores as (
	SELECT p.group_id, s.player, sum(s.score) as total_score 
	from individual_scores s
	inner join players p
	on s.player = p.player_id
	group by 1,2
)
, max_scores as (
	SELECT group_id
	, player as winner
	, total_score
	, max(total_score) over (PARTITION by group_id) as max_score
	, DENSE_RANK() over (PARTITION by group_id order by total_score desc, player) as pos
	from total_scores
)
select group_id, winner, total_score
from max_scores
where max_score = total_score and pos = 1;



