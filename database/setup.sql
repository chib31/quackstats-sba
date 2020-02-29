-----------------------------------------------
---- Drop everything  -------------------------
-----------------------------------------------
-- Drop tables
DROP TABLE IF EXISTS wicket CASCADE
;

DROP TABLE IF EXISTS player_bowling_innings CASCADE
;

DROP TABLE IF EXISTS player_batting_innings CASCADE
;

DROP TABLE IF EXISTS innings CASCADE
;

DROP TABLE IF EXISTS squad_member CASCADE
;

DROP TABLE IF EXISTS fixture CASCADE
;

DROP TABLE IF EXISTS player CASCADE
;

DROP TABLE IF EXISTS team CASCADE
;

DROP TABLE IF EXISTS batting_conclusion CASCADE
;

DROP TABLE IF EXISTS result_type CASCADE
;

DROP TRIGGER IF EXISTS trg_check_valid_wicket ON wicket
;

DROP FUNCTION IF EXISTS check_valid_wicket
;

-----------------------------------------------
---- Create everything  -----------------------
-----------------------------------------------
-- Create all tables
CREATE TABLE result_type (id SERIAL PRIMARY KEY, name VARCHAR(30), label VARCHAR(30))
;

CREATE TABLE batting_conclusion (
  id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  label VARCHAR(30) NOT NULL,
  wickets INT CHECK (wickets BETWEEN 0 AND 1),
  not_outs INT CHECK (not_outs BETWEEN 0 AND 1),
  bowler_involved BOOLEAN,
  fielder_involved BOOLEAN)
;

CREATE TABLE team (id SERIAL PRIMARY KEY, name VARCHAR(100) UNIQUE)
;

CREATE TABLE player (
  id SERIAL PRIMARY KEY,
  team_id INT NOT NULL REFERENCES team (id),
  first_name VARCHAR NOT NULL,
  middle_names VARCHAR,
  last_name VARCHAR,
  preferred_name VARCHAR,
  scorecard_name VARCHAR UNIQUE NOT NULL,
  cap_number INT UNIQUE,
  date_of_membership DATE,
  shirt_number INT)
;

CREATE TABLE fixture (
  id SERIAL PRIMARY KEY,
  team_id INT NOT NULL REFERENCES team (id),
  date DATE NOT NULL,
  opposition_id INT NOT NULL REFERENCES team (id),
  fixture_order INT DEFAULT 1 NOT NULL,
  location VARCHAR(100),
  match_format VARCHAR(20) NOT NULL,
  innings_length INT,
  over_length INT DEFAULT 6,
  win_toss BOOLEAN,
  bat_first BOOLEAN NOT NULL,
  result_type_id INT NOT NULL REFERENCES result_type (id),
  UNIQUE (date, fixture_order, team_id))
;

CREATE TABLE squad_member (
  id SERIAL PRIMARY KEY,
  fixture_id INT NOT NULL REFERENCES fixture (id),
  player_id INT NOT NULL REFERENCES player (id),
  captain BOOLEAN,
  keeper BOOLEAN,
  UNIQUE (fixture_id, player_id),
  UNIQUE (fixture_id, captain),
  UNIQUE (fixture_id, keeper))
;

CREATE TABLE innings (
  id SERIAL PRIMARY KEY,
  fixture_id INT NOT NULL REFERENCES fixture (id),
  innings_order INT NOT NULL,
  team_batting BOOLEAN NOT NULL,
  deliveries INT,
  wickets INT,
  runs INT,
  byes INT,
  leg_byes INT,
  wides INT,
  no_balls INT,
  UNIQUE (fixture_id, innings_order))
;

CREATE TABLE player_batting_innings (
  id SERIAL PRIMARY KEY,
  innings_id INT NOT NULL REFERENCES innings (id),
  squad_member_id INT NOT NULL REFERENCES squad_member (id),
  position INT NOT NULL,
  deliveries INT,
  runs INT NOT NULL,
  fours INT,
  sixes INT,
  batting_conclusion_id INT NOT NULL REFERENCES batting_conclusion (id),
  wicket_fielder VARCHAR(30),
  wicket_bowler VARCHAR(30),
  where_caught VARCHAR(100),
  UNIQUE (innings_id, position))
;

CREATE TABLE player_bowling_innings (
  id SERIAL PRIMARY KEY,
  innings_id INT NOT NULL REFERENCES innings (id),
  squad_member_id INT NOT NULL REFERENCES squad_member (id),
  bowler_number INT NOT NULL,
  deliveries INT,
  maidens INT,
  runs INT,
  wickets INT,
  wides INT,
  no_balls INT,
  hat_tricks INT,
  UNIQUE (innings_id, bowler_number),
  UNIQUE (innings_id, squad_member_id))
;

CREATE TABLE wicket (
  id SERIAL PRIMARY KEY,
  innings_id INT NOT NULL REFERENCES innings (id),
  batting_conclusion_id INT NOT NULL REFERENCES batting_conclusion (id),
  fielder_id INT REFERENCES squad_member (id),
  bowler_id INT REFERENCES squad_member (id),
  batting_position INT,
  batter_runs INT,
  UNIQUE (innings_id, batting_position))
;

-- Function to check if a wicket has a fielder/bowler for incompatible wicket type
CREATE OR REPLACE FUNCTION check_valid_wicket() RETURNS TRIGGER LANGUAGE plpgsql AS
  $$
  BEGIN
    IF (
      SELECT
        COUNT(*)
      FROM batting_conclusion bc
      JOIN wicket w ON bc.id = w.batting_conclusion_id
      WHERE w.id = NEW.id
      AND (
        (w.bowler_id IS NOT NULL AND bc.bowler_involved IS FALSE)
      OR
        (w.fielder_id IS NOT NULL AND bc.fielder_involved IS FALSE)
      )
    ) > 0
    THEN
      RAISE EXCEPTION 'invalid wicket entered';
    END IF;
  RETURN OLD;
  END;
  $$;

-- Trigger to call above function
CREATE CONSTRAINT TRIGGER trg_check_valid_wicket
  AFTER INSERT OR UPDATE ON wicket
  FOR EACH ROW EXECUTE PROCEDURE check_valid_wicket();