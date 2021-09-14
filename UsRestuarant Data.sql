
select *
from PortfolioProject..UsResturants


--Dropping/deleting Unwanted table 

ALTER TABLE PortfolioProject..UsResturants
DROP COLUMN F1

--counting Total cities in the US

select count(distinct(city)) as Total_cities, country
from PortfolioProject..UsResturants
group by country

--Counting the total distinct restaurant names

select count(distinct(name)) as Total_Restaurants, country
from PortfolioProject..UsResturants
group by country


select *
from PortfolioProject..UsResturants


--Removing DUPLICATE DATA

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY Latitude,
				 longitude,
				 address
				 ORDER BY
					postalcode
					) row_num

From PortfolioProject..UsResturants
)
select *
From RowNumCTE
Where row_num > 1
Order by postalcode



--Cities with the resturaunt name and number of restuarants (detailed)

select city, name, count(name)
from PortfolioProject..UsResturants
group by name, city


--cities with the higest number of resturaunts

select city, count(categories) as no_of_restuarants
from PortfolioProject..UsResturants
group by city
order by 2 desc

--states with highest and least restaurants

select count(categories) as no_of_restuarants, province as states
from PortfolioProject..UsResturants
group by province
order by 1 desc


--Restaurants with the highest Location according to states and cities

select name, count(distinct(province)) as Total_states, count(city) as total_cities
from PortfolioProject..UsResturants
group by name
order by 3 desc

--Correcting Restaurant Name Errors
--Note: These Errors were manually located and a were alot, these bulky name errors lenghtened the query written 
--Note: For example Arby's will be renamed as Arbys because ('') Apostrophys needs to be closed in SQL else it will return as error
--similar cases will follow this trend
--All Arbys variants eg Arby's will all be converted to Arbys (this error is queried seperately 
--as example because querying the rest like so will be redundant)

--Checking for variants

Select Distinct(name), Count(name)
From PortfolioProject..UsResturants
where name like 'Arb%'
Group by name
order by 2

--Deciding how to replace/change the variants using CASE
Select name
, CASE When name like '%Arby%' THEN 'Arbys'
	    ELSE name
	    END
from PortfolioProject..UsResturants
order by 1

--Updating all Arbys
Update PortfolioProject..UsResturants
SET name = CASE When name like '%Arby%' THEN 'Arbys'
	    ELSE name
	    END


--Updating Process for Restuarant Names with Errors

Select Distinct(name), Count(name)
From PortfolioProject..UsResturants
where name like '%Mcdo%'
Group by name
order by 2

Select name
, CASE When name like 'Baker%' THEN 'Bakers Drive Thru'
       When name like 'bob evans%' THEN 'Bob Evans'
	   When name like 'bojangles%' THEN 'Bojangles'
	   When name like 'Carl%' THEN 'Carls Jr'
	   When name like 'Chipotle%' THEN 'Chipotle Mexican Grill'
	   When name like 'Five%' THEN 'Five Guys'
	   When name like 'Foster%' THEN 'Fosters Freeze'
	   When name like 'hardee%' THEN 'Hardees'
	   When name like 'jack in the%' THEN 'Jack in the Box'
	   When name like 'jimmy john%' THEN 'Jimmy Johns'
	   When name like 'kfc%' THEN 'KFC'
	   When name like 'little caesar%' THEN 'Little Caesars'
	   When name like 'Long john silver%' THEN 'Long John Silvers'
	   When name like 'Mcdonald%' THEN 'McDonalds'
	   When name like 'Mc donald%' THEN 'McDonalds'
--Theres a McDonalds named as Mc donalds, thats why the previous query needed to be added
--Theres also the next error which wasnt found unitil the data was queried using '%Mcd___________%' in the query
       When name like '%Mcd___________%' THEN 'McDonalds'
       When name like 'Panda%' THEN 'Panda Express'
	   When name like 'Quizno%' THEN 'Quiznos'
	   When name like 'rally%' THEN 'Rallys'
	   When name like 'roma%' THEN 'Romas Pizza'
	   When name like 'sonic%' THEN 'Sonic Drive-in'
	   When name like '%__shake%' THEN 'Steak N Shake'
	   When name like 'subway%' THEN 'Subway'
	   When name like 'Taco bell%' THEN 'Taco Bell'
	   When name like 'Topper%' THEN 'Toppers Pizza'
	   When name like 'Wiener%' THEN 'Wienerschnitzel'
	   When name like 'Wingstop%' THEN 'Wingstop'
	   When name like 'Zaxby%' THEN 'Zaxbys'
	    ELSE name
	    END
