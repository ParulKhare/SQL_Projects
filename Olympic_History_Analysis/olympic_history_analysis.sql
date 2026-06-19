/*  1) which team has won the maximum gold medals over the years.  */

select team, count(distinct event) as total_count 
from testdb1.athletes a 
inner join testdb1.athlete_events ae
on a.id = ae.athlete_id
where medal = 'Gold'
group by team
order by total_count desc
limit 1 ;

/*  2) for each team print total silver medals and year in which they won maximum silver medal..output 3 columns
team,total_silver_medals, year_of_max_silver  */

with cte as (
select team, year, count(distinct event) as total_count
from testdb1.athletes a  
inner join testdb1.athlete_events ae
on a.id = ae.athlete_id
where medal = 'Silver'
group by team, year
)

select team, total_silver_medals, year as year_of_max_silver
from (
select * 
, sum(total_count) over(partition by team) as total_silver_medals
, row_number() over(partition by team order by total_count desc) as rwn
from cte
) sub
where rwn = 1
order by total_silver_medals desc ;

/*  3) which player has won maximum gold medals amongst the players 
which have won only gold medal (never won silver or bronze) over the years  */

with cte as (
select *
from testdb1.athlete_events
where athlete_id not in (
select id
from testdb1.athletes a 
inner join testdb1.athlete_events ae
on a.id = ae.athlete_id
where medal <> 'NA'
group by id
having count(distinct medal) > 1
) and medal = 'Gold'
) 

select a.name, count(*) as total_gold_medals
from cte 
inner join testdb1.athletes a
on cte.athlete_id = a.id
group by cte.athlete_id, a.name
order by count(*) desc
limit 1 ;

/*  4) in each year which player has won maximum gold medal . Write a query to print year,player name 
and no of golds won in that year . In case of a tie print comma separated player names. */

with cte as (
select athlete_id, name, year, count(*) as total_count
from testdb1.athletes a 
inner join testdb1.athlete_events ae
on a.id = ae.athlete_id
where medal = 'Gold'
group by athlete_id, name, year
),

cte1 as (
select year, name, total_count as no_of_gold
from (
select * 
, dense_rank() over(partition by year order by total_count desc) as rnk
from cte
) sub 
where rnk = 1
)

select year, no_of_gold, group_concat(name order by name separator ', ') as players 
from cte1
group by year, no_of_gold 
order by year  ;

/*  5) in which event and year India has won its first gold medal,first silver medal and first bronze medal
print 3 columns medal,year,sport  */

select distinct medal, year, event
from (
select *
, rank() over(partition by medal order by year) as rwn
from testdb1.athletes a 
inner join testdb1.athlete_events ae
on a.id = ae.athlete_id
where team = 'India' and medal <> 'NA'
) sub
where rwn = 1 ;

/*  6) find players who won gold medal in summer and winter olympics both.  */

select name
from testdb1.athletes a 
inner join testdb1.athlete_events ae
on a.id = ae.athlete_id
where medal = 'Gold'
and season in ('Summer', 'Winter')
group by name
having count(distinct season) = 2 ;

/*  7) find players who won gold, silver and bronze medal in a single olympics. print player name along with year.  */

select year, name
from testdb1.athletes a 
inner join testdb1.athlete_events ae
on a.id = ae.athlete_id
where medal <> 'NA'
group by year, name
having count(distinct medal) = 3 ;

/*  8) find players who have won gold medals in consecutive 3 summer olympics in the same event . 
Consider only olympics 2000 onwards. 
Assume summer olympics happens every 4 year starting 2000. print player name and event name.  */

with cte as (
select name, year, event
from testdb1.athletes a 
inner join testdb1.athlete_events ae
on a.id = ae.athlete_id
where year >= '2000' and season = 'Summer'
and medal = 'Gold'
group by name, year, event
)

select *
from (
select * 
, lag(year, 1) over(partition by name, event order by year) as prev_year
, lead(year, 1) over(partition by name, event order by year) as next_year
from cte
) sub
where year = prev_year+4 and year = next_year-4 ;
