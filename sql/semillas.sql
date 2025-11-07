INSERT INTO episode(episode_id, name, description)
VALUES ('ep-01','DOOM II','Default episode') ON CONFLICT DO NOTHING;

INSERT INTO map_(map_id, episode_id, code, name)
VALUES ('map-01','ep-01','MAP01','Entryway') ON CONFLICT DO NOTHING;

INSERT INTO user_account(user_id, created_at, consent, age, gender, experience_level)
VALUES
('u-01', now(), true, 21, 'N/A', 'beginner'),
('u-02', now(), true, 22, 'N/A', 'intermediate')
ON CONFLICT DO NOTHING;

INSERT INTO player(player_id, user_id, alias, created_at)
VALUES
('p-01','u-01','player01', now()),
('p-02','u-02','player02', now())
ON CONFLICT DO NOTHING;

INSERT INTO game(game_id, episode_id, started_at, ended_at, engine_version, notes)
VALUES
('g-01','ep-01', now(), now()+interval '15 min','chocolate-doom','Sesión 1 (real)'),
('g-02','ep-01', now()+interval '1 day', now()+interval '1 day 15 min','chocolate-doom','Sesión 2 (+1d)'),
('g-03','ep-01', now()+interval '2 day', now()+interval '2 day 15 min','chocolate-doom','Sesión 3 (+2d)')
ON CONFLICT DO NOTHING;

INSERT INTO game_participant(participant_id, game_id, player_id, team, joined_at, left_at)
VALUES
('gp-01','g-01','p-01', 1, now(), now()+interval '15 min'),
('gp-02','g-02','p-02', 1, now()+interval '1 day', now()+interval '1 day 15 min'),
('gp-03','g-03','p-02', 1, now()+interval '2 day', now()+interval '2 day 15 min')
ON CONFLICT DO NOTHING;