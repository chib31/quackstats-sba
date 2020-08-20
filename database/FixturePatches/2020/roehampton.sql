WITH t AS (SELECT t.id FROM team t WHERE name = 'Plastics CC'),
f AS (INSERT INTO fixture VALUES
  (default,(SELECT id FROM t),'2020-07-18',(SELECT id FROM team WHERE LOWER(name) LIKE '%roehampton%'),1,'Barnes Common Cricket Ground','Limited Overs',35,default,FALSE,FALSE,(SELECT id FROM result_type WHERE name = 'lost'))
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),2,TRUE,157,10,151,15,2,1,2)
, (default,(SELECT id FROM f),1,FALSE,194,7,232,4,1,4,0)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'C Bradbury'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'R Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Webster'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'D Gillan'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Davies'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Dewhirst'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Anderson'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Sandham'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Jamieson'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Webb'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'Saril'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),1,13,7,1,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Monroe',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'R Bishop'),2,44,15,2,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Sanj',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),3,16,16,4,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Monroe',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),4,4,1,0,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Sanj',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),5,5,2,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Evans',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),6,7,6,1,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Evans',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),7,8,9,1,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Evans',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),8,23,36,5,1,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Sanj',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),9,20,29,4,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Sanj',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),10,2,0,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Evans',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),11,3,4,1,0,(SELECT id FROM batting_conclusion WHERE name = 'not_out'),null,null,null)
),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),1,36,0,51,2,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),2,42,0,34,2,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),3,38,0,36,2,2,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),4,24,0,31,0,2,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),5,36,0,59,1,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),6,18,0,20,0,0,0,0)





),

w AS (INSERT INTO wicket VALUES


  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),3,16)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),4,28)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),5,2)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),6,1)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),7,12)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),8,1)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),9,0)


)
SELECT 'complete';