select *
from PortfolioProject..DatasetAfricaMalaria


--Using CTEs to DUPLICATE DATA from the data
WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY country_name,
				 [Incidence of malaria (per 1,000 population at risk)],
				 [Malaria cases reported],
				 [People using at least basic drinking water services (% of popula]
				 
				 order BY
					Year
					) row_num

From PortfolioProject..DatasetAfricaMalaria
)
delete 
From RowNumCTE
Where row_num > 1
--Order by Year

--

select country_name, year,[country code], [Incidence of malaria (per 1,000 population at risk)],
[Malaria cases reported], [Rural population (% of total population)],[urban population (% of total population)]

from PortfolioProject..DatasetAfricaMalaria


--Total malaria cases
--for each country for map
select country_name, sum([Malaria cases reported]) as total_malaria_cases, longitude, latitude
from PortfolioProject..DatasetAfricaMalaria
group by country_name,  longitude, latitude
--order by 1 desc

--malaria cases per country(total)
select country_name, sum([Malaria cases reported]) as total_malaria_cases
from PortfolioProject..DatasetAfricaMalaria
where [Malaria cases reported] is not null
group by country_name
order by 2 desc


--overall TOTAL cases in africa
select sum([Malaria cases reported]) as total_malaria_cases
from PortfolioProject..DatasetAfricaMalaria
where [Malaria cases reported] is not null



--Highest Rural population and year
select country_name, year, [Rural population (% of total population)]
from PortfolioProject..DatasetAfricaMalaria
order by 3 desc

--Highest urban population and year year
select country_name, year, [Urban population (% of total population)]
from PortfolioProject..DatasetAfricaMalaria
order by 3 desc

--Highest incidence in a year
select country_name, year,[country code], [Incidence of malaria (per 1,000 population at risk)]
from PortfolioProject..DatasetAfricaMalaria
order by 3 desc

--Incidebce per year only for 1000 population--USED
select year, avg([Incidence of malaria (per 1,000 population at risk)]) as Pop_at_risk_per_1000
from PortfolioProject..DatasetAfricaMalaria
group by year 

--Per country--USED
select country_name, avg([Incidence of malaria (per 1,000 population at risk)]) as Pop_at_risk_per_1000, longitude, latitude
from PortfolioProject..DatasetAfricaMalaria
group by country_name, longitude, latitude

-- basic water services
select distinct(country_name),[People using at least basic drinking water services (% of popula], [People using at least basic sanitation services (% of population]
from PortfolioProject..DatasetAfricaMalaria

--for all years basic water services
select year, avg([People using at least basic drinking water services (% of popula]) as acces_to_basic
from PortfolioProject..DatasetAfricaMalaria
group by year 

--Access to basic drinking water services USED

select year, avg([People using at least basic drinking water services (% of popula]) as acces_to_basic
from PortfolioProject..DatasetAfricaMalaria
group by year 

--Incidence vs access to water per country USED
select country_name, avg([People using at least basic drinking water services (% of popula]) as pop_with_acess_to_basic_water
, avg([Incidence of malaria (per 1,000 population at risk)]) as Incidence_of_malari_per_1000
from PortfolioProject..DatasetAfricaMalaria
group by country_name


--INCIDENCE VS SANITATION USED
select country_name, avg([People using at least basic sanitation services (% of population]) as people_with_basic_sanitation_services
, avg([Incidence of malaria (per 1,000 population at risk)]) as Incidence_of_malari_per_1000
from PortfolioProject..DatasetAfricaMalaria
group by country_name

--ACCESS TO basic sanitaion services USED
select year, avg([People using at least basic sanitation services (% of population]) as acces_to_basic_sani
from PortfolioProject..DatasetAfricaMalaria
group by year 


--Highest no of basic drinking water services
select year, country_name,[People using at least basic drinking water services (% of popula]
from PortfolioProject..DatasetAfricaMalaria
order by 3 desc

--Highest no of people using at least basic sanitaion services
select year, country_name, [People using at least basic sanitation services (% of population]
from PortfolioProject..DatasetAfricaMalaria
order by 3 desc

--Water service vs Cases
select year, country_name, [People using at least basic sanitation services (% of population], [People using at least basic drinking water services (% of popula], [Malaria cases reported]
from PortfolioProject..DatasetAfricaMalaria
where country_name in ('Nigeria')
order by 3 desc







--FOR MY DASHBOARD THESE ARE THE QUERIES I MADE USE OF

select *
from PortfolioProject..DatasetAfricaMalaria


--Using CTEs to DUPLICATE DATA from the data
WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY country_name,
				 [Incidence of malaria (per 1,000 population at risk)],
				 [Malaria cases reported],
				 [People using at least basic drinking water services (% of popula]
				 
				 order BY
					Year
					) row_num

From PortfolioProject..DatasetAfricaMalaria
)
delete 
From RowNumCTE
Where row_num > 1
--Order by Year

--overall TOTAL cases in africa
select sum([Malaria cases reported]) as total_malaria_cases
from PortfolioProject..DatasetAfricaMalaria
where [Malaria cases reported] is not null

--Incidence per year only for 1000 population
select year, avg([Incidence of malaria (per 1,000 population at risk)]) as Pop_at_risk_per_1000
from PortfolioProject..DatasetAfricaMalaria
group by year 

--MALARIA CASES Per country FOR MAP
select country_name, avg([Incidence of malaria (per 1,000 population at risk)]) as Pop_at_risk_per_1000, longitude, latitude
from PortfolioProject..DatasetAfricaMalaria
group by country_name, longitude, latitude

--HIGHEST Malaria cases per country(total)
select country_name, sum([Malaria cases reported]) as total_malaria_cases
from PortfolioProject..DatasetAfricaMalaria
where [Malaria cases reported] is not null
group by country_name
order by 2 desc

--Incidence vs access to water per country in Africa
select country_name, avg([People using at least basic drinking water services (% of popula]) as pop_with_acess_to_basic_water
, avg([Incidence of malaria (per 1,000 population at risk)]) as Incidence_of_malari_per_1000
from PortfolioProject..DatasetAfricaMalaria
group by country_name

--Showing the general avg Access to basic drinking water services in an African country since 2007
select year, avg([People using at least basic drinking water services (% of popula]) as acces_to_basic
from PortfolioProject..DatasetAfricaMalaria
group by year 

--INCIDENCE VS ACCESS TO basic sanitaion services per country in Africa
select country_name, avg([People using at least basic sanitation services (% of population]) as people_with_basic_sanitation_services
, avg([Incidence of malaria (per 1,000 population at risk)]) as Incidence_of_malari_per_1000
from PortfolioProject..DatasetAfricaMalaria
group by country_name

--Showing the general avg ACCESS TO basic sanitaion services in an African country since 2007
select year, avg([People using at least basic sanitation services (% of population]) as acces_to_basic_sani
from PortfolioProject..DatasetAfricaMalaria
group by year 






























































