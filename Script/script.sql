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

Select pos, po,
Case when pos = 'OF' then 'Outfield'
     when pos = 'SS' then 'Infield'
     when pos = '1B' then 'Infield'
     when pos = '2B' then 'Infield'
     when pos = '3B' then 'Infield'
     when pos = 'P' then 'Battery'
     when pos = 'C' then 'Battery'
     Else null end as Position
from fielding