from PortfolioProject..UsResturants
order by 1

--Finally updating the data base (this is the last/final step in correcting the Restuarant name error)	  

Update PortfolioProject..UsResturants
SET name = CASE When name like 'Baker%' THEN 'Bakers Drive Thru'
       When name like 'bob evans%' THEN 'Bob Evans'
	   When name like 'bojangles%' THEN 'Bojangles'
	   When name like 'Carl%' THEN 'Carls Jr'
	   When name like 'Chipotle%' THEN 'Chipotle Mexican Grill'
	   When name like 'Five%' THEN 'Five Guys'
	   When name like 'Foster%' THEN 'Fosters Freeze'
	   When name like 'hardee%' THEN 'Hardees'
	   When name like 'jack in the%' THEN 'Jack in the Box'
	   When name like 'jimmy john%' THEN 'Jimmy Johns'
	   When name like 'kfc%' THEN 'KFC'
	   When name like 'little caesar%' THEN 'Little Caesars'
	   When name like 'Long john silver%' THEN 'Long John Silvers'
	   When name like 'Mcdonald%' THEN 'McDonalds'
	   When name like 'Mc donald%' THEN 'McDonalds'
--Theres a McDonalds named as Mc donalds, thats why the previous query needed to be added
--Theres also the next error which wasnt found unitil the data was queried using '%Mcd___________%' in the query
       When name like '%Mcd___________%' THEN 'McDonalds'
       When name like 'Panda%' THEN 'Panda Express'
	   When name like 'Quizno%' THEN 'Quiznos'
	   When name like 'rally%' THEN 'Rallys'
	   When name like 'roma%' THEN 'Romas Pizza'
	   When name like 'sonic%' THEN 'Sonic Drive-in'
	   When name like '%__shake%' THEN 'Steak N Shake'
	   When name like 'subway%' THEN 'Subway'
	   When name like 'Taco bell%' THEN 'Taco Bell'
	   When name like 'Topper%' THEN 'Toppers Pizza'
	   When name like 'Wiener%' THEN 'Wienerschnitzel'
	   When name like 'Wingstop%' THEN 'Wingstop'
	   When name like 'Zaxby%' THEN 'Zaxbys'
	    ELSE name
	    END



select *
from PortfolioProject..UsResturants


--Changing the Abbreviations in the province column to their full meaning

Select Province
,  CASE When province like 'AL%' THEN	'Alabama'
     When province like 'AK%' THEN	'Alaska'
     When province like 'AZ%' THEN 'Arizona'
     When province like'AR%' THEN 'Arkansas'
     When province like 'CA%' THEN 'California'
     When province like 'CO%' THEN	'Colorado'
     When province like 'CT%' THEN 'Connecticut'
     When province like 'DE%' THEN	'Delaware'
     When province like 'FL%' THEN	'Florida'
     When province like 'GA%' THEN 'Georgia'
     When province like 'HI%' THEN	'Hawaii'
     When province like 'ID%' THEN 'Idaho'
     When province like 'IL%' THEN 'Illinois'
     When province like 'IN%' THEN 'Indiana'
     When province like 'IA%' THEN 	'Iowa'
     When province like  'KS%' THEN	'Kansas'
     When province like 'KY%' THEN 'Kentucky'
     When province like 'LA%' THEN 'Louisiana'
     When province like 'ME%' THEN 'Maine'
	 When province like 'MD%' THEN 'Maryland'
	 When province like 'MA%' THEN 'Massachusetts'
	 When province like 'MI%' THEN 'Michigan'
	 When province like 'MN%' THEN 'Minnesota'
	 When province like 'MS%' THEN 'Mississippi'
	 When province like 'MO%' THEN 'Missouri'
	 When province like 'MT%' THEN 'Montana'
	 When province like 'NE%' THEN 'Nebraska'
	 When province like 'NV%' THEN 'Nevada'
	 When province like 'NH%' THEN 'New Hampshire'
	 When province like 'NJ%' THEN 'New Jersey'
	 When province like 'NM%' THEN 'New Mexico'
	 When province like 'NY%' THEN 'New York'
	 When province like 'NC%' THEN 'North Carolina'
	 When province like 'ND%' THEN 'North Dakota'
	 When province like 'OH%' THEN 'Ohio'
	 When province like 'OK%' THEN 'Oklahoma'
	 When province like 'OR%' THEN 'Oregon'
	 When province like 'PA%' THEN 'Pennsylvania'
	 When province like 'RI%' THEN 'Rhode Island'
	 When province like 'SC%' THEN 'South Carolina'
	 When province like 'SD%' THEN 'South Dakota'
	 When province like 'TN%' THEN 'Tennessee'
	 When province like 'TX%' THEN 'Texas'
	 When province like 'UT%' THEN 'Utah'
	 When province like 'VT%' THEN 'Vermont'
	 When province like 'VA%' THEN 'Virginia'
	 When province like 'WA%' THEN 'Washington'
	 When province like 'WV%' THEN 'West Virginia'
	 When province like 'WI%' THEN 'Wisconsin'
	 When province like 'WY%' THEN 'Wyoming'
      ELSE name
	    END
