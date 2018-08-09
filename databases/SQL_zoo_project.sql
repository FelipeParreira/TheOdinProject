-- ~~~~~~~~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~
-- TUTORIALS
-- ~~~~~~~~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~

-- ========================
-- 0 SELECT basics Tutorial
-- ========================

-- 1
SELECT population FROM world
WHERE name = 'Germany';

-- 2
SELECT name, population FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

-- 3
SELECT name, area FROM world
WHERE area
BETWEEN 200000 AND 250000;

-- ========================
-- 1 SELECT names Tutorial
-- ========================

-- 1
SELECT name FROM world
WHERE name LIKE 'Y%';

-- 2
SELECT name FROM world
WHERE name LIKE '%Y';

-- 3
SELECT name FROM world
WHERE name LIKE '%x%';

-- 4
SELECT name FROM world
WHERE name LIKE '%land';

-- 5
SELECT name FROM world
WHERE name LIKE 'C%ia';

-- 6
SELECT name FROM world
WHERE name LIKE '%oo%';

-- 7
SELECT name FROM world
WHERE name LIKE '%a%a%a%';

-- 8
SELECT name FROM world
WHERE name LIKE '_t%'
ORDER BY name;

-- 9
SELECT name FROM world
WHERE name LIKE '%o__o%';

-- 10
SELECT name FROM world
WHERE LENGTH(name) = 4;

-- 11
SELECT name
FROM world
WHERE name = capital;

-- 12
SELECT name
FROM world
WHERE capital = concat(name, ' City');

-- 13
SELECT capital, name FROM world
WHERE capital LIKE concat('%', concat(name, '%'));

-- 14
SELECT capital, name FROM world
WHERE capital LIKE concat('%', concat(name, '%'))
AND LENGTH(capital) > LENGTH(name);

-- 15
SELECT name, REPLACE(capital, name, '') FROM world
WHERE capital LIKE concat('%', concat(na
  me, '%'))
AND LENGTH(capital) > LENGTH(name);

-- ========================
-- 2 SELECT from WORLD Tutorial
-- ========================

-- 1
SELECT name, continent, population FROM world;

-- 2
SELECT name FROM world
WHERE population >= 200000000;

-- 3
SELECT name, gdp/population FROM world
WHERE population >= 200000000;

-- 4
SELECT name, population/1000000 FROM world
WHERE continent = 'South America';

-- 5
SELECT name, population FROM world
WHERE name IN ('France', 'Germany', 'Italy');

-- 6
SELECT name FROM world WHERE name LIKE '%United%';

-- 7
SELECT name, population, area FROM world
WHERE population > 250000000 OR area > 3000000;

-- 8
SELECT name, population, area FROM world
WHERE population > 250000000 XOR area > 3000000;

-- 9
SELECT name, ROUND(population/1000000, 2),
ROUND(gdp/1000000000, 2) FROM world
WHERE continent = 'South America';

-- 10
SELECT name, ROUND((gdp/population)/1000, 0)*1000
FROM world WHERE gdp >= 1000000000000;

-- 11
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);

-- 12
SELECT name, capital
FROM world WHERE LEFT(name,1) = LEFT(capital,1)
AND name != capital;

-- 13
SELECT name
FROM world
WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%'
AND name LIKE '%o%' AND name LIKE '%u%'
AND
name NOT LIKE '% %';

-- ========================
-- 3 SELECT from Nobel Tutorial
-- ========================

-- 1
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;

-- 2
SELECT winner
FROM nobel
WHERE yr = 1962  AND subject = 'Literature';

-- 3
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';

-- 4
SELECT winner
FROM nobel
WHERE subject = 'Peace' AND yr >= 2000;

-- 5
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Literature' AND yr >= 1980 AND yr <= 1989;

-- 6
SELECT * FROM nobel
WHERE winner IN ('Theodore Roosevelt',
'Woodrow Wilson',
'Jimmy Carter',
'Barack Obama');

-- 7
SELECT winner FROM nobel
WHERE winner LIKE 'John%';

