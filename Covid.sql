select *
from covid

select location ,date ,total_cases ,new_cases ,total_deaths ,population
from covid
order by 1,2

select location ,date ,total_cases ,new_cases ,total_deaths , (total_deaths/total_cases)*100 as deathpercentage
from covid
order by 1,2


select location ,date ,total_cases ,new_cases ,population , (total_cases/population)*100 as deathpercentage
from covid
order by 1,2


select location ,max(total_cases)  ,population , max((total_cases/population))*100 as deathpercentage
from covid
where continent is not null
group by population ,location
order by deathpercentage desc


select location ,max(cast(total_deaths as int)) as totaldeathcount
from covid
where continent is not null
group by population ,location
order by totaldeathcount desc

select date ,sum(new_cases) ,sum(cast(new_deaths as int)) , sum(cast(new_deaths as int))/sum(new_cases)*100
from covid
where continent is not null
group by date
order by 1,2

select dea.continent ,dea.location ,dea.date ,dea.population ,vac.new_vaccinations
from covid dea
join CovidVaccinations vac 
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3


select dea.continent ,dea.location ,dea.date ,dea.population ,vac.new_vaccinations
,sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date)
from covid dea
join CovidVaccinations vac 
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3




Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From covid
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From covid
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc


Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDeaths
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc
