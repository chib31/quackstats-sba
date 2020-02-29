WITH t AS (
  SELECT t.id FROM team t WHERE name = 'Plastics CC'
),

f AS (INSERT INTO fixture VALUES
  (default,(SELECT id FROM t),'2019-08-18',(SELECT id FROM team WHERE LOWER(name) LIKE '%merton boars%'),1,'Merton Cricket Club','Limited Overs',40,default,TRUE,TRUE,(SELECT id FROM result_type WHERE name = 'won'))
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),1,TRUE,240,8,171,7,0,5,2)
, (default,(SELECT id FROM f),2,FALSE,236,10,155,1,0,24,7)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'C Bradbury'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Davies'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'R Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Webster'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Byrne'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Dewhirst'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Anderson'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Oliver'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Doy'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'Saril'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Webb'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),1,3,0,0,0,(SELECT id FROM batting_conclusion WHERE name = 'lbw'),null,'Ehsan',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),2,29,30,4,1,(SELECT id FROM batting_conclusion WHERE name = 'run_out'),null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'R Bishop'),3,10,2,0,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Bacon',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),4,10,4,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Ehsan',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),5,18,3,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Ehsan',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),6,16,1,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Sajid',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),7,95,86,9,2,(SELECT id FROM batting_conclusion WHERE name = 'not_out'),null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),8,11,20,4,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Joseph',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Oliver'),9,20,0,0,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Niskou',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),10,30,11,1,0,(SELECT id FROM batting_conclusion WHERE name = 'not_out'),null,null,null)

),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),1,48,0,37,2,5,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),2,18,2,3,0,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),3,48,1,24,1,6,2,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),4,12,0,13,0,3,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),5,36,1,26,1,3,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),6,30,1,18,1,4,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),7,20,0,28,3,1,4,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),8,24,0,6,1,2,0,0)



),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),1,25)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),2,32)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),3,14)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),4,2)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'Saril'),5,20)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),6,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),7,1)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),8,2)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'run_out'),(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),null,9,1)

, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),11,3)
)
SELECT 'complete';