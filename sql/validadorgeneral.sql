SELECT COUNT(*) AS staging_rows FROM staging_telemetry;

SELECT COUNT(*) AS total_eventos FROM telemetry_event;

SELECT g.notes, COUNT(t.*) AS eventos
FROM game g
LEFT JOIN telemetry_event t ON t.game_id = g.game_id
GROUP BY g.notes
ORDER BY g.notes;

SELECT MIN(created_at) AS min_ts, MAX(created_at) AS max_ts FROM telemetry_event;