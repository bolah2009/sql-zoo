-- Tutorial Questions

-- 1. Show the matchid and player name for all goals scored by Germany

SELECT matchid, player
FROM goal
WHERE teamid = 'GER'

-- 2. Show id, stadium, team1, team2 for just game 1012

SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012

--3. Show the player, teamid, stadium and mdate for every German goal.

SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE goal.teamid = 'GER'

--4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT team1, team2, player
FROM game JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%'

--5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON (eteam.id=goal.teamid)
WHERE gtime<=10

--6. List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT mdate, teamname
FROM game JOIN eteam ON (eteam.id=game.team1)
WHERE coach = 'Fernando Santos'

--7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT player
FROM goal JOIN game ON (game.id=goal.matchid)
WHERE stadium = 'National Stadium, Warsaw'

--8. Show the name of all players who scored a goal against Germany.

SELECT DISTINCT player
FROM game JOIN goal ON matchid = id
WHERE goal.teamid!='GER' AND (team1 ='GER' OR team2 ='GER')

--9. Show teamname and the total number of goals scored.

SELECT teamname, COUNT(player) AS 'Total Goals'
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname

--10. Show the stadium and the number of goals scored in each stadium.

SELECT stadium, COUNT(player) AS 'Total Goals'
FROM game JOIN goal ON id=matchid
GROUP BY stadium

--11. For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT matchid, mdate, COUNT(player) AS 'Total Goals'
FROM game JOIN goal ON matchid = id
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate

-- QUIZ {JOIN Quiz 2}

--1. Lists the unfortunate directors of the movies which have caused financial loses (gross < budget)

SELECT name
FROM actor INNER JOIN movie ON actor.id = director
WHERE gross < budget

--2. Example of JOINing three tables

SELECT *
FROM actor JOIN casting ON actor.id = actorid
  JOIN movie ON movie.id = movieid

--3. Shows the list of actors called 'John' by order of number of movies in which they acted

SELECT name, COUNT(movieid)
FROM casting JOIN actor ON actorid=actor.id
WHERE name LIKE 'John %'
GROUP BY name
ORDER BY 2 DESC

--4. Show the title where Paul Hogan is the main actor

SELECT title
FROM movie JOIN casting ON (movieid=movie.id)
  JOIN actor ON (actorid=actor.id)
WHERE name='Paul Hogan' AND ord = 1

--5. Lists all the actors that starred in movies directed by Ridley Scott who has id 351

SELECT name
FROM movie JOIN casting ON movie.id = movieid
  JOIN actor ON actor.id = actorid
WHERE ord = 1 AND director = 351

--6.  There are two sensible ways to connect movie and actor. They are:

-- link the director column in movies with the primary key in actor
-- connect the primary keys of movie and actor via the casting table

--7. Show the title of movie and year where Robert De Niro is the supporting actor (ord=3)

SELECT title, yr
FROM movie, casting, actor
WHERE name='Robert De Niro' AND movieid=movie.id AND actorid=actor.id AND ord = 3
