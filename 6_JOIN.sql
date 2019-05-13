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

--12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid, mdate, COUNT(player) AS 'Total Goals'
FROM game JOIN goal ON matchid = id
WHERE goal.teamid='GER' AND (team1 ='GER' OR team2 ='GER')
GROUP BY matchid, mdate

--13. List every match with the goals scored by each team

SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) AS score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) AS score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY mdate, matchid, team1,team2


-- QUIZ {JOIN Quiz}

--1. Find the stadium where player 'Dimitris Salpingidis' scored.

SELECT stadium
  FROM game  JOIN goal ON (id=matchid)
 WHERE player = 'Dimitris Salpingidis'

--2. You JOIN the tables goal and eteam in an SQL statement. Indicate the list of column names that may be used in the SELECT line:

-- matchid, teamid, player, gtime, id, teamname, coach

--3. Show players, their team and the amount of goals they scored against Greece(GRE).

SELECT player, teamid, COUNT(*)
  FROM game JOIN goal ON matchid = id
 WHERE (team1 = "GRE" OR team2 = "GRE")
   AND teamid != 'GRE'
 GROUP BY player, teamid

--4. Show the player and their team for those who have scored against Poland(POL) in National Stadium, Warsaw.

 SELECT DISTINCT teamid, mdate
  FROM goal JOIN game on (matchid=id)
 WHERE mdate = '9 June 2012'

--5. Show the player and their team for those who have scored against Poland(POL) in National Stadium, Warsaw.

SELECT DISTINCT player, teamid 
   FROM game JOIN goal ON matchid = id 
  WHERE stadium = 'National Stadium, Warsaw' 
 AND (team1 = 'POL' OR team2 = 'POL')
   AND teamid != 'POL'

--6.  Shows the player, their team and the time they scored, for players who have played in Stadion Miejski (Wroclaw) but not against Italy(ITA).

SELECT DISTINCT player, teamid, gtime
  FROM game JOIN goal ON matchid = id
 WHERE stadium = 'Stadion Miejski (Wroclaw)'
   AND (( teamid = team2 AND team1 != 'ITA') OR ( teamid = team1 AND team2 != 'ITA'))

--7. Show team name and goals scored that are less than three goals

SELECT teamname, COUNT(*)
  FROM eteam JOIN goal ON teamid = id
 GROUP BY teamname
HAVING COUNT(*) < 3
