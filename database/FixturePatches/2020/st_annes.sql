WITH t AS (SELECT t.id FROM team t WHERE name = 'Plastics CC'),
f AS (INSERT INTO fixture VALUES
  (default,(SELECT id FROM t),'2020-07-26',(SELECT id FROM team WHERE LOWER(name) LIKE '%st anne%'),1,'Barnes Common Cricket Ground','Limited Overs',35,default,FALSE,TRUE,(SELECT id FROM result_type WHERE name = 'won'))
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),2,TRUE,186,10,126,2,5,13,3)
, (default,(SELECT id FROM f),1,FALSE,210,9,111,5,1,10,9)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Jamieson'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'R Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'C Bradbury'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'L Killen'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Dewhirst'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Winter'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Sandham'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Webb'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'Saril'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Oliver'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'R Bishop'),1,41,20,2,0,(SELECT id FROM batting_conclusion WHERE name = 'lbw'),null,'Scott',null)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),2,11,2,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Sama',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),3,43,30,4,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Scott',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'L Killen'),4,22,14,2,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Beagle',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),5,17,15,3,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Sama',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Winter'),6,4,1,0,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Grant',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),7,21,14,3,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Sama',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),8,16,3,0,0,(SELECT id FROM batting_conclusion WHERE name = 'stumped'),null,'Grant',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),9,12,3,0,0,(SELECT id FROM batting_conclusion WHERE name = 'not_out'),null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),10,1,0,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Seth',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Oliver'),11,7,1,0,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Seth',null)
),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),1,42,1,15,2,3,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),2,42,0,35,0,1,3,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),3,42,1,9,2,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),4,42,2,13,1,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),5,18,0,6,2,3,3,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),6,18,0,18,1,1,2,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),7,6,0,3,0,1,0,0)




),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),1,7)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),2,10)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'Saril'),3,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'P Oliver'),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),4,30)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'L Killen'),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),5,1)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'P Oliver'),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),6,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'run_out'),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),null,7,3)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'P Oliver'),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),8,17)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),9,16)


)
SELECT 'complete';