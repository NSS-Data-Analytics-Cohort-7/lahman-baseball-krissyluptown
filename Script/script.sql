--1.
select yearid from teams
order by yearid;
--1871 to 2016

--2. 
select height, playerid
from people
order by height;
--gaedeed01, 43, 1 game, SLA

select playerid, g_all, teamid
from appearances
where playerid = 'gaedeed01';

--3. 
select cp.playerid, cp.schoolid, p.namefirst, p.namelast
from collegeplaying as cp
inner join people as p
on cp.playerid = p.playerid
where cp.schoolid = 'vandy';
k
--select *
--from collegeplaying
--where schoolid = 'vandy'
select Distinct p.namefirst, p.namelast, cp.schoolid id, sum(s.salary)
from people as p
    join collegeplaying as cp
    on cp.playerid = p.playerid
    join salaries as s
    on cp.playerid = p.playerid
where cp.schoolid = 'vandy'
group by s.playerid





select Distinct p.namefirst, p.namelast, cp.schoolid id, sum(s.salary)
from people as p
    join collegeplaying as cp
    on cp.playerid = p.playerid
    join salaries as s
    on cp.playerid = p.playerid
where cp.schoolid = 'vandy'
group by s.playerid



select * 
from salaries


select p.namefirst, p.namelast, cp.schoolid,
    (Select sum(salary) as s
    from salaries 
    where playerid = playerid) as sumsalary
from people as p
join collegeplaying as cp
on cp.playerid = p.playerid
where cp.schoolid = 'vandy'
     
--join people as p
--on p.playerid = sumsalary.playerid
--join collegeplaying as cp
--on s.playerid = cp.playerid
--where cp.schoolid = 'vandy' 

--winner
With total_salaries as
    (select distinct playerid, sum(salary) as total_salary
    from salaries
    Group by playerid)
Select distinct p.playerid, p.namefirst, p.namelast, total_salary
    from people as p
Left Join collegeplaying as cp
on cp.playerid = p.playerid
Left join total_salaries as ts
on p.playerid = ts.playerid
where cp.schoolid = 'vandy' and total_salary is not null
Order by total_salary DESC;

--David Price, $81,851,296

--4.
Select * 
from fielding

--was trying to be too complicated
with position_po as
(Select pos, po,
Case when pos = 'OF' then 'Outfield'
     when pos = 'SS' then 'Infield'
     when pos = '1B' then 'Infield'
     when pos = '2B' then 'Infield'
     when pos = '3B' then 'Infield'
     when pos = 'P' then 'Battery'
     when pos = 'C' then 'Battery'
     Else null end as Position
from fielding)
Select sum(position_po.po), position
from fielding as f
Join position_po
on position_po.pos = position_po.pos
Group by position_po.po

--winner
Select pos, sum(po) as pos_putouts,
Case when pos = 'OF' then 'Outfield'
     when pos = 'SS' then 'Infield'
     when pos = '1B' then 'Infield'
     when pos = '2B' then 'Infield'
     when pos = '3B' then 'Infield'
     when pos = 'P' then 'Battery'
     when pos = 'C' then 'Battery'
     Else null end as Position
from fielding as f
where f.yearid = '2016'
group by f.pos;

/*Find the average number of strikeouts per game by decade since 1920. 
Round the numbers you report to 2 decimal places. Do the same for home 
runs per game. Do you see any trends?*/

select * 
from pitching
--answer below
select Round(avg(so),2) as avgso, p.yearid/10*10 as decade
from pitching as p
group by p.yearid/10*10
Order by decade; 

/* 6. Find the player who had the most success stealing bases in 2016, 
where success is measured as the percentage of stolen base attempts
which are successful. (A stolen base attempt results either in a 
stolen base or being caught stealing.) Consider only players who 
attempted at least 20 stolen bases.*/

Select * 
from batting

Select b.playerid, cs as caught_stealing, sb as stolen_bases, namefirst, namelast,
((sb)/(cs +sb):: NUMERIC)*100 as attempts
from batting as b
Left join people as p
on b.playerid = p.playerid
where yearid = '2016' and (cs +sb) > 19
order by attempts desc

--ANSWER: Chris Owings, 91.3%

/* 7. From 1970 – 2016, what is the largest number of wins for a team 
that did not win the world series? What is the smallest number of wins 
for a team that did win the world series? Doing this will probably result 
in an unusually small number of wins for a world series champion – 
determine why this is the case. Then redo your query, excluding the 
problem year. How often from 1970 – 2016 was it the case that a team with 
the most wins also won the world series? What percentage of the time?*/

/*Using the attendance figures from the homegames table, find the teams 
and parks which had the top 5 average attendance per game in 2016 
(where average attendance is defined as total attendance divided by 
number of games). Only consider parks where there were at least 10 games 
played. Report the park name, team name, and average attendance. Repeat 
for the lowest 5 average attendance.*/

select *
from homegames;

select distinct park, team, (attendance/games) as avgattendance
from homegames
where year = '2016'
order by avgattendance DESC
limit 5

select distinct h.park, h.team, h.attendance, h.games, h.year, p.park_name
from homegames as h
Left Join parks as p
on h.park = p.park
where year = '2016'
order by attendance DESC
limit 5

--select team, games, year
--from homegames 
--order by year desc

select distinct h.park, h.team, (h.attendance/h.games) as avgattendance,
h.year, p.park_name
from homegames as h
Left join parks as p
on h.park = p.park
where year = '2016'
order by avgattendance DESC
limit 5
/* 1. Dodger Stadium, 45719, Los Angeles Dodgers
   2. Busch Stadium III, 42524, St. Louis Cardinals
   3. Rogers Center, 41877, Toronto Blue Jays
   4. AT&T Park, 41546, SanFransisco Giants
   5. Wrigley Field, 39906, Chicago Cubs*/

select distinct h.park, h.team, (h.attendance/h.games) as avgattendance,
h.year, p.park_name
from homegames as h
Left join parks as p
on h.park = p.park
where year = '2016'
order by avgattendance 
limit 5
/* 1. Fort Bragg Field, 12582, Altanta Braves
   2. Tropicana Field, 15878, Tampa Bay Rays
   3. Oakland-Alameda County Coliseum, 18784, Oakland Athletics
   4. Progressive Field, 19650, Cleveland Indians
   5. Marlins Park, 21405, Miami Marlins */
   
/* 9. Which managers have won the TSN Manager of the Year award in both 
the National League (NL) and the American League (AL)? Give their full 
name and the teams that they were managing when they won the award.*/

Select * 
from managers

Select *
from awardsmanagers

