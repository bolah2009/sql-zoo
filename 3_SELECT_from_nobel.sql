-- Tutorial Questions

-- 1. Display Nobel prizes for 1950.

SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950

-- 2. Show who won the 1962 prize for Literature.

SELECT winner
FROM nobel
WHERE yr = 1962
    AND subject = 'Literature'

--3. Show the year and subject that won 'Albert Einstein' his prize.

SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'

--4. Give the name of the 'Peace' winners since the year 2000, including 2000.

SELECT winner
FROM nobel
WHERE subject = 'Peace' AND yr >= 2000

--5. Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.

SELECT *
FROM nobel
WHERE subject = 'Literature' AND yr >= 1980 AND yr <= 1989

--6. Show all details of the presidential winners:

SELECT *
FROM nobel
WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')

--7. Show the winners with first name John

SELECT winner
FROM nobel
WHERE winner LIKE 'John %'

--8. Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.

SELECT *
FROM nobel
WHERE (subject = 'Physics'AND yr = 1980) OR (subject = 'Chemistry' AND yr = 1984)

--9. Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine

SELECT *
FROM nobel
WHERE (yr = 1980) AND NOT (subject = 'Chemistry' OR subject = 'Medicine')

--10. Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)

SELECT *
FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910) OR (subject = 'Literature' AND yr >= 2004)

--11. Find all details of the prize won by PETER GRÜNBERG

SELECT *
FROM nobel
WHERE winner LIKE 'Peter Grünberg'

--12. Find all details of the prize won by EUGENE O'NEILL

SELECT *
FROM nobel
WHERE winner LIKE 'Eugene O''Neill'

--13. List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.

SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner;



--14. Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.

SELECT winner, subject
FROM nobel
WHERE yr = 1984
ORDER BY subject IN ('Chemistry','Physics'), subject, winner

-- QUIZ {BBC QUIZ}

--1. Shows the name of winner's names beginning with C and ending in n

SELECT winner
FROM nobel
WHERE winner LIKE 'C%' AND winner LIKE '%n'

--2. Shows how many Chemistry awards were given between 1950 and 1960

SELECT COUNT(subject)
FROM nobel
WHERE subject = 'Chemistry'
    AND yr BETWEEN 1950 and 1960

--3. Shows the amount of years where no Medicine awards were given

SELECT COUNT(DISTINCT yr)
FROM nobel
WHERE yr NOT IN (SELECT DISTINCT yr
FROM nobel
WHERE subject = 'Medicine')

--4. Show the subject and name of winners that starts with 'Sir' and year starting with '196'

SELECT subject, winner
FROM nobel
WHERE winner LIKE 'Sir%' AND yr LIKE '196%'

--5. Show the year when neither a Physics or Chemistry award was given

SELECT yr
FROM nobel
WHERE yr NOT IN(SELECT yr
FROM nobel
WHERE subject IN ('Chemistry','Physics'))

--6.  Shows the years when a Medicine award was given but no Peace or Literature award was

SELECT DISTINCT yr
FROM nobel
WHERE subject='Medicine'
    AND yr NOT IN(SELECT yr
    FROM nobel
    WHERE subject='Literature')
    AND yr NOT IN (SELECT yr
    FROM nobel
    WHERE subject='Peace')

--7. Shows the subject and amount of subject from '1960' grouped by subject

SELECT subject, COUNT(subject)
FROM nobel
WHERE yr ='1960'
GROUP BY subject
