-- Drop all views
DROP VIEW IF EXISTS player_fielding_summary
;

DROP VIEW IF EXISTS wicket_summary
;

DROP VIEW IF EXISTS player_bowling_summary
;

DROP VIEW IF EXISTS player_batting_summary
;

DROP VIEW IF EXISTS innings_summary
;

DROP VIEW IF EXISTS fixture_summary
;

DROP VIEW IF EXISTS player_summary
;

CREATE OR REPLACE VIEW player_summary AS
  SELECT
    p.id
  , t.id team_id
  , p.scorecard_name player_name
  , p.cap_number
  , p.shirt_number
  FROM player p
  JOIN team t ON p.team_id = t.id
;

CREATE OR REPLACE VIEW fixture_summary AS
  SELECT
    f.id
  , t.id team_id
  , f.date
  , o.name opposition
  , f.location
  , f.match_format
  , f.innings_length
  , p.scorecard_name captain
  , f.win_toss won_coin_toss
  , f.bat_first bat_first
  , bati.runs || ' - ' || bati.wickets team_score
  , bowli.runs || ' - ' || bowli.wickets opposition_score
  , rt.label result
  , CASE
      WHEN rt.name = 'won'
        THEN CASE
               WHEN f.bat_first
                 THEN 'Won by ' || (bati.runs - bowli.runs) || ' run(s)'
               ELSE 'Won by ' || (10 - bati.wickets) || ' wicket(s)'
             END
      WHEN rt.name = 'lost'
        THEN CASE
               WHEN f.bat_first
                 THEN 'Lost by ' || (10 - bowli.wickets) || ' wicket(s)'
               ELSE 'Lost by ' || (bowli.runs - bati.runs) || ' run(s)'
             END
      WHEN rt.name = 'tied'
        THEN 'Match tied'
      WHEN rt.name = 'drawn'
        THEN 'Match drawn'
      ELSE 'No result'
    END result_details
  , f.over_length
  , date_part('year', f.date) season
  , o.name || ' (' || TO_CHAR(f.date, 'dth-Mon-yy') || ', ' || f.innings_length || ' overs)' fixture
  FROM fixture f
  JOIN team o ON f.opposition_id = o.id
  JOIN team t ON f.team_id = t.id
  JOIN squad_member sm ON (sm.fixture_id = f.id AND sm.captain IS TRUE)
  JOIN player p ON p.id = sm.player_id
  JOIN innings bati ON (bati.fixture_id = f.id AND bati.team_batting IS TRUE)
  JOIN result_type rt ON f.result_type_id = rt.id
  JOIN innings bowli ON (bowli.fixture_id = f.id AND bowli.team_batting IS FALSE)
;

CREATE OR REPLACE VIEW innings_summary AS
  SELECT
    i.id
  , t.id team_id
  , f.date
  , i.innings_order
  , CASE WHEN i.team_batting IS TRUE THEN t.name ELSE o.name END batting_team
  , CASE WHEN i.team_batting IS FALSE THEN t.name ELSE o.name END bowling_team
  , i.deliveries
  , i.wickets
  , i.runs
  , i.byes
  , i.leg_byes
  , i.wides
  , i.no_balls
  , COALESCE(i.byes, 0) + COALESCE(i.leg_byes, 0) + COALESCE(i.wides, 0) + COALESCE(i.no_balls, 0) total_extras
  , ROUND(i.runs::DECIMAL / (i.deliveries::DECIMAL / 6), 2) run_rate
  FROM innings i
  JOIN fixture f ON i.fixture_id = f.id
  JOIN team o ON f.opposition_id = o.id
  JOIN team t ON f.team_id = t.id
;

CREATE OR REPLACE VIEW player_batting_summary AS
  SELECT
    pbi.id
  , fs.team_id
  , ps.player_name
  , fs.opposition
  , fs.date
  , pbi.position
  , pbi.runs
  , pbi.deliveries
  , pbi.fours
  , pbi.sixes
  , bc.wickets wickets_batting
  , bc.not_outs not_outs
  , bc.label wicket_type
  , i.runs team_total
  , fs.result
  , fs.match_format
  , fs.over_length
  , fs.season::TEXT season
  , 1 innings
  , fs.fixture
  , (pbi.runs::DECIMAL / NULLIF(pbi.deliveries::DECIMAL, 0)) * 100 strike_rate_bat
  , (pbi.runs::DECIMAL / NULLIF(i.runs::DECIMAL, 0)) * 100 percent_total
  FROM player_batting_innings pbi
  JOIN squad_member sm ON pbi.squad_member_id = sm.id
  JOIN player_summary ps ON sm.player_id = ps.id
  JOIN innings i ON pbi.innings_id = i.id
  JOIN fixture_summary fs ON i.fixture_id = fs.id
  JOIN batting_conclusion bc ON pbi.batting_conclusion_id = bc.id