from PortfolioProject..UsResturants
order by 1


--Creating A new table for STATES and Pasting the CASE statements into it
--At this point, a new table STATES will be Created and the Abbrevations in the province will be moved to states column and kept in full format
ALTER TABLE PortfolioProject..UsResturants
Add States Nvarchar(255)

Update PortfolioProject..UsResturants
SET states = CASE When province like 'AL%' THEN	'Alabama'
     When province like 'AK%' THEN	'Alaska'
     When province like 'AZ%' THEN 'Arizona'
     When province like'AR%' THEN 'Arkansas'
     When province like 'CA%' THEN 'California'
     When province like 'CO%' THEN	'Colorado'
     When province like 'CT%' THEN 'Connecticut'
     When province like 'DE%' THEN	'Delaware'
     When province like 'FL%' THEN	'Florida'
     When province like 'GA%' THEN 'Georgia'
     When province like 'HI%' THEN	'Hawaii'
     When province like 'ID%' THEN 'Idaho'
     When province like 'IL%' THEN 'Illinois'
     When province like 'IN%' THEN 'Indiana'
     When province like 'IA%' THEN 	'Iowa'
     When province like  'KS%' THEN	'Kansas'
     When province like 'KY%' THEN 'Kentucky'
     When province like 'LA%' THEN 'Louisiana'
     When province like 'ME%' THEN 'Maine'
	 When province like 'MD%' THEN 'Maryland'
	 When province like 'MA%' THEN 'Massachusetts'
	 When province like 'MI%' THEN 'Michigan'
	 When province like 'MN%' THEN 'Minnesota'
	 When province like 'MS%' THEN 'Mississippi'
	 When province like 'MO%' THEN 'Missouri'
	 When province like 'MT%' THEN 'Montana'
	 When province like 'NE%' THEN 'Nebraska'
	 When province like 'NV%' THEN 'Nevada'
	 When province like 'NH%' THEN 'New Hampshire'
	 When province like 'NJ%' THEN 'New Jersey'
	 When province like 'NM%' THEN 'New Mexico'
	 When province like 'NY%' THEN 'New York'
	 When province like 'NC%' THEN 'North Carolina'
	 When province like 'ND%' THEN 'North Dakota'
	 When province like 'OH%' THEN 'Ohio'
	 When province like 'OK%' THEN 'Oklahoma'
	 When province like 'OR%' THEN 'Oregon'
	 When province like 'PA%' THEN 'Pennsylvania'
	 When province like 'RI%' THEN 'Rhode Island'
	 When province like 'SC%' THEN 'South Carolina'
	 When province like 'SD%' THEN 'South Dakota'
	 When province like 'TN%' THEN 'Tennessee'
	 When province like 'TX%' THEN 'Texas'
	 When province like 'UT%' THEN 'Utah'
	 When province like 'VT%' THEN 'Vermont'
	 When province like 'VA%' THEN 'Virginia'
	 When province like 'WA%' THEN 'Washington'
	 When province like 'WV%' THEN 'West Virginia'
	 When province like 'WI%' THEN 'Wisconsin'
	 When province like 'WY%' THEN 'Wyoming'
      ELSE name
	    END


