-- Tutorial Questions

-- 1. How many stops are in the database.

SELECT COUNT(id)
FROM stops

-- 2. Find the id value for the stop 'Craiglockhart'

SELECT id
FROM stops
WHERE name = 'Craiglockhart'

--3. Give the id and the name for the stops on the '4' 'LRT' service.

SELECT id, name
FROM stops JOIN route ON (stops.id=route.stop)
WHERE route.company= 'LRT' AND route.num = '4'

--4. Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.

SELECT company, num, COUNT(*)
FROM route
WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2

--5. Change the query so that it shows the services from Craiglockhart to London Road.

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop=149

--6. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown.

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a
  JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'

--7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')

SELECT DISTINCT a.company, a.num
FROM route a
  JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' AND stopb.name = 'Leith'

--8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'

SELECT DISTINCT a.company, a.num
FROM route a
  JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'Tollcross'

--9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.

SELECT stopb.name, a.company, a.num
FROM route a
  JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE a.company = 'LRT' AND stopa.name = 'Craiglockhart'

--10. Find the routes involving two buses that can go from Craiglockhart to Lochend.
-- Show the bus no. and company for the first bus, the name of the stop for the transfer,
-- and the bus no. and company for the second bus.

SELECT DISTINCT a.num AS 'First Bus no',
  a.company AS 'First Company', stopb.name AS 'Stop name',
  c.num   AS 'Second  Bus no', c.company  AS 'Second Company'
FROM route a
  JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN ( route c JOIN route d ON (c.company = d.company AND c.num= d.num))
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
  JOIN stops stopc ON (c.stop = stopc.id)
  JOIN stops stopd ON (d.stop = stopd.id) 
WHERE stopa.name = 'Craiglockhart' AND stopd.name = 'Lochend' AND stopb.name = stopc.name

-- QUIZ {Self join Quiz}

--1.  Show it is possible to get from Craiglockhart to Haymarket

SELECT DISTINCT a.name, b.name
FROM stops a
  JOIN route z ON a.id=z.stop
  JOIN route y ON y.num = z.num
  JOIN stops b ON y.stop=b.id
WHERE a.name='Craiglockhart' AND b.name ='Haymarket'

--2. Shows the stops that are on route.num '2A' which can be reached with one bus from Haymarket

SELECT S2.id, S2.name, R2.company, R2.num
FROM stops S1, stops S2, route R1, route R2
WHERE S1.name='Haymarket' AND S1.id=R1.stop
  AND R1.company=R2.company AND R1.num=R2.num
  AND R2.stop=S2.id AND R2.num='2A'

--3. Shows the services available from Tollcross

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a
  JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Tollcross'