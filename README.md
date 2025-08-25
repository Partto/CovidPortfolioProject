# COVID-19 Data Exploration (SQL Project)
## Project Objective
The objective of this project is to explore and analyze COVID-19 global data using SQL.
The analysis highlights patterns in cases, deaths, and vaccinations to:
•	Understand infection and mortality trends
•	Compare COVID-19 impact across countries and continents
•	Track vaccination progress over time
•	Prepare cleaned, structured outputs for visualization and reporting

## Dataset
This project uses two datasets:
•	CovidDeaths – case counts, deaths, and population data
•	CovidVaccinations – vaccination rollout data
👉 [COVID-19 Dataset – Download Link] (add link if available)

## Questions (KPIs)
The queries were designed to answer the following key questions:
•	What is the likelihood of dying if infected with COVID-19?
•	What percentage of each country’s population has been infected?
•	Which countries have the highest infection rate compared to population?
•	Which countries and continents have the highest death counts?
•	What are the global totals for cases, deaths, and death percentage?
•	How does vaccination progress compare against total population?

## Process
•	Data Inspection: Queried raw COVID-19 data to check completeness and structure
•	Case Analysis: Compared total cases vs deaths to calculate death percentages
•	Population Analysis: Measured infection rates relative to population size
•	Aggregations: Grouped data by country and continent for comparisons
•	Global Metrics: Calculated worldwide totals for cases, deaths, and mortality rate
•	Vaccination Tracking:
o	Used joins between CovidDeaths and CovidVaccinations
o	Created rolling vaccination totals with SUM() OVER()
o	Implemented CTEs and Temp Tables to calculate percent vaccinated per population
•	Data Preparation: Built a VIEW (PercentPopulationVaccinated) to store vaccination data for dashboards

## Project Insights
•	The likelihood of dying from COVID-19 varies greatly by country and time period
•	Certain countries had much higher infection rates relative to population
•	The United States, India, and Brazil recorded the highest death counts globally
•	At the continental level, Europe and North America show the highest cumulative death counts
•	Vaccination progress can be tracked effectively using rolling totals, with clear differences across regions
•	A significant gap exists between infection rates and vaccination coverage in some countries

## Final Conclusion
This project demonstrates how SQL can be used not just for cleaning, but also for exploratory analysis of large-scale health data.
It provides:
•	Clear insights into infection, death, and vaccination trends
•	Aggregated metrics for country, continent, and global levels
•	A reusable VIEW to connect with visualization tools (Power BI, Tableau) for deeper insights

## Tools & Technologies
•	SQL Server – Data exploration and analysis
•	T-SQL Functions – SUM() OVER(), CAST, NULLIF
•	Common Table Expressions (CTEs) – For population vs vaccination analysis
•	Temp Tables – To store intermediate results
•	Views – For persistent storage and visualization readiness

## Author
Patrick Ugwu

