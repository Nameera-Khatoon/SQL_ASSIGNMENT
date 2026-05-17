-- Use “World” Database to solve the following questions

-- (Hint: World Database is inbuilt in SQL Workbench so use code “use world;” to make use of the database)

use world;

show tables;

-- Question 1 : Count how many cities are there in each country?
select * from country;
select * from city;

select c.CountryCode,co.name country ,count(*) cities
FROM city c
INNER JOIN country co
ON c.CountryCode= co.Code
GROUP BY CountryCode;

-- Question 2 : Display all continents having more than 30 countries.
select * from country; -- checking country table 

-- all continents having more than 30 countries.
SELECT  Continent, count(*) countries
FROM country
GROUP BY Continent
HAVING countries>30;

-- Question 3 : List regions whose total population exceeds 200 million.
select * from country;
SELECT Region, SUM(Population) region_population
FROM country
GROUP BY Region
HAVING region_population > 200000000;

-- Question 4 : Find the top 5 continents by average GNP per country.

select * from country; -- checking country table

-- top 5 continents by average GNP per country
SELECT Continent, AVG(GNP) avg_GNP
FROM country
GROUP BY Continent
ORDER BY avg_GNP DESC
LIMIT 5;


-- Question 5 : Find the total number of official languages spoken in each continent.

select * from country; -- checking country table
select * from countrylanguage; -- checking  countrylanguage

SELECT *
FROM countrylanguage c
WHERE IsOfficial="T"; -- extracting official language for each country

-- total number of official languages spoken in each continent.
SELECT c.Continent Continent, Count(cl.language)  official_languages_spoken
FROM country c
INNER JOIN countrylanguage cl
ON c.Code=cl.CountryCode
WHERE cl.IsOfficial="T"
GROUP BY Continent; 


-- Question 6 : Find the maximum and minimum GNP for each continent.

SELECT * FROM country; -- check country table

-- maximum and minimum GNP for each continent.
SELECT Continent, MIN(GNP) min_GNP, MAX(GNP) max_GNP
FROM country
GROUP BY Continent;

-- Question 7 : Find the country with the highest average city population.
select * from city;
select * from country;

-- country with the highest average city population.
SELECT  c.CountryCode CountryCode,con.name country,AVG(c.Population) AverageCityPopulation
FROM city c
INNER JOIN country con
ON c.CountryCode = con.code
GROUP BY CountryCode
ORDER BY AverageCityPopulation DESC
LIMIT 1;



-- Question 8 : List continents where the average city population is greater than 200,000.
select * from city;
select * from country;

-- average city population is greater than 200,000.
SELECT con.Continent Continent, AVG(c.Population) avg_city_Population
FROM city c
INNER JOIN country con
ON c.CountryCode= con.code
GROUP BY Continent
HAVING avg_city_Population> 200000;


-- Question 9 : Find the total population and average life expectancy for each continent, ordered by average life
-- expectancy descending.
select * from country; -- checki coutry table

-- total population and average life expectancy for each continent, ordered by average life
-- expectancy descending.
SELECT Continent, SUM(Population) total_Population, AVG(LifeExpectancy) avg_LifeExpectancy
FROM country
GROUP BY Continent
ORDER BY avg_LifeExpectancy DESC;


-- Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where
-- the total population is over 200 million.
SELECT Continent, SUM(Population) total_Population, AVG(LifeExpectancy) avg_LifeExpectancy
FROM country
GROUP BY Continent
HAVING total_Population > 200000000
ORDER BY avg_LifeExpectancy DESC
LIMIT 1;
