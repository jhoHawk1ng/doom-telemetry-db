DROP TABLE IF EXISTS staging_telemetry;
CREATE TABLE staging_telemetry (
  "timestamp"  timestamp,
  tic          int,
  x            int,
  y            int,
  z            int,
  angle        numeric(8,2),
  momx         int,
  momy         int,
  momz         int
);