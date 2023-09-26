
SELECT * FROM movies
WHERE year = 2005;

SELECT COUNT(*) FROM movies
WHERE year = 1982;

SELECT * FROM actors
where last_name LIKE '%stack%';


SELECT COUNT(*), first_name FROM actors 
GROUP BY first_name
ORDER BY COUNT(*) DESC
LIMIT 10;

SELECT COUNT(*), last_name FROM actors 
GROUP BY last_name
ORDER BY COUNT(*) DESC
LIMIT 10;

SELECT COUNT(*), first_name || " " || last_name as full_name FROM actors 
GROUP BY full_name
ORDER BY COUNT(*) DESC
LIMIT 10;

SELECT first_name, last_name, COUNT(*) FROM roles
JOIN actors
ON roles.actor_id = id
GROUP BY first_name || " " || last_name
ORDER BY COUNT(*) DESC
LIMIT 100;

SELECT genre, COUNT(*) FROM movies_genres
JOIN movies
ON movie_id = id
GROUP BY genre 
ORDER BY COUNT(*) DESC;

SELECT * FROM movies
WHERE name = 'Braveheart';

select * from roles
where movie_id = 46169;

SELECT first_name, last_name
FROM actors
JOIN roles on actor_id =


SELECT first_name, last_name from roles
JOIN actors
ON roles.actor_id = actors.id
JOIN movies
ON roles.movie_id = movies.id
where name = "Braveheart" AND year = 1995
ORDER BY last_name ASC;

SELECT * FROM movies_genres
where genre = 'Film-Noir'

SELECT first_name, last_name, name, year FROM movies_directors
JOIN directors 
ON movies_directors.director_id = directors.id
JOIN movies
on movies_directors.movie_id = movies.id
JOIN movies_genres
ON movies.id = movies_genres.movie_id
WHERE movies.year % 4 = 0 AND genre = "Film-Noir";

SELECT movies.name, first_name, last_name
FROM roles
join actors 
ON roles.actor_id = actors.id
join movies
ON roles.movie_id = movies.id
join movies_genres 
ON movies.id = movies_genres.movie_id


WHERE roles.movie_id IN (SELECT movie_id FROM roles WHERE actor_id = ( SELECT id FROM actors WHERE first_name = 'Kevin' AND last_name = 'Bacon'))

AND roles.movie_id IN (SELECT movie_id FROM movies_genres WHERE genre = 'Drama')
AND(first_name != 'Kevin' AND last_name != 'Bacon') LIMIT 10;

SELECT first_name, last_name, actor_id
FROM roles
JOIN actors
ON roles.actor_id = actors.id
WHERE actor_id IN (SELECT actor_id FROM roles WHERE movie_id IN (SELECT id FROM movies WHERE year<1900))AND movie_id IN(SELECT id FROM movies WHERE year>2000)
GROUP BY first_name, last_name
ORDER BY last_name;

SELECT first_name, last_name, movies.name, movies.year, COUNT(distinct roles.role)
FROM actors 
JOIN roles
ON actors.id = roles.actor_id 
JOIN movies
ON movies.id = roles.movie_id
WHERE movies.year > 1990
GROUP BY roles.actor_id, movie_id
HAVING COUNT(distinct roles.role) >= 5
LIMIT 10;

SELECT movies.year, COUNT(DISTINCT movie_id)
FROM actors 
JOIN roles
ON actors.id = roles.actor_id 
JOIN movies
ON movies.id = roles.movie_id
WHERE movies.id NOT IN (
  SELECT movie_id
  FROM roles 
  JOIN actors
  on roles.actor_id = actors.id
  WHERE actors.gender = 'M'
)
GROUP BY movies.year;
