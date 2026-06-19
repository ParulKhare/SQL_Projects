Olympic History Analysis
Project Overview

This project analyzes historical Olympic athlete and event data using SQL.

The objective was to answer a series of business-style analytical questions using advanced SQL concepts such as:

Joins
Common Table Expressions (CTEs)
Window Functions
Ranking Functions
Aggregations
Group Concatenation
Dataset

Tables Used:

athletes

Contains athlete demographic information.

athlete_events

Contains Olympic participation, events, medals, season, and year information.

Business Questions Solved
Which team has won the maximum gold medals?
For each team, find total silver medals and the year with maximum silver medals.
Which player has won the maximum gold medals among players who have won only gold medals?
Find the player(s) with the highest number of gold medals in each Olympic year.
Find India's first Gold, Silver, and Bronze medals.
Find players who won Gold medals in both Summer and Winter Olympics.
Find players who won Gold, Silver, and Bronze in a single Olympics.
Find players who won Gold medals in three consecutive Summer Olympics in the same event.
SQL Concepts Demonstrated
CTEs
Window Functions (RANK, DENSE_RANK, ROW_NUMBER, LAG, LEAD)
GROUP_CONCAT
Aggregations
Multi-table Joins
Analytical Problem Solving
Files
olympic_history_analysis.sql