-- 8
SELECT yr, subject, winner FROM nobel
WHERE (subject = 'Physics' AND yr = 1980)
OR (subject = 'Chemistry' AND yr = 1984);

-- 9
SELECT yr, subject, winner FROM nobel
WHERE yr = 1980
AND subject NOT IN ('Chemistry', 'Medicine');

-- 10
SELECT yr, subject, winner FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910)
OR (subject = 'Literature' AND yr >= 2004);

-- 11
SELECT * FROM nobel
WHERE winner = 'PETER GRÜNBERG';

-- 12
SELECT * FROM nobel
WHERE winner = 'EUGENE O\'NEILL';

-- 13
SELECT winner, yr, subject FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner;

-- 14
SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Phys
  ics','Chemistry'), subject, winner;

-- ========================
-- 4 SELECT within SELECT Tutorial
-- ========================

-- 1
SELECT name FROM world
WHERE population >
(SELECT population FROM world
WHERE name='Russia');

-- 2
SELECT name FROM world
WHERE gdp/population >
(SELECT gdp/population FROM world
WHERE name = 'United Kingdom') AND continent = 'Europe';

-- 3
SELECT name, continent FROM world
WHERE continent IN
(SELECT continent FROM world
WHERE name IN ('Argentina', 'Australia')) ORDER BY name;

-- 4
SELECT name, population FROM world WHERE
population > (SELECT population FROM world WHERE name = 'Canada')
AND population < (SELECT population FROM world WHERE name = 'Poland');

-- 5
SELECT name, CONCAT(ROUND(100 * population/
(SELECT population FROM world WHERE name = 'Germany')), '%')
FROM world WHERE continent = 'Europe';

-- 6
SELECT name FROM world
WHERE gdp >
ALL (SELECT gdp FROM world WHERE gdp > 0 AND continent = 'Europe');

-- 7
SELECT continent, name, area FROM world x
WHERE area >= ALL
(SELECT area FROM world y
WHERE y.continent = x.continent
AND y.area > 0);

-- 8
SELECT continent, name FROM world x
WHERE name <= ALL
(SELECT name FROM world y WHERE y.continent = x.continent);

-- 9
SELECT name, continent, population FROM world x
WHERE continent IN
(SELECT continent FROM world
GROUP BY continent HAVING MAX(population) <= 25000000);

-- 10
SELECT name, continent FROM world x WHERE population > ALL
(SELECT 3 * population FROM world y WHER
  E y.name != x.name
AND y.continent = x.continent);

-- ========================
-- 5 SUM and COUNT Tutorial
-- ========================

-- 1
SELECT SUM(population)
FROM world;

-- 2
SELECT DISTINCT continent FROM world;

-- 3
SELECT SUM(GDP) FROM world WHERE continent = 'Africa';

-- 4
SELECT COUNT(name) FROM world WHERE area >= 1000000;

-- 5
SELECT SUM(population) FROM world
WHERE name in ('Estonia', 'Latvia', 'Lithuania');

-- 6
SELECT continent, COUNT(name)
FROM world GROUP BY continent;

-- 7
SELECT continent, COUNT(name) FROM world
WHERE population >= 10000000 GROUP BY continent;

-- 8
SELECT continent FROM world
GROUP BY continent HAVING SUM(population) >= 100000000;

-- ========================
-- The nobel table can be used to practice more SUM and COUNT functions.
-- ========================

-- 1
SELECT COUNT(winner) FROM nobel;

-- 2
SELECT DISTINCT subject FROM nobel;

-- 3
SELECT COUNT(winner) FROM nobel
WHERE subject = 'Physics';

-- 4
SELECT subject, COUNT(winner)
FROM nobel GROUP BY subject;

-- 5
SELECT subject, MIN(yr) FROM nobel
GROUP BY subject;

-- 6
SELECT subject, COUNT(winner)
FROM nobel WHERE yr = 2000 GROUP BY subject;

-- 7
SELECT subject, COUNT(DISTINCT winner)
FROM nobel GROUP BY subject;

