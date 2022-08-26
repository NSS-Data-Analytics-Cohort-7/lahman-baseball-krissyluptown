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

--select *
--from collegeplaying
--where schoolid = 'vandy'

select p.namefirst, p.namelast, sumsalary.ss
from 
    (Select sum(salary) as ss
    from salaries 
    group by playerid) as sumsalary
join people as p
on p.playerid = sumsalary.playerid
join collegeplaying as cp
on s.playerid = cp.playerid
where cp.schoolid = 'vandy' 





