# Proyecto 2
Este repositorio contiene el código utilizado para el proyecto 2 del curso **Base de Datos I**.

Se incluyen los scripts para la inicialización de la base de datos en **PostgreSQL** dentro de `/database/`, así como el programa para realizar simulaciones de concurrencia dentro de `/simulation/`.

## Manual de ejecución
Para una mayor portabilidad, la ejecución del programa se realiza a través de contenedores con **Docker**. La base de datos se encuentra en un contenedor, mientras que la simulación se ejecuta en uno diferente que utiliza una imagen de Debian. La ejecución de ambos contenedores se lleva a cabo con **Docker Compose**.

Instrucciones:
1. **Clonar** el repositorio.
```bash
git clone https://github.com/JuanDsm04/project_2_db.git
cd project_2_db
```
2. **Levantar** los contenedores y obtener el output.
```bash
docker-compose up --build
```
3. **Detener** los contenedores y eliminar los volúmenes.
```bash
docker-compose down -v
```
4. **Modificar** los parámetros de la simulación en `/simulation/main.cpp`.
```cpp
const int users = 30; // Para simular diferente cantidad de usuarios simultáneos
const int event_id = 1; // No modificar
const std::string isolation = "READ COMMITTED"; // Para simular diferentes niveles de aislamiento
const std::string conninfo = "host=db port=5432 dbname=sim user=postgres password=postgres"; // No modificar
```
5. **Repetir** pasos 2 y 3.