-- 8
SELECT subject, COUNT(DISTINCT yr)
FROM nobel GROUP BY subject;

-- 9
SELECT yr FROM nobel WHERE subject = 'Physics'
GROUP BY yr HAVING COUNT(winner) = 3;

-- 10
SELECT winner FROM nobel
GROUP BY winner HAVING COUNT(yr) > 1;

-- 11
SELECT winner FROM nobel
GROUP BY winner HAVING COUNT(DISTINCT subject) > 1;

-- 12
SELECT yr, subject FROM nobel
WHERE yr >= 2000 GROUP BY yr, subject
HA
VING COUNT(winner) = 3;

-- ========================
-- 6 The JOIN operation Tutorial
-- ========================

-- 1
SELECT matchid, player FROM goal
WHERE teamid = 'GER';

-- 2
SELECT DISTINCT id, stadium, team1, team2
FROM game JOIN goal ON game.id = goal.matchid
WHERE matchid = 1012;

-- 3
SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER';

-- 4
SELECT team1, team2, player FROM goal JOIN game
ON id=matchid
WHERE player LIKE 'Mario%';

-- 5
SELECT player, teamid, coach, gtime
FROM goal JOIN eteam on teamid=id
WHERE gtime<=10;

-- 6
SELECT mdate, teamname
FROM game JOIN eteam ON (team1=eteam.id)
WHERE coach = 'Fernando Santos';

-- 7
SELECT player
FROM game JOIN goal ON (id=matchid)
WHERE stadium = 'National Stadium, Warsaw';

-- 8
SELECT DISTINCT player
FROM game JOIN goal ON matchid = id
WHERE (team1='GER' OR team2='GER')
AND (teamid != 'GER');

-- 9
SELECT teamname, COUNT(*)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname;

-- 10
SELECT stadium, COUNT(*)
FROM game JOIN goal ON (id=matchid)
GROUP BY stadium;

-- 11
SELECT matchid,mdate, COUNT(*)
FROM game JOIN goal ON matchid = id
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate;

-- 12
SELECT matchid,mdate, COUNT(*)
FROM game JOIN goal ON matchid = id
WHERE (teamid = 'GER') GROUP BY matchid, mdate;

-- 13
SELECT mdate, team1,
SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
team2,
SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game JOIN goal ON matchid = id GROU
P BY mdate,
team1, team2 ORDER BY mdate, matchid, team1, team2;

-- ========================
-- Old JOIN Tutorial
-- ========================

-- 1
SELECT who, country.name
FROM ttms JOIN country
ON (ttms.country=country.id)
WHERE games = 2000;

-- 2
SELECT who, color  FROM ttms JOIN country
ON (ttms.country=country.id)
WHERE country.name = 'Sweden';

-- 3
SELECT games FROM ttms JOIN country
ON (ttms.country=country.id)
WHERE country.name = 'China' AND color = 'gold'
GROUP BY games HAVING COUNT(*) > 0;

-- 4
SELECT who
FROM ttws JOIN games
ON (ttws.games=games.yr)
WHERE city = 'Barcelona';

-- 5
SELECT city, color
FROM ttws JOIN games
ON (ttws.games=games.yr)
WHERE who = 'Jing Chen';

-- 6
SELECT who, city
FROM ttws JOIN games
ON (ttws.games=games.yr)
WHERE color = 'gold';

-- 7
SELECT games, color
FROM ttmd JOIN team
ON (team=id)
WHERE name = 'Yan Sen';

-- 8
SELECT name
FROM ttmd JOIN team
ON (team=id)
WHERE color = 'gold' AND games = 2004;

-- 9
SELECT name
FROM ttmd JOIN team
ON (team=id)
WHERE country = 'FRA';

-- ========================
-- Music Tutorial
-- ========================

-- 1
SELECT title, artist
FROM album JOIN track
ON (album.asin=track.album)
WHERE song = 'Alison';

-- 2
SELECT artist
FROM album JOIN track
ON (album.asin=track.album)
WHERE song = 'Exodus';