;

CREATE OR REPLACE VIEW player_bowling_summary AS
  SELECT
    pbi.id
  , fs.team_id
  , ps.player_name
  , fs.opposition
  , fs.date
  , pbi.bowler_number
  , pbi.deliveries
  , pbi.maidens
  , pbi.runs
  , pbi.wickets wickets_bowling
  , pbi.wides
  , pbi.no_balls
  , pbi.hat_tricks
  , fs.result
  , fs.match_format
  , fs.over_length
  , fs.season::TEXT season
  , 1 innings
  , fs.fixture
  , TRUNC(pbi.deliveries::decimal / 6) + (0.1 * MOD(pbi.deliveries::decimal, 6)) overs
  , pbi.runs::decimal / NULLIF(pbi.wickets::decimal, 0) average_bowl
  , pbi.runs::decimal / (NULLIF(pbi.deliveries::decimal, 0) / 6) economy
  , pbi.deliveries::decimal / NULLIF(pbi.wickets::decimal, 0) strike_rate_bowl
  , pbi.deliveries::decimal / NULLIF(pbi.wides::decimal, 0) deliveries_per_wide
  , pbi.deliveries::decimal / NULLIF(pbi.no_balls::decimal, 0) deliveries_per_no_ball
  FROM player_bowling_innings pbi
  JOIN squad_member sm ON pbi.squad_member_id = sm.id
  JOIN player_summary ps ON sm.player_id = ps.id
  JOIN innings i ON pbi.innings_id = i.id
  JOIN fixture_summary fs ON i.fixture_id = fs.id
;

CREATE OR REPLACE VIEW wicket_summary AS
  SELECT
    w.id
  , fs.team_id
  , fs.date
  , fs.opposition
  , bc.label
  , pb.scorecard_name bowler
  , pf.scorecard_name fielder
  , w.batting_position
  , w.batter_runs
  FROM wicket w
  JOIN innings i ON w.innings_id = i.id
  JOIN fixture_summary fs ON i.fixture_id = fs.id
  JOIN batting_conclusion bc ON w.batting_conclusion_id = bc.id
  LEFT JOIN squad_member smb ON w.bowler_id = smb.id
  LEFT JOIN squad_member smf ON w.fielder_id = smf.id
  LEFT JOIN player pb ON smb.player_id = pb.id
  LEFT JOIN player pf ON smf.player_id = pf.id
;

CREATE OR REPLACE VIEW player_fielding_summary AS
  (
  WITH
    fw AS (
      SELECT
        sm.id sm_id
      , COUNT(*) FILTER (WHERE bc.name = 'caught') catches
      , COUNT(*) FILTER (WHERE bc.name = 'run_out') run_outs
      , COUNT(*) FILTER (WHERE bc.name = 'stumped') stumpings
      FROM squad_member sm
      JOIN player_summary ps ON sm.player_id = ps.id
      JOIN wicket w ON sm.id = w.fielder_id
      JOIN batting_conclusion bc ON w.batting_conclusion_id = bc.id
      GROUP BY
        sm.id
    )
  SELECT
    sm.id
  , fs.team_id
  , ps.player_name
  , fs.opposition
  , COALESCE(fw.catches, 0) catches
  , COALESCE(fw.run_outs, 0) run_outs
  , COALESCE(fw.stumpings, 0) stumpings
  , COALESCE(fw.catches, 0) + COALESCE(fw.run_outs, 0) + COALESCE(fw.stumpings, 0) fielding_wickets
  , fs.date
  , fs.season::TEXT season
  , fs.result
  , fs.match_format
  , 1 fielding_matches
  , fs.fixture
  FROM squad_member sm
  LEFT JOIN fw ON sm.id = fw.sm_id
  JOIN player_summary ps ON sm.player_id = ps.id
  JOIN fixture_summary fs ON sm.fixture_id = fs.id )
;