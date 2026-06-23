# GNN Talk

Proyecto del HUB de Probabilidad y Estadìstica de BBVA para el tema de Graph Neural Networks (GNNs) utilizando PyTorch Geometric, Neo4j y Jupyter Notebooks.

El repositorio contiene ejemplos progresivos que cubren:

* Introducción a PyTorch Geometric
* Exploración de datasets de grafos
* Shallow Node Embeddings
* GraphSAGE
* Consultas sobre grafos utilizando Neo4j

## Requisitos

Antes de comenzar, asegúrate de tener instalado:

* Git
* Docker y Docker Compose
* Python 3.11 o superior

No es necesario instalar manualmente las dependencias de Python. El proyecto utiliza UV para gestionar el entorno virtual y los paquetes.

---

# Estructura del proyecto

```text
.
├── data/
│   ├── chameleon/                  # Dataset Chameleon
│   ├── cora/                       # Dataset Cora
│   ├── movies.csv                  # Datos para Neo4j
│   └── ratings.csv                 # Datos para Neo4j
│
├── docker-compose.yml              # Servicios Docker
├── init-db.cypher                  # Inicialización de Neo4j
│
├── images/
│   ├── CoraBalloons.png
│   └── shallow_node_embeddings.png
│
├── notebooks/
│   ├── 00_first_example.ipynb
│   ├── 01_intro_pygc.ipynb
│   ├── 02_shallow_embeddings.ipynb
│   └── 03_sageconv.ipynb
│
├── src/
│   └── queries/
│       └── imdb.cypher
│
├── main.py
├── Makefile
├── pyproject.toml
├── uv.lock
├── LICENSE
└── README.md
```

---

# Instalación

La instalación completa se realiza mediante Make.

## Instalar UV y sincronizar dependencias

```bash
make
```

Este comando ejecuta:

```bash
make install
make sync
```

y realiza:

1. Instalación de UV (si no existe).
2. Creación del entorno virtual.
3. Instalación de todas las dependencias definidas en `pyproject.toml`.
4. Generación del entorno reproducible utilizando `uv.lock`.

---

# Comandos disponibles

Consultar todos los comandos:

```bash
make help
```

Salida esperada:

```text
make help
make install
make sync
make clean
make up
make down
```

## Instalar UV

```bash
make install
```

Verifica si UV está disponible y lo instala automáticamente cuando sea necesario.

---

## Sincronizar dependencias

```bash
make sync
```

Ejecuta:

```bash
uv sync
```

Este comando:

* Crea el entorno virtual `.venv`
* Instala dependencias
* Sincroniza versiones utilizando `uv.lock`

---

## Limpiar entorno virtual

```bash
make clean
```

Elimina completamente:

```text
.venv/
```

Útil para reconstruir el entorno desde cero.

---

## Levantar Neo4j

```bash
make up
```

Ejecuta:

```bash
docker compose up -d
```

Esto inicia los servicios definidos en `docker-compose.yml`.

---

## Detener Neo4j

```bash
make down
```

Ejecuta:

```bash
docker compose down
```

Detiene y elimina los contenedores asociados al proyecto.

---

# Flujo recomendado

## 1. Instalar dependencias

```bash
make
```

## 2. Levantar Neo4j

```bash
make up
```

## 3. Activar entorno virtual

```bash
source .venv/bin/activate
```

## 4. Ejecutar Jupyter

```bash
jupyter notebook
```

o

```bash
jupyter lab
```

---

# Notebooks

## 00_first_example.ipynb

Introducción a PyTorch Geometric:

* Representación de grafos
* Nodos y aristas
* Objetos `Data`

## 01_intro_pygc.ipynb

Exploración de datasets:

* Cora
* Chameleon
* Estadísticas básicas

## 02_shallow_embeddings.ipynb

Embeddings de nodos:

* Representaciones vectoriales
* Visualización de embeddings
* Reducción de dimensionalidad

## 03_sageconv.ipynb

GraphSAGE:

* Message Passing
* Neighbor Sampling
* Clasificación de nodos

---

# Datasets

## Cora

Dataset clásico para clasificación de nodos basado en publicaciones científicas y relaciones de citación.

## Chameleon

Dataset heterofílico utilizado para evaluar el comportamiento de Graph Neural Networks en escenarios más complejos.

---

# Neo4j

El proyecto incluye ejemplos para explorar grafos mediante Cypher.

Archivos relevantes:

```text
init-db.cypher
src/queries/imdb.cypher
```

Los datos de ejemplo se encuentran en:

```text
data/movies.csv
data/ratings.csv
```

---

# Desarrollo

Si se agregan nuevas dependencias al proyecto:

```bash
uv add <package>
```

Posteriormente:

```bash
make sync
```

para actualizar el entorno local.

---

# Licencia

Consulta el archivo `LICENSE` para obtener los términos de uso del proyecto.
