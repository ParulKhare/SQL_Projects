Olympic History Analysis
Overview

Analyzed historical Olympic athlete and event data using MySQL to solve a variety of analytical and business-style questions involving medal performance, athlete achievements, country success, and Olympic trends.

Dataset Overview

This dataset contains Olympic athlete participation records from multiple Olympic Games, including athlete demographics, countries/teams represented, sporting events, medals won, and Olympic seasons.

Tables
athletes

Contains athlete information.

Column	Description
id	Unique athlete identifier
name	Athlete name
sex	Gender
height	Athlete height
weight	Athlete weight
team	Team/Country represented
athlete_events

Contains Olympic participation and medal records.

Column	Description
athlete_id	Athlete identifier
games	Olympic Games edition
year	Olympic year
season	Summer or Winter Olympics
city	Host city
sport	Sport category
event	Specific event
medal	Medal won (Gold, Silver, Bronze, NA)
Questions Solved
Which team has won the maximum gold medals over the years?
For each team, find total silver medals and the year in which they won the maximum silver medals.
Which player has won the maximum gold medals among athletes who have won only gold medals and never silver or bronze?
For each Olympic year, identify the player(s) who won the highest number of gold medals.
Find India's first Gold, Silver, and Bronze medals along with the corresponding year and event.
Find players who have won Gold medals in both Summer and Winter Olympics.
Find players who won Gold, Silver, and Bronze medals in the same Olympic Games.
Find players who won Gold medals in the same event across three consecutive Summer Olympics since 2000.
SQL Skills Demonstrated
Common Table Expressions (CTEs)
Window Functions
ROW_NUMBER()
RANK()
DENSE_RANK()
LAG()
LEAD()
Aggregate Functions
GROUP_CONCAT()
Multi-Table Joins
Subqueries
Conditional Filtering
Ranking Analysis
Sports Data Analytics
Historical Trend Analysis
Medal Performance Analysis
Key Insights
Identified the most successful teams and athletes in Olympic history.
Analyzed medal-winning patterns across countries and Olympic years.
Tracked athlete dominance across multiple Olympic Games.
Examined historical performance trends and milestone achievements.
Leveraged advanced SQL techniques to solve complex analytical problems.
