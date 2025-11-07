\echo 'Cargando data/telemetry_sample.csv a staging_telemetry'
\copy staging_telemetry("timestamp", tic, x, y, z, angle, momx, momy, momz)
  FROM 'data/telemetry_sample.csv'
  WITH (FORMAT csv, HEADER true);
\echo 'Listo.'