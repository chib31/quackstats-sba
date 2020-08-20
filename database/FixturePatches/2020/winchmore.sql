WITH t AS (SELECT t.id FROM team t WHERE name = 'Plastics CC'),
f AS (INSERT INTO fixture VALUES
  (default,(SELECT id FROM t),'2020-08-09',(SELECT id FROM team WHERE LOWER(name) LIKE '%winchmore hill tigers%'),1,'Winchmore Hill CC','Limited Overs',40,default,TRUE,FALSE,(SELECT id FROM result_type WHERE name = 'lost'))
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),1,TRUE,192,10,139,12,2,3,2)
, (default,(SELECT id FROM f),2,FALSE,230,10,206,1,7,17,10)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Webster'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'R Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'W Hawkins'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'C Hatton'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'D Gillan'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'L Killen'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Byrne'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Anderson'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Sandham'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Dewhirst'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'I Whitfield'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'R Bishop'),1,28,8,1,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Hodges',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'W Hawkins'),2,11,4,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Sirander',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'C Hatton'),3,12,2,0,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Sirander',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),4,12,5,1,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Warren',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'L Killen'),5,9,2,0,0,(SELECT id FROM batting_conclusion WHERE name = 'caught'),null,'Webster',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),6,12,3,0,0,(SELECT id FROM batting_conclusion WHERE name = 'lbw'),null,'Webster',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),7,1,0,0,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Webster',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),8,12,12,3,0,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Webster',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),9,40,80,14,3,(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,'Hidges',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),10,3,0,0,0,(SELECT id FROM batting_conclusion WHERE name = 'run_out'),null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'I Whitfield'),11,11,5,1,0,(SELECT id FROM batting_conclusion WHERE name = 'not_out'),null,null,null)
),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),1,48,1,47,2,1,2,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'I Whitfield'),2,42,0,41,0,5,5,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),3,44,0,30,3,3,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),4,48,0,26,3,1,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),5,18,0,15,1,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),6,24,0,28,0,5,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'C Hatton'),7,6,0,10,0,0,0,0)




),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM batting_conclusion WHERE name = 'stumped'),(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),1,23)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),2,4)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),3,14)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'lbw'),null,(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),4,16)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'run_out'),(SELECT id FROM smp WHERE scorecard_name = 'W Hawkins'),null,5,42)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),6,4)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),7,44)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),8,11)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'caught'),(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),9,3)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM batting_conclusion WHERE name = 'bowled'),null,(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),10,2)

)
SELECT 'complete';