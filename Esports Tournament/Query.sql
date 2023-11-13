
1. What are the names of the players whose salary is greater than 100,000?
select player_name
from players
where salary > 100000;


2. What is the team name of the player with player_id = 3?
select team_name
from teams as t
join players as p
on t.team_id=p.team_id
where player_id = 3;

3. What is the total number of players in each team?
select count(player_id) as Total_Players
from teams as t
join players as p
on t.team_id=p.team_id
group by team_name
order by count(player_id) desc;

4. What is the team name and captain name of the team with team_id = 2?
select team_name,
	   
from teams
where team_id = 2;


5. What are the player names and their roles in the team with team_id = 1?
with
cte as (select *,
      rank() over(order by team_id asc) as rk
from players)
select player_name,
       role
from cte
where rk = 1       
;


6. What are the team names and the number of matches they have won?
select t.team_name,
       count(winner_id) as Matches_Won
from teams as t
join matches as m
on t.team_id = m.winner_id
group by team_name
order by count(m.winner_id) desc;

7. What is the average salary of players in the teams with country 'USA'?
select 
       t.team_name,
       avg(p.salary)
from teams as t
join players as p
on t.team_id=p.team_id
where country= 'USA'
group by t.team_name,t.country
order by avg(p.salary) desc
;


8. Which team won the most matches?
select t.team_name,
       count(winner_id) as Matches_Won
from teams as t
join matches as m
on t.team_id = m.winner_id
group by team_name
order by count(m.winner_id) desc;

9. What are the team names and the number of players in each team whose salary is greater than 100,000?
select t.team_name,
       count(p.player_id) as Number_of_players
from teams as t
join players as p
on t.team_id=p.team_id
where p.salary > 100000
group by team_name
order by count(player_id) desc
;

10. What is the date and the score of the match with match_id = 3?
select *
from teams as t
join matches as m
on t.team_id = m.winner_id
where match_id = 3;
