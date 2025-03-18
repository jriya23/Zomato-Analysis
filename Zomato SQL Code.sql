create database zomato_analysis;
use zomato_analysis;
select* from main;
select* from country;
select* from currency;

select count('restaurant name') from main;

--  Find the Numbers of Resturants based on City and Country.
Select city, count(restaurantid) from main
group by city;

select countryname, count(restaurantid) from main m
left join COUNTRY C ON M.COUNTRYCODE = C. COUNTRYID
group by countryname;

select m.city, count(m.restaurantid) AS city_count, c.countryname
from main m
left join country c on m.countrycode = c.countryid
group by m.city, c.countryname;

--  Numbers of Resturants opening based on Year , Quarter , Month

select distinct Year(year) as year, count( * )
from main
group by year(year);

select distinct monthname(year) as month_name, count( * )
from main
group by monthname(year);

--   Percentage of Resturants based on "Has_Table_booking"

select 
Has_Table_booking,
count(*) AS Totalrestaurants,
round((count(*) / (select count(*) from main)) * 100,2) AS Percentage 
from main
group by Has_table_booking;

--  Percentage of Resturants based on "Has_Online_delivery"

select 
Has_online_delivery,
count(*) AS Totalrestaurants,
round((count(*) / (select count(*) from main)) * 100,2) AS Percentage 
from main
group by Has_online_delivery;


--   Count of Resturants based on Average Ratings

select Rating As IndividualRating,
count(*) AS restaurantcount
from main
where Rating is not null
group by Rating
order by rating asc;

-- Total Cuisines 

select cuisines, Count(cuisines) from main
group by Cuisines;

--  Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets

select Cost_range,
count(*) AS TotalRestaurant
from (
select
case
when Average_Cost_for_two between 0 and 300 then '0-300'
when Average_Cost_for_two between 301 and 600 then '301-600'
when Average_Cost_for_two between 601 and 1000 then '601-1000'
when Average_Cost_for_two between 1001 and 430000 then '1001-430000'
else 'Other'
end AS Cost_range
from main) AS Subquery
group by Cost_range;















