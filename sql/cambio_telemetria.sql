BEGIN;

WITH
m AS (SELECT map_id FROM map_ ORDER BY map_id LIMIT 1),
p1 AS (SELECT player_id FROM player WHERE alias='player01' LIMIT 1),
p2 AS (SELECT player_id FROM player WHERE alias='player02' LIMIT 1),
g1 AS (SELECT game_id FROM game WHERE notes ~* 'Sesion 1|Sesión 1' LIMIT 1),
g2 AS (SELECT game_id FROM game WHERE notes ~* 'Sesion 2|Sesión 2' LIMIT 1),
g3 AS (SELECT game_id FROM game WHERE notes ~* 'Sesion 3|Sesión 3' LIMIT 1)

DELETE FROM telemetry_event WHERE game_id IN ((SELECT game_id FROM g1),(SELECT game_id FROM g2),(SELECT game_id FROM g3));

INSERT INTO telemetry_event(
  game_id, player_id, tic,
  pos_x, pos_y, pos_z,
  facing_x, facing_y, facing_z,
  health, armor, ammo,
  map_id, sector_id, raw_line, created_at
)
SELECT
  (SELECT game_id FROM g1),
  (SELECT player_id FROM p1),
  s.tic::bigint,
  s.x::float8, s.y::float8, s.z::float8,
  COS(RADIANS(s.angle))::float8,
  SIN(RADIANS(s.angle))::float8,
  0::float8,
  NULL, NULL, NULL,
  (SELECT map_id FROM m), NULL, NULL, s."timestamp"
FROM staging_telemetry s;

INSERT INTO telemetry_event(
  game_id, player_id, tic, pos_x, pos_y, pos_z,
  facing_x, facing_y, facing_z, health, armor, ammo,
  map_id, sector_id, raw_line, created_at
)
SELECT
  (SELECT game_id FROM g2),
  (SELECT player_id FROM p2),
  s.tic::bigint,
  s.x, s.y, s.z,
  COS(RADIANS(s.angle)), SIN(RADIANS(s.angle)), 0,
  NULL, NULL, NULL,
  (SELECT map_id FROM m), NULL, NULL, s."timestamp" + interval '1 day'
FROM staging_telemetry s;

INSERT INTO telemetry_event(
  game_id, player_id, tic, pos_x, pos_y, pos_z,
  facing_x, facing_y, facing_z, health, armor, ammo,
  map_id, sector_id, raw_line, created_at
)
SELECT
  (SELECT game_id FROM g3),
  (SELECT player_id FROM p2),
  s.tic::bigint,
  s.x, s.y, s.z,
  COS(RADIANS(s.angle)), SIN(RADIANS(s.angle)), 0,
  NULL, NULL, NULL,
  (SELECT map_id FROM m), NULL, NULL, s."timestamp" + interval '2 day'
FROM staging_telemetry s;

COMMIT;