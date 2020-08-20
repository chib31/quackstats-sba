WITH t AS (
  SELECT t.id FROM team t WHERE name = 'Plastics CC'
),

f AS (INSERT INTO fixture VALUES
  (default,(SELECT id FROM t),'2019-09-07',(SELECT id FROM team WHERE LOWER(name) LIKE '%old minchendenians%'),1,'Old Minchendenians CC','Limited Overs',40,default,TRUE,TRUE,(SELECT id FROM result_type WHERE name = 'won'))
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),1,TRUE,228,10,186,5,3,7,3)
, (default,(SELECT id FROM f),2,FALSE,240,9,164,9,0,24,3)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Webb'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'T Morgan-Grenville'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'N Whitfield'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'C Bradbury'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'I Whitfield'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Wills'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'R Wills'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Dogar'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Hewlett'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Doy'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Hewlett'),1,2,0,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Tony',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'T Morgan-Grenville'),2,18,22,4,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Tony',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'N Whitfield'),3,22,5,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Dax',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),4,41,25,2,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Om',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),5,22,8,1,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Dax',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'I Whitfield'),6,21,9,0,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Aman',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Wills'),7,24,23,5,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Om',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'R Wills'),8,5,4,1,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Aman',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Dogar'),9,20,24,4,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Tony',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),10,40,42,5,1,(SELECT id FROM batting_conclusion WHERE name = 'stumped'),null,'Stu',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),11,6,3,0,0,(SELECT id FROM batting_conclusion WHERE name = 'not_out'),null,null,null)
),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),1,48,1,33,1,0,4,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'T Morgan-Grenville'),2,12,2,0,3,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'R Wills'),3,48,2,42,1,4,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'N Whitfield'),4,24,0,15,1,7,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'A Dogar'),5,42,2,12,2,2,3,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'I Whitfield'),6,12,0,9,0,8,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Hewlett'),7,6,0,1,0,1,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'M Wills'),8,42,0,34,1,2,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),9,6,0,2,0,1,0,0)


),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),(SELECT id FROM smp WHERE scorecard_name = 'T Morgan-Grenville'),1,10)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,(SELECT id FROM smp WHERE scorecard_name = 'T Morgan-Grenville'),2,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),3,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),(SELECT id FROM smp WHERE scorecard_name = 'T Morgan-Grenville'),4,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'lbw'),null,(SELECT id FROM smp WHERE scorecard_name = 'R Wills'),5,50)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'M Wills'),6,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,(SELECT id FROM smp WHERE scorecard_name = 'N Whitfield'),7,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'A Dogar'),8,31)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),(SELECT id FROM smp WHERE scorecard_name = 'A Dogar'),9,25)
)
SELECT 'complete';
