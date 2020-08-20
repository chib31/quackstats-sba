WITH t AS (SELECT t.id FROM team t WHERE name = 'Plastics CC'),
f AS (INSERT INTO fixture VALUES
  (default,(SELECT id FROM t),'2020-08-01',(SELECT id FROM team WHERE LOWER(name) LIKE '%prince%'),1,'Richmond Green','Limited Overs',35,default,FALSE,FALSE,(SELECT id FROM result_type WHERE name = 'lost'))
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),2,TRUE,179,10,151,12,4,4,4)
, (default,(SELECT id FROM f),1,FALSE,210,8,165,8,null,11,14)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Oliver'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Webster'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'R Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Dewhirst'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Webb'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Byrne'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Sandham'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Doy'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Dogar'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Winter'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Oliver'),1,7,2,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Jamie',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),2,29,15,2,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Jamie',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'R Bishop'),3,26,13,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Ray',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),4,28,16,3,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Plumber',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),5,12,14,3,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Ray',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),6,15,19,4,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Plumber',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),7,33,31,4,1,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Jamie',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),8,14,14,2,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Ray',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),9,13,2,0,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Plumber',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Dogar'),10,1,0,0,0,(SELECT id FROM batting_conclusion WHERE name = 'other'),null,'Plumber',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Winter'),11,4,1,0,0,(SELECT id FROM batting_conclusion WHERE name = 'not_out'),null,null,null)
),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),1,36,0,28,1,1,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),2,42,0,26,2,2,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'A Dogar'),3,42,0,22,1,2,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),4,24,0,26,1,5,2,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),5,18,0,26,2,0,2,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),6,42,1,31,1,1,0,0)





),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),1,16)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),2,18)

, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),4,9)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),5,31)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),6,39)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),7,1)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),8,10)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'P Oliver'),(SELECT id FROM smp WHERE scorecard_name = 'A Dogar'),9,1)


)
SELECT 'complete';