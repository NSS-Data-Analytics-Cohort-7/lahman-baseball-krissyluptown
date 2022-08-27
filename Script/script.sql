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

SELECT customer.customer_num,
	(SELECT SUM(ship_charge) 
	 	FROM orders
	 	WHERE customer.customer_num = orders.customer_num) 
			AS total_ship_chg
	FROM customer 





