-- Tutorial Questions

-- 1. Modify it to show the population of Germany

SELECT population
FROM world
WHERE name = 'Germany'

-- 2. Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.

SELECT name, population
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

--3. Modify it to show the country and the area for countries with an area between 200,000 and 250,000.

SELECT name, area
FROM world
WHERE area BETWEEN 200000 AND 250000

-- QUIZ

--1. Show the name and population of countries that the polulation is between 1000000 and 1250000

SELECT name, population
FROM world
WHERE population BETWEEN 1000000 AND 1250000

--2. Show the name and population of countries where the name starts from "AL"

SELECT name, population
FROM world
WHERE name LIKE "Al%"

--3. Show the countries that end in A or L

SELECT name
FROM world
WHERE name LIKE '%a' OR name LIKE '%l'

--4. Show the name and name length [length(name)] of countries where name length is 5 and region id 'Europe'

SELECT name, length(name)
FROM world
WHERE length(name)=5 and region='Europe'

--5. Show the name and area (area X 2) of countries that the polulation is equal to 64000

SELECT name, area*2
FROM world
WHERE population = 64000

--6.  Show the countries with an area larger than 50000 and a population smaller than 10000000

SELECT name, area, population
FROM world
WHERE area > 50000 AND population < 10000000

--7. Shows the population density of China, Australia, Nigeria and France

SELECT name, population/area
FROM world
WHERE name IN ('China', 'Nigeria', 'France', 'Australia')