-- 3
SELECT song
FROM album JOIN track
ON album.asin=track.album
WHERE title = 'Blur';

-- 4
SELECT title, COUNT(*)
FROM album JOIN track ON (asin=album)
GROUP BY title;

-- 5
SELECT title, COUNT(*)
FROM album JOIN track ON (asin=album)
WHERE song LIKE '%Heart%'
GROUP BY title;

-- 6
SELECT song
FROM album JOIN track ON (asin=album)
WHERE song = title;

-- 7
SELECT DISTINCT title
FROM album WHERE artist = title;

-- 8
SELECT song, COUNT(DISTINCT title)
FROM album JOIN track ON (asin=album)
GROUP BY song HAVING COUNT(DISTINCT title) > 2;

-- 9
SELECT title, price, COUNT(song)
FROM album JOIN track ON (asin=album)
GROUP BY title, price HAVING price/COUNT(song) < 0.50;

-- 10
SELECT title, COUNT(song) FROM album JOI
N track ON album.asin=track.album
GROUP BY title ORDER BY COUNT(song) DESC;

-- ========================
-- 7 More JOIN operations Tutorial
-- ========================

-- 1
SELECT id, title
FROM movie
WHERE yr=1962;

-- 2
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 4
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 6
SELECT name
FROM actor JOIN casting
ON actor.id = casting.actorid
WHERE movieid  = 11768;

-- 7
SELECT name
FROM actor JOIN casting
ON actor.id = casting.actorid
WHERE movieid  =
(SELECT id FROM movie
WHERE title = 'Alien');

-- 8
SELECT title
FROM movie JOIN casting
ON movie.id = casting.movieid
WHERE actorid  =
(SELECT id FROM actor
WHERE name = 'Harrison Ford');

-- 9
SELECT title
FROM movie JOIN casting
ON movie.id = casting.movieid
WHERE actorid  = (SELECT id FROM actor
WHERE name = 'Harrison Ford') AND ord != 1;

-- 10
SELECT title, name
FROM movie JOIN casting
ON movie.id = casting.movieid
JOIN actor on actor.id = casting.actorid
WHERE  ord = 1 AND yr = 1962;

-- 11
SELECT yr, COUNT(DISTINCT title)
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'John Travolta'
GROUP BY yr HAVING COUNT(DISTINCT title) > 2;

-- 12
SELECT title, name FROM actor
JOIN casting ON actor.id = actorid
JOIN movie ON movieid = movie.id
WHERE ord = 1 AND movieid
IN (SELECT  movieid FROM movie JOIN casting
WHERE actorid = (SELECT id FROM actor WHERE name = 'Julie Andrews'));

-- 13
SELECT name FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE ord = 1 GROUP BY name
HAVING COUNT(movieid) >= 30 ORDER BY name;

-- 14
SELECT title, COUNT(DISTINCT actorid)
FROM movie JOIN casting ON movieid = movie.id
WHERE yr = 1978 GROUP BY movieid, title
ORDER BY COUNT(DISTINCT actorid) DESC, title;

-- 15
SELECT name FROM casting
JOIN (SELECT movieid FROM casting
JOIN actor ON actor.id = casting.actorid
WHERE name = 'Art Garfunkel') c
ON casting.movieid = c.movieid
JOIN actor ON actor.id = actorid
WHERE n
ame != 'Art Garfunkel';

-- ========================
-- 8 Using Null Tutorial
-- ========================

-- 1
SELECT name
FROM teacher WHERE dept IS NULL;

-- 2
SELECT teacher.name, dept.name
FROM teacher INNER JOIN dept
ON (teacher.dept=dept.id);

-- 3
SELECT teacher.name, dept.name
FROM teacher LEFT JOIN dept
ON (teacher.dept=dept.id);

-- 4
SELECT teacher.name, dept.name
FROM teacher RIGHT JOIN dept
ON (teacher.dept=dept.id);

-- 5
SELECT teacher.name,
COALESCE(mobile, '07986 444 2266')
FROM teacher;

