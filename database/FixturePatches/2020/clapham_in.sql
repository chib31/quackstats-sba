WITH t AS (SELECT t.id FROM team t WHERE name = 'Plastics CC'),
f AS (INSERT INTO fixture VALUES
  (default,(SELECT id FROM t),'2020-07-11',(SELECT id FROM team WHERE LOWER(name) LIKE '%clapham in%'),1,'Barn Elms Sports Trust','Limited Overs',40,default,FALSE,TRUE,(SELECT id FROM result_type WHERE name = 'lost'))
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),2,TRUE,240,8,204,2,3,2,1)
, (default,(SELECT id FROM f),1,FALSE,191,4,205,4,1,18,2)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Jamieson'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'R Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'L Killen'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Oliver'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Webster'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Dewhirst'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Webb'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Dogar'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Sandham'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'C Bradbury'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'R Bishop'),1,17,9,2,0,(SELECT id FROM batting_conclusion WHERE name = 'run_out'),null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),2,4,0,0,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Hassan',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),3,38,29,5,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Hewens',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'L Killen'),4,24,6,1,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Hewens',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Oliver'),5,1,0,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Hewens',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),6,74,85,12,2,(SELECT id FROM batting_conclusion WHERE name = 'not_out'),null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),7,9,15,3,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Goodman',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),8,6,8,2,0,(SELECT id FROM batting_conclusion WHERE name = 'lbw'),null,'Goodman',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),9,30,14,2,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Ferrera',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Dogar'),10,18,22,3,0,(SELECT id FROM batting_conclusion WHERE name = 'not_out'),null,null,null)

),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),1,41,1,41,1,4,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Dogar'),2,42,0,42,0,5,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),3,42,0,45,2,3,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),4,42,0,49,1,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),5,18,0,19,0,6,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),6,6,0,6,0,0,0,0)





),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'P Oliver'),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),1,71)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM batting_conclusion WHERE name = 'lbw'),null,(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),2,16)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'A Dogar'),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),3,52)

, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),5,2)






)
SELECT 'complete';