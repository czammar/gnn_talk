// LIMPIEZA Y CONFIGURACIÓN INICIAL
MATCH (n) DETACH DELETE n;

CREATE CONSTRAINT FOR (u:User) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT FOR (m:Movie) REQUIRE m.id IS UNIQUE;

// CARGA DE DATOS DESDE ARCHIVOS LOCALES
// Carga de Nodos: Películas desde el volumen local
LOAD CSV WITH HEADERS FROM 'file:///data/movies.csv' AS row
CREATE (m:Movie {
    id: toInteger(row.movieId), 
    title: row.title, 
    genres: split(row.genres, '|')
});

// Carga de Usuarios y Relaciones locales
LOAD CSV WITH HEADERS FROM 'file:///data/ratings.csv' AS row
WITH row LIMIT 10000 // Limitamos a 10k para carga instantánea en la demo
MERGE (u:User {id: toInteger(row.userId)})
WITH u, row
MATCH (m:Movie {id: toInteger(row.movieId)})
CREATE (u)-[:RATED {rating: toFloat(row.rating)}]->(m);

// Example querys
MATCH (u:User)-[r:RATED]->(m:Movie)
WHERE r.rating >= 4.5
RETURN u.id AS Usuario, m.title AS Pelicula, r.rating AS Nota
LIMIT 3;


// show partial graph
MATCH (u:User)-[r:RATED]->(m:Movie)
WHERE u.id IN [3, 10, 2, 5]
RETURN u, r, m
LIMIT 250;

MATCH (m:Movie)
UNWIND m.genres AS genero
RETURN genero, count(m) AS TotalPeliculas
ORDER BY TotalPeliculas DESC LIMIT 5;