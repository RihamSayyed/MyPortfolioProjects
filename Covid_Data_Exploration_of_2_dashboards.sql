--COVID_Dashborad 1


-- 1GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From portfolioprojects..Covid_Deaths$
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2



-- 2Confirmed 
---countries with highest infection rate compared to population
select location,population,MAX(total_cases) as highestInfectedcount,MAX((total_cases/population))*100 as percentpopulationInfected
from portfolioprojects..Covid_Deaths$
--where location='India'
Group by location,population
order by percentpopulationInfected desc




-- 3Confirmed 
---countries with highest infection rate compared to population
select location,population,date,MAX(total_cases) as highestInfectedcount,MAX((total_cases/population))*100 as percentpopulationInfected
from portfolioprojects..Covid_Deaths$
--where location='India'
Group by location,population,date
order by percentpopulationInfected desc



-------------------------------------------------------------------------------------------------------------------------

--COVID Dashboard 2

--1
--Toal cases,Total deaths by Each Country
select location,SUM(cast(new_deaths as int)) as TotalDeathcount,sum(new_cases) as total_cases
from portfolioprojects..Covid_Deaths$
where continent is not null
--and location not in('World','European Union','International','Upper middle income','Lower middle income','Low income','High income')
Group by location
order by TotalDeathcount desc




--  2
--Toal cases,Total deaths by date in Country
select location,CAST(date AS date) as Date,SUM(cast(new_deaths as int)) as TotalDeathcount,sum(new_cases) as total_cases
from portfolioprojects..Covid_Deaths$
where continent is not null
--and location not in('World','European Union','International','Upper middle income','Lower middle income','Low income','High income')
and location='United states'
Group by location,date
order by 1,2

--3 deathcount by continent
select continent,SUM(cast(new_deaths as int)) as TotalDeathcount
from portfolioprojects..Covid_Deaths$
--where location='India'
where continent is   not null
--and location not in('World','European Union','International','Upper middle income','Lower middle income','Low income','High income')
Group by continent
order by TotalDeathcount desc