-- 6
SELECT teacher.name, COALESCE(dept.name, 'None')
FROM teacher LEFT JOIN dept
ON (teacher.dept=dept.id);

-- 7
SELECT COUNT(teacher.name), COUNT(mobile)
FROM teacher;

-- 8
SELECT dept.name, COUNT(teacher.name)
FROM dept LEFT JOIN teacher
ON (teacher.dept=dept.id) GROUP BY dept.name;

-- 9
SELECT teacher.name,
CASE WHEN dept = 1 THEN 'Sci'
WHEN dept = 2 THEN 'Sci'
ELSE 'Art' END
FROM teacher;

-- 10
SELECT teacher.name,
CASE WHEN dept = 1 THEN 'Sci'
WHEN dept = 2 THEN 'Sci'
WHEN dept = 3 THEN 'Art'
ELSE 'None' END
FROM teacher;

-- ========================
-- Scottish Parliament Tutorial
-- ========================

-- 1
SELECT name FROM msp WHERE Party IS NULL;

-- 2
SELECT name, leader FROM party;

-- 3
SELECT name, leader FROM party
WHERE leader IS NOT NULL;

-- 4
SELECT DISTINCT party.name
FROM party JOIN  msp
ON msp.party = party.code ;

-- 5
SELECT DISTINCT msp.name, party.name
FROM party RIGHT JOIN  msp
ON msp.party = party.code
ORDER BY msp.name;

-- 6
SELECT DISTINCT  party.name, COUNT(msp.name)
FROM party JOIN  msp ON msp.party = party.code
GROUP BY party.name ORDER BY msp.name;

-- 7
SELECT DISTINCT  party.name, COUNT(msp.name)
FROM party LEFT JOIN  msp ON msp.party =
 party.code
GROUP BY party.name ORDER BY msp.name;

-- ========================
-- 8+ NSS Tutorial
-- ========================

-- 1
SELECT A_STRONGLY_AGREE
FROM nss
WHERE question='Q01'
AND institution='Edinburgh Napier University'
AND subject='(8) Computer Science';

-- 2
SELECT institution, subject
FROM nss
WHERE question='Q15'
AND score >= 100;

-- 3
SELECT institution, score
FROM nss
WHERE question='Q15'
AND subject='(8) Computer Science'
AND score < 50;

-- 4
SELECT subject, SUM(response)
FROM nss
WHERE question='Q22'
AND subject in ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;

-- 5
SELECT subject, SUM(A_STRONGLY_AGREE*response/100)
FROM nss
WHERE question='Q22'
AND subject in ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;

-- 6
SELECT subject, ROUND(100*SUM(A_STRONGLY_AGREE*response/100)/SUM(response))
FROM nss
WHERE question='Q22'
AND subject in ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;

-- 7
SELECT institution, ROUND(SUM(score * response)/SUM(response))
FROM nss
WHERE question='Q22'
AND (institution LIKE '%Manchester%') GROUP BY institution
ORDER BY institution;

-- 8
SELECT institution, SUM(sample), SUM(CASE WHEN subject = '(8) Computer Science'
THEN sample ELSE 0 END)
FROM nss
WHERE question='Q01'
AND (institution LIKE '%Manchester%')
GR
OUP BY institution;

-- ========================
-- 9 Self join Tutorial
-- ========================

-- 1
SELECT COUNT(id) FROM stops;

-- 2
SELECT id FROM stops
WHERE name ='Craiglockhart';

-- 3
SELECT DISTINCT id, name
FROM stops JOIN route ON stops.id = route.stop
WHERE company ='LRT' AND num = 4 ;

-- 4
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num HAVING COUNT(*) = 2;

-- 5
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = 149;

-- 6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road';

-- 7
SELECT DISTINCT a.company , a.num
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
WHERE a.stop=115 AND b.stop = 137;

-- 8
SELECT a.company, a.num
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='Tollcross';

-- 9
SELECT stopb.name, a.company, a.num
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND a.company = 'LRT';

