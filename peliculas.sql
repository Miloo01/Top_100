-- ingresar a psql--

--Crear base de datos llamada películas-- 
CREATE DATABASE peliculas;

-- ir a DB peliculas \c peliculas--

--evisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes,determinando la relación entre ambas tablas
CREATE TABLE peliculas(id SERIAL PRIMARY KEY, pelicula VARCHAR(100), año_estreno INT, director VARCHAR(50));  
CREATE TABLE reparto(id_peliculas INT, nombre  VARCHAR(100), FOREiGN KEY(id_peliculas) REFERENCES peliculas(id));

--Cargar ambos archivos a su tabla correspondiente 
\COPY peliculas FROM '/home/camilo/Escritorio/Top_100/Apoyo Desafío 2 -  Top 100/peliculas.csv' csv header;
\COPY reparto FROM '/home/camilo/Escritorio/Top_100/Apoyo Desafío 2 -  Top 100/reparto.csv' csv;

--Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,año de estreno, director y todo el reparto.
SELECT peliculas.pelicula,año_estreno,director,reparto.nombre FROM peliculas INNER JOIN reparto ON id_peliculas=peliculas.id WHERE pelicula='Titanic';

--Listar los titulos de las películas donde actúe Harrison Ford.--
SELECT peliculas.pelicula FROM peliculas INNER JOIN reparto ON reparto.id_peliculas=peliculas.id WHERE nombre='Harrison Ford';

--Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en eltop 100.--
SELECT count(director), peliculas.director FROM peliculas GROUP BY(director) ORDER BY(count(director)) DESC LIMIT(10);
SELECT peliculas.director,count(director) AS numero_peliculas FROM peliculas GROUP BY(director) ORDER BY(count(director)) DESC LIMIT(10);

--Indicar cuantos actores distintos hay --
SELECT count(actores) FROM (SELECT nombre FROM reparto GROUP BY(nombre)) AS actores;

--Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas portítulo de manera ascendente.-
SELECT pelicula FROM peliculas WHERE año_estreno >= 1990 AND año_estreno <= 1999 ORDER BY(pelicula);

--Listar el reparto de las películas lanzadas el año 2001--
SELECT pelicula FROM peliculas WHERE año_estreno= 2001;

--Listar los actores de la película más nueva --
SELECT nombre FROM reparto INNER JOIN peliculas ON peliculas.id=reparto.id_peliculas WHERE año_estreno= ( SELECT MAX(año_estreno) FROM peliculas);

