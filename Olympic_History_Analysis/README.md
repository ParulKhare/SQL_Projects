# Olympic History Analysis

## Overview

Analyzed historical Olympic athlete and event data using MySQL to solve analytical and business-focused questions involving medal performance, athlete achievements, country success, and Olympic trends.

## Dataset Overview

This dataset contains Olympic athlete participation records from multiple Olympic Games, including athlete demographics, countries represented, sporting events, medals won, and Olympic seasons.

### athletes

| Column | Description               |
| ------ | ------------------------- |
| id     | Unique athlete identifier |
| name   | Athlete name              |
| sex    | Gender                    |
| height | Athlete height            |
| weight | Athlete weight            |
| team   | Team/Country represented  |

### athlete_events

| Column     | Description                          |
| ---------- | ------------------------------------ |
| athlete_id | Athlete identifier                   |
| games      | Olympic Games edition                |
| year       | Olympic year                         |
| season     | Summer or Winter Olympics            |
| city       | Host city                            |
| sport      | Sport category                       |
| event      | Specific event                       |
| medal      | Medal won (Gold, Silver, Bronze, NA) |

## Questions Solved

* Which team has won the maximum gold medals over the years?
* For each team, find total silver medals and the year in which they won the maximum silver medals.
* Which player has won the maximum gold medals among athletes who have won only gold medals?
* For each Olympic year, identify the player(s) who won the highest number of gold medals.
* Find India's first Gold, Silver, and Bronze medals.
* Find players who won Gold medals in both Summer and Winter Olympics.
* Find players who won Gold, Silver, and Bronze medals in a single Olympic Games.
* Find players who won Gold medals in the same event across three consecutive Summer Olympics since 2000.

## SQL Skills Demonstrated

* CTEs
* Window Functions
* ROW_NUMBER()
* RANK()
* DENSE_RANK()
* LAG()
* LEAD()
* Aggregate Functions
* GROUP_CONCAT()
* Joins
* Subqueries
* Ranking Analysis
* Historical Trend Analysis
* Sports Analytics

## Files

* olympic_history_analysis.sql