-- 10
SELECT DISTINCT c.num, c.comp, f.name, d.num, d.comp
FROM (SELECT a.company comp, a.num num, b.stop stop FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num) WHERE a.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart')) c JOIN
(SELECT p.company comp, p.num num, p.stop stop FROM route p JOIN route q ON (p.company = q.company AND p.num = q.num) WHERE q.stop = (SELECT id FROM stops WHERE name = 'Sighthill')) d
ON c.stop = d.stop
JOIN stops f  ON f.id = c.stop WHERE f.name != 'Craiglockhart' AND f.name != 'Sighthill';

-- ~~~~~~~~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~
-- QUIZZES
-- ~~~~~~~~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~

-- ========================
-- SELECT Quiz
-- ========================

-- 1
SELECT name, population
FROM world
WHERE population BETWEEN 1000000 AND 1250000;

-- 2
Table E

-- 3
SELECT name FROM world
WHERE name LIKE '%a' OR name LIKE '%l';

-- 4
Third Option

-- 5
Third Option

-- 6
SELECT name, area, population
FROM world
WHERE area > 50000 AND population < 10000000;

-- 7
SELECT name, population/area
FROM world
WHERE name IN ('China', 'Nigeria', 'France', 'Australia');

-- ========================
-- BBC Quiz
-- ========================

-- 1
SELECT name
FROM world
WHERE name LIKE 'U%';

-- 2
SELECT population
FROM world
WHERE name = 'United Kingdom';

-- 3
'name' should be name

-- 4
Nauru	990

-- 5
SELECT name, population
FROM world
WHERE continent IN ('Europe', 'Asia');

-- 6
SELECT name FROM world
WHERE name IN ('Cuba', 'Togo');

-- 7
Brazil
Colombia

-- ========================
-- Nobel Quiz
-- ========================

-- 1
SELECT winner FROM nobel
WHERE winner LIKE 'C%' AND winner LIKE '%n';

-- 2
SELECT COUNT(subject) FROM nobel
WHERE subject = 'Chemistry'
AND yr BETWEEN 1950 and 1960;

-- 3
SELECT COUNT(DISTINCT yr) FROM nobel
WHERE yr NOT IN (SELECT DISTINCT yr FROM nobel WHERE subject = 'Medicine');

-- 4
Medicine	Sir John Eccles
Medicine	Sir Frank Macfarlane Burnet

-- 5
SELECT yr FROM nobel
WHERE yr NOT IN(SELECT yr
FROM nobel
WHERE subject IN ('Chemistry','Physics'));

-- 6
SELECT DISTINCT yr
FROM nobel
WHERE subject='Medicine'
AND yr NOT IN(SELECT yr FROM nobel
WHERE subject='Literature')
AND yr NOT IN (SELECT yr FROM nobel
WHERE subject='Peace');

-- 7
Chemistry	1
Literature	1
Medicine	2
Peace	1
Physics	1

-- ========================
-- Nested SELECT Quiz
-- ========================

-- 1
SELECT region, name, population FROM bbc x
WHERE population <= ALL (SELECT population FROM bbc y
WHERE y.region=x.region AND population>0);

-- 2
SELECT name,region,population FROM bbc x
WHERE 50000 < ALL (SELECT population FROM bbc y
WHERE x.region=y.region AND y.population>0);

-- 3
SELECT name, region FROM bbc x
WHERE population < ALL (SELECT population/3 FROM bbc y
WHERE y.region = x.region AND y.name != x.name);

-- 4
Table-D

-- 5
SELECT name FROM bbc
WHERE gdp > (SELECT MAX(gdp) FROM bbc
WHERE region = 'Africa');

-- 6
SELECT name FROM bbc
WHERE population < (SELECT population FROM bbc WHERE name='Russia')
AND population > (SELECT population FROM bbc WHERE name='Denmark');

-- 7
Table-B

-- ========================
-- SUM and COUNT Quiz
-- ========================

-- 1
SELECT SUM(population) FROM bbc WHERE region = 'Europe';

-- 2
SELECT COUNT(name) FROM bbc WHERE population < 150000;

