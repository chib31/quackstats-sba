WITH t AS (
  SELECT t.id FROM team t WHERE name = 'Plastics CC'
),

f AS (INSERT INTO fixture VALUES
  (default,(SELECT id FROM t),'2019-07-07',(SELECT id FROM team WHERE LOWER(name) LIKE '%hendricks%'),1,'Battersea Park (Pitch 2)','Limited Overs',40,default,FALSE,TRUE,(SELECT id FROM result_type WHERE name = 'lost'))
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),1,TRUE,240,8,210,6,1,21,5)
, (default,(SELECT id FROM f),2,FALSE,236,8,211,9,1,9,3)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'R Bishop'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Thornhill'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Webster'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'C Bradbury'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Dewhirst'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Sandham'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Doy'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Webb'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Anderson'),null,null)

RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'R Bishop'),1,56,12,1,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Olly H',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Thornhill'),2,8,8,1,0,(SELECT id FROM batting_conclusion WHERE name = 'stumped'),null,'Henry',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),3,54,75,12,2,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Big V',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),4,6,3,0,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Olly H',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),5,34,20,3,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Ravi',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),6,33,24,5,0,(SELECT id FROM batting_conclusion WHERE name = 'lbw'),null,'Ravi',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),7,22,21,2,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Gilbert',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),8,26,10,0,0,(SELECT id FROM batting_conclusion WHERE name = 'not_out'),null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),9,6,4,0,0,(SELECT id FROM batting_conclusion WHERE name = 'run_out'),null,null,null)


),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),1,30,1,24,0,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),2,44,1,43,1,0,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Thornhill'),3,12,0,15,0,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),4,24,0,14,0,4,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),5,48,2,28,3,3,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),6,48,1,38,1,2,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'R Bishop'),7,6,0,10,0,0,2,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),8,24,0,29,2,0,0,0)



),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM batting_conclusion WHERE name = 'run_out'),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),null,1,24)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),2,54)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),3,1)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),4,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'R Bishop'),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),5,53)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),6,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),7,6)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'stumped'),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),8,18)



)
SELECT 'complete';