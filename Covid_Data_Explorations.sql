use portfolioprojects;

Select *
From portfolioprojects..CovidVaccinations$
where continent is not null
order by 1,2

Select *
From portfolioprojects..Covid_Deaths$
where continent is not null order by 1,2

select location,date,total_cases,new_cases,total_deaths,population
from portfolioprojects..Covid_Deaths$
where continent is not null
order by 1,2

--total deaths vs total cases
--percentage likelihood of dying of covid effected population
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as percentageofDeaths
from portfolioprojects..Covid_Deaths$
where location='India'
order by 1,2


select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as percentageofDeaths
from portfolioprojects..Covid_Deaths$
where location like'%states%'
order by 1,2


--total caeses vs population
--show that percentage of population get covid
select location,date,total_cases,population,(total_cases/population)*100 as percentageOfCovudCases
from portfolioprojects..Covid_Deaths$
where location='India'
order by 1,2

select location,date,total_cases,population,total_deaths,(total_deaths/population)*100 as percentageofDeaths
from portfolioprojects..Covid_Deaths$
where location like'%states%'
order by 1,2







---continent with highest death count per population

select continent,MAX(cast(total_deaths as int)) as TotalDeathcount
from portfolioprojects..Covid_Deaths$
--where location='India'
where continent is not null
Group by continent
order by TotalDeathcount desc





-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From portfolioprojects..Covid_Deaths$ dea
Join portfolioprojects..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

select location from portfolioprojects..Covid_Deaths$
where location='India'

-- 1GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From portfolioprojects..Covid_Deaths$
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2


--2Confirmed 
---region with highest death count 

select location,SUM(cast(new_deaths as int)) as TotalDeathcount
from portfolioprojects..Covid_Deaths$
--where location='India'
where continent is  null
and location not in('World','European Union','International','Upper middle income','Lower middle income','Low income','High income')
Group by location
order by TotalDeathcount desc


-- 3Confirmed 
---countries with highest infection rate compared to population
select location,population,MAX(total_cases) as highestInfectedcount,MAX((total_cases/population))*100 as percentpopulationInfected
from portfolioprojects..Covid_Deaths$
--where location='India'
Group by location,population
order by percentpopulationInfected desc


-- 4Confirmed 
---countries with highest infection rate compared to population
select location,population,date,MAX(total_cases) as highestInfectedcount,MAX((total_cases/population))*100 as percentpopulationInfected
from portfolioprojects..Covid_Deaths$
--where location='India'
Group by location,population,date
order by percentpopulationInfected desc


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From portfolioprojects..Covid_Deaths$ dea
Join portfolioprojects..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null and vac.location='india'
order by 2,3


select continent,location,SUM(cast(new_vaccinations as bigint)) as Total_vaccinationByCountry from  portfolioprojects..CovidVaccinations$
where continent is not null
group by continent,location
order by Total_vaccinationByCountry desc


select continent,location,SUM(cast(new_vaccinations as bigint)) as Total_vaccinationByContinent from  portfolioprojects..CovidVaccinations$
where continent is not null
group by continent,location 


select dea.continent,sum(cast(dea.new_cases as int)) as totla_cases,sum(cast(dea.new_deaths as int)) as total_deaths,SUM(cast(vac.total_vaccinations as bigint)) as Total_vaccinationByContinent 
from  portfolioprojects..CovidVaccinations$ as vac
join portfolioprojects..Covid_Deaths$ as dea
on dea.location =vac.location
and dea.date=vac.date
where dea.continent is not null 
group by dea.continent
order by Total_vaccinationByContinent desc 





--continent	totla_cases	total_deaths	Total_vaccinationByContinent
--Asia	38700140	522534	15741783006
--North America	37663761	841264	12316638521
--Europe	45324331	1046090	8709922651
--South America	24925224	773485	2506014111
--Africa	4557672	121853	498735348
--Oceania	43591	1049	55059151

-- Confirmed  5
--Toal cases,Total deaths by Each Country
select location,SUM(cast(new_deaths as int)) as TotalDeathcount,sum(new_cases) as total_cases
from portfolioprojects..Covid_Deaths$

where continent is not null
and location not in('World','European Union','International','Upper middle income','Lower middle income','Low income','High income')
Group by location
order by TotalDeathcount desc


--Confirmed 6
--Toal cases,Total deaths by Each Country
select location,CAST(date AS date) as Date,SUM(cast(new_deaths as int)) as TotalDeathcount,sum(new_cases) as total_cases
from portfolioprojects..Covid_Deaths$
where continent is not null
and location not in('World','European Union','International','Upper middle income','Lower middle income','Low income','High income')
Group by location,date
order by date




--7 Confirmed
-- Toal cases,Total deaths by united states
select location,CAST(date AS date) as Date,SUM(cast(new_deaths as int)) as TotalDeathcount,sum(new_cases) as total_cases
from portfolioprojects..Covid_Deaths$

where continent is not null
and location not in('World','European Union','International','Upper middle income','Lower middle income','Low income','High income')
and location='United states'
Group by location,date
order by 1,2
