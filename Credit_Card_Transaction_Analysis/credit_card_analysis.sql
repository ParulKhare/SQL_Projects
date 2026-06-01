<h1>/* 1- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends */ </h1>

with city_amount as (
select city, sum(amount) as total_spent_city 
from testdb1.credit_card_transcations
group by 1
),

total_amount as (
select sum(amount) as total_amount
from testdb1.credit_card_transcations
)

select city, total_spent_city as total_spend, round((total_spent_city*1.00/total_amount) * 100, 2) as percent_contribution
from city_amount
join total_amount
on 1=1
order by total_spent_city desc
limit 5 ;

/* 2- write a query to print highest spend month and amount spent in that month for each card type */

with total_spent as (
select card_type, left(str_to_date(transaction_date, '%Y-%m-%d'), 7) as year_mon, sum(amount) as total_spent
from testdb1.credit_card_transcations
group by 1, 2
),

total_spent_rank as (
select card_type, year_mon, total_spent
, row_number() over(partition by card_type order by total_spent desc) as rwn
from total_spent
)

select card_type, year_mon, total_spent 
from total_spent_rank
where rwn = 1 ;

/* 3- write a query to print the transaction details(all columns from the table) for each card type when
it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type) */

with total_spend as (
select *
, sum(amount) over(partition by card_type order by transaction_date, transaction_id) as total_spend
from testdb1.credit_card_transcations
),

amount_1000000 as (
select * from total_spend
where total_spend >= 1000000
order by transaction_id
)

select transaction_id, city, transaction_date, card_type, exp_type, gender, amount, total_spend as cumulative_amount
from (
select *
, row_number() over(partition by card_type order by total_spend) as rwn
from amount_1000000
) sub
where rwn = 1 ;

/* 4- write a query to find city which had lowest percentage spend for gold card type  */

with cte1 as (
select city, sum(amount) as gold_amount
from testdb1.credit_card_transcations
where card_type = 'Gold'
group by city
),

cte2 as (
select city, sum(amount) as total_amount
from testdb1.credit_card_transcations
group by city
)

select cte1.city, round(gold_amount * 1.0 / total_amount, 4) as gold_ratio
from cte1
inner join cte2
on cte1.city = cte2.city
order by gold_ratio
limit 1 ;

/* 5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type 
(example format : Delhi , bills, Fuel) */

with city_exp_amount as (
select city, exp_type, sum(amount) as total_amount
from testdb1.credit_card_transcations
group by city, exp_type
)

select city, max(case when highest = 1 then exp_type end) as highest_expense_type
, max(case when lowest = 1 then exp_type end) as lowest_expense_type
from 
(
select * 
, row_number() over(partition by city order by total_amount desc) as highest
, row_number() over(partition by city order by total_amount) as lowest
from city_exp_amount
order by city
) sub
where highest = 1 or lowest = 1
group by city 
order by city ;

/* 6- write a query to find percentage contribution of spends by females for each expense type  */

with female_exp_amount as (
select exp_type, sum(amount) as amount
from testdb1.credit_card_transcations
where gender = 'F'
group by exp_type
),

total_amount as (
select exp_type, sum(amount) as total
from testdb1.credit_card_transcations
group by exp_type
)

select f.exp_type, round(amount/total, 4) as percent_contribution
from female_exp_amount f
join total_amount t
on f.exp_type = t.exp_type
order by percent_contribution desc ;

/* 7- which card and expense type combination saw highest month over month growth in Jan-2014  */

with card_exp_amount as (
select card_type, exp_type
, date_format(str_to_date(transaction_date, '%Y-%m-%d'), '%Y-%m') as transaction_year_month
, sum(amount) as amount
from testdb1.credit_card_transcations
group by 1, 2, 3
),

month_growth as (
select card_type, exp_type, transaction_year_month, amount, lag_amount
, (amount-lag_amount) as mom_growth
from (
select * 
, lag(amount) over(partition by card_type, exp_type order by transaction_year_month) as lag_amount
from card_exp_amount
) sub
where transaction_year_month = '2014-01'
)

select * from month_growth
order by mom_growth desc
limit 1 ;

/* 8- during weekends which city has highest total spend to total no of transcations ratio  */

select city, round(sum(amount)/count(*), 2) as spend_transaction_ratio
from testdb1.credit_card_transcations
where weekday(transaction_date) in (5, 6)
group by city
order by spend_transaction_ratio desc
limit 1 ;

/* 9 - which city took least number of days to reach its 500th transaction after the first transaction in that city  */

with min_transaction as (
select city, min(transaction_date) as min_transaction_date
from testdb1.credit_card_transcations
group by city
),

transaction_500 as (
select * 
, row_number() over(partition by city order by transaction_date, transaction_id) rwn
from testdb1.credit_card_transcations
)

select t.city, timestampdiff(day, min_transaction_date, transaction_date) as date_diff
from transaction_500 t
inner join min_transaction m
on t.city = m.city
where rwn = 500
order by date_diff
limit 1 ;
