select *
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4

--select *
--from PortfolioProject..CovidVaccinations
--where continent is not null
--order by 3,4


select Continent, location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2

--Looking at Total Cases vs Total Deaths
--shows the likelyhood of dying if you contact Covid in my country Nigeria

select Continent, location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%Nigeria%' and continent is not null
order by 1,2

--looking at the Total Cases vs the Population 
--shows the percentage of the population with Covid

select Continent, location, date, total_cases, population, (total_cases/population)*100 as InfectedPopulation
from PortfolioProject..CovidDeaths
where location like '%Nigeria%' and continent is not null
order by 1,2

--Looking at Countries with Highest Infection Rate Compared to Population

select Continent, location, population, max(total_cases) as HighestInfectionCases, max((total_cases/population))*100 as InfectedPopulationpercentage
from PortfolioProject..CovidDeaths
where continent is not null
Group by Location, Population, Continent
order by InfectedPopulationpercentage desc

--showing countries with the highest deathcount per population

select location, continent, max(cast(total_deaths as int)) as Totaldeathcount
from PortfolioProject..CovidDeaths
where continent is not null
Group by location, continent
order by Totaldeathcount desc


--BREAKING THINGS DOWN BY CONTINENT

--showing continents with the Highest death count

select location, max(cast(total_deaths as int)) as Totaldeathcount
from PortfolioProject..CovidDeaths
where continent is null
Group by location
order by Totaldeathcount desc


--GLOBAL NUMBERS PERDAY SINCE COVID

select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as deathpercentage
from PortfolioProject..CovidDeaths
--where location like '%Nigeria%' 
where continent is not null
group by date
order by 1, 2


--OverAll GLOBAL NUMBERS

select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as deathpercentage
from PortfolioProject..CovidDeaths
--where location like '%Nigeria%' 
where continent is not null
--group by date
order by 1,2


--Looking at total population vs Vaccination
select dea.Continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int,vac.new_vaccinations)) OVER (partition by dea.location order by dea.location, 
dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from portfolioProject..covidDeaths Dea
join portfolioProject..covidVaccinations Vac
On Dea.location =  Vac. location and Dea.Date = Vac.Date
where dea.continent is not null
order by 2,3


--USE CTE

with popvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.Continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int,vac.new_vaccinations)) OVER (partition by dea.location order by dea.location, 
dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from portfolioProject..covidDeaths Dea
join portfolioProject..covidVaccinations Vac
On Dea.location =  Vac. location and Dea.Date = Vac.Date
where dea.continent is not null
--order by 2,3
)
select*, (RollingPeopleVaccinated/population)*100
from popvsVac

--TEMP TABLE

drop table if exists #percentofPopulationVaccinated

Create table #percentofPopulationVaccinated
(
continent nvarchar(255), 
location nvarchar(255), 
date datetime,
population numeric, 
new_vaccinations numeric, 
RollingPeopleVaccinated numeric
)

insert into #percentofPopulationVaccinated
select dea.Continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int,vac.new_vaccinations)) OVER (partition by dea.location order by dea.location, 
dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from portfolioProject..covidDeaths Dea
join portfolioProject..covidVaccinations Vac
On Dea.location =  Vac. location and Dea.Date = Vac.Date
where dea.continent is not null
--order by 2,3
select *, (RollingPeopleVaccinated/population)*100
from #percentofPopulationVaccinated


--CREATING VIEW TO STORE DATA FOR LATER VISUALIZATIONS IN TABLEAU (create more later)

create view percentofPopulationVaccinated as
select dea.Continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int,vac.new_vaccinations)) OVER (partition by dea.location order by dea.location, 
dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from portfolioProject..covidDeaths Dea
join portfolioProject..covidVaccinations Vac
On Dea.location =  Vac. location and Dea.Date = Vac.Date
where dea.continent is not null
--order by 2,3

select *
from percentofPopulationVaccinated


--Overall Global numbers view

create view OverallGlobalNumbers as
select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as deathpercentage
from PortfolioProject..CovidDeaths
--where location like '%Nigeria%' 
where continent is not null
--group by date
--order by 1,2


select *
from OverallGlobalNumbers

--IMPORTANT NOTE

--Although a few queries were done to create views, the views were left unused. 
--parts of this query used for TABLEAU Visualisation were copied as tables into seperate excel files and each were imported into TABLEAU PUBLIC DESKTOP for Visualisation.
