# DOOM project.


## Estructura
- `sql/01_MODELODOOM.sql`: modelo relacional.
- `sql/02_staging.sql`: staging de telemetría.
- `sql/04_semillas.sql`: semillas mínimas de entrada.
- `sql/05_cargar_muestra.psql`: Cargar muestra de la base de datos.
- `sql/06_cambio_telemetria.sql`:inserta en la telemetría de eventos.
- `sql/03_validadorgeneral.sql`: consultas de verificación.
- `data/telemetry_sample.csv`: muestra 1600 datos.

## Pasos para arrancar

```bash
# 1) Crear la base de datos
createdb doomdb2

# 2) incluir el esquema general
psql -d doomdb2 -f sql/01_MODELODOOM.sql

# 3) Incluir el staging
psql -d doomdb2 -f sql/02_staging.sql

# 4) Incluir las semillas minimas
psql -d doomdb2 -f sql/04_semillas.sql

# 5) Cargar la muestra
psql -d doomdb2 -f sql/05_cargar_muestra.psql

# 6) Migrar al cambio de telemetria
psql -d doomdb2 -f sql/06_cambio_telemetria.sql

# 7) realizar el validador general
psql -d doomdb2 -f sql/03_validadorgeneral.sql