-- 3
AVG(), COUNT(), MAX(), MIN(), SUM()

-- 4
No result due to invalid use of the WHERE function

-- 5
SELECT AVG(population) FROM bbc
WHERE name IN ('Poland', 'Germany', 'Denmark');

-- 6
SELECT region, SUM(population)/SUM(area) AS density
FROM bbc GROUP BY region;

-- 7
SELECT name, population/area AS density
FROM bbc WHERE population = (SELECT MAX(population) FROM bbc);

-- 8
Table-D

-- ========================
-- JOIN Quiz
-- ========================

-- 1
game  JOIN goal ON (id=matchid)

-- 2
matchid, teamid, player, gtime, id, teamname, coach

-- 3
SELECT player, teamid, COUNT(*)
FROM game JOIN goal ON matchid = id
WHERE (team1 = "GRE" OR team2 = "GRE")
AND teamid != 'GRE'
GROUP BY player, teamid;

-- 4
DEN	9 June 2012
GER	9 June 2012

-- 5
SELECT DISTINCT player, teamid
FROM game JOIN goal ON matchid = id
WHERE stadium = 'National Stadium, Warsaw'
AND (team1 = 'POL' OR team2 = 'POL')
AND teamid != 'POL';

-- 6
SELECT DISTINCT player, teamid, gtime
FROM game JOIN goal ON matchid = id
WHERE stadium = 'Stadion Miejski (Wroclaw)'
AND (( teamid = team2 AND team1 != 'ITA')
OR ( teamid = team1 AND team2 != 'ITA'));

-- 7
Netherlands	2
Poland	2
Republic of Ireland	1
Ukraine	2

-- ========================
-- JOIN Quiz 2
-- ========================

-- 1
SELECT name
FROM actor INNER JOIN movie ON actor.id = director
WHERE gross < budget;

-- 2
SELECT *
FROM actor JOIN casting ON actor.id = actorid
JOIN movie ON movie.id = movieid;

-- 3
SELECT name, COUNT(movieid)
FROM casting JOIN actor ON actorid=actor.id
WHERE name LIKE 'John %'
GROUP BY name ORDER BY 2 DESC;

-- 4
"Crocodile" Dundee
Crocodile Dundee in Los Angeles
Flipper
Lightning Jack

-- 5
SELECT name
FROM movie JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE ord = 1 AND director = 351

-- 6
link the director column in movies with the primary key in actor
connect the primary keys of movie and actor via the casting table

-- 7
A Bronx Tale	1993
Bang the Drum Slowly	1973
Limitless	2011

-- ========================
-- Using Null Quiz
-- ========================

-- 1
SELECT teacher.name, dept.name
FROM teacher LEFT OUTER JOIN dept ON (teacher.dept = dept.id);

-- 2
SELECT dept.name
FROM teacher JOIN dept ON (dept.id = teacher.dept)
WHERE teacher.name = 'Cutflower';

-- 3
SELECT dept.name, COUNT(teacher.name)
FROM teacher RIGHT JOIN dept ON dept.id = teacher.dept
GROUP BY dept.name;

-- 4
display 0 in result column for all teachers without department

-- 5
'four' for Throd

-- 6
Shrivell	Computing
Throd	Computing
Splint	Computing
Spiregrain	Other
Cutflower	Other
Deadyawn	Other

-- ========================
-- Self join Quiz
-- ========================

-- 1
SELECT DISTINCT a.name, b.name
FROM stops a JOIN route z ON a.id=z.stop
JOIN route y ON y.num = z.num
JOIN stops b ON y.stop=b.id
WHERE a.name='Craiglockhart' AND b.name ='Haymarket';

-- 2
SELECT S2.id, S2.name, R2.company, R2.num
FROM stops S1, stops S2, route R1, route R2
WHERE S1.name='Haymarket' AND S1.id=R1.stop
AND R1.company=R2.company AND R1.num=R2.num
AND R2.stop=S2.id AND R2.num='2A';

-- 3
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Tollcross';
