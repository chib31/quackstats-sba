-- Result Types
INSERT INTO result_type VALUES
  (default,'won','Won'),
  (default,'lost','Lost'),
  (default,'tied','Tied'),
  (default,'drawn','Drawn'),
  (default,'na','N/a')
;

-- Batting Conclusions
INSERT INTO batting_conclusion VALUES
  (default,'dnb','DNB',0,0,FALSE,FALSE)
, (default,'not_out','Not Out',0,1,FALSE,FALSE)
, (default,'retired','Retired',0,1,FALSE,FALSE)
, (default,'retired_hurt','Retired Hurt',0,1,FALSE,FALSE)
, (default,'bowled','Bowled',1,0,TRUE,FALSE)
, (default,'caught','Caught',1,0,TRUE,TRUE)
, (default,'hit_twice','Hit Twice',1,0,FALSE,FALSE)
, (default,'hit_wicket','Hit Wicket',1,0,TRUE,FALSE)
, (default,'lbw','LBW',1,0,TRUE,FALSE)
, (default,'obstructing','Obstructing Field',1,0,FALSE,FALSE)
, (default,'run_out','Run Out',1,0,FALSE,TRUE)
, (default,'stumped','Stumped',1,0,TRUE,TRUE)
, (default,'timed_out','Timed Out',1,0,FALSE,FALSE)
, (default,'other','Other',1,0,FALSE,FALSE)
;

-- This team (Members as of 12-05-2019)
WITH this_team AS (
  INSERT INTO team VALUES (default,'Plastics CC')
  RETURNING id
)

INSERT INTO player VALUES
  (default, (SELECT id FROM this_team), 'Saril', NULL, NULL, NULL, 'Saril', 1, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Jamie', NULL, 'Doy', NULL, 'J Doy', 2, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Robert', NULL, 'Bishop', NULL, 'R Bishop', 3, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Charlie', NULL, 'Bradbury', NULL, 'C Bradbury', 4, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Matt', NULL, 'Webb', NULL, 'M Webb', 5, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Mark', NULL, 'Davies', NULL, 'M Davies', 6, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Peter', NULL, 'Oliver', NULL, 'P Oliver', 7, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Mike', NULL, 'Winter', NULL, 'M Winter', 8, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Niall', NULL, 'Jackson', NULL, 'N Jackson', 9, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Henry', NULL, 'Hobbs', NULL, 'H Hobbs', 10, NULL, NULL)
, (default, (SELECT id FROM this_team), 'James', NULL, 'Sandham', NULL, 'J Sandham', 11, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Maithri', NULL, 'Jayasuriya', NULL, 'M Jayasuriya', 12, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Alex', NULL, 'Webster', NULL, 'A Webster', 13, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Joey', NULL, 'Anderson', NULL, 'J Anderson', 14, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Leo', NULL, 'Bearcroft', NULL, 'L Bearcroft', 15, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Jerry', NULL, 'Jamieson', NULL, 'J Jamieson', 16, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Simon', NULL, 'Freeman', NULL, 'S Freeman', 17, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Pete', NULL, 'Bishop', NULL, 'P Bishop', 18, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Tom', NULL, 'Morgan-Grenville', NULL, 'T Morgan-Grenville', 19, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Tom', NULL, 'Scott-Coombes', NULL, 'T Scott-Coombes', 20, NULL, NULL)
, (default, (SELECT id FROM this_team), 'John', NULL, 'Papadopoulos', NULL, 'J Papadopoulos', 21, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Dom', NULL, 'Gillan', NULL, 'D Gillan', 22, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Anthony', NULL, 'Mortimer', NULL, 'A Mortimer', 23, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Phil', NULL, 'Byrne', NULL, 'P Byrne', 24, NULL, NULL)
, (default, (SELECT id FROM this_team), 'James', NULL, 'Dewhirst', NULL, 'J Dewhirst', 25, NULL, NULL)
, (default, (SELECT id FROM this_team), 'James', NULL, 'Heis', NULL, 'J Heis', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Billy', NULL, 'Soomro', NULL, 'B Soomro', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Alex', NULL, 'Armytage', NULL, 'A Armytage', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Jon', NULL, 'Thornhill', NULL, 'J Thornhill', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Liam', NULL, 'Killen', NULL, 'L Killen', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Ali', NULL, 'Nurmohammed', NULL, 'A Nurmohammed', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Saj', NULL, 'Ali', NULL, 'S Ali', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Michael', NULL, 'Lizut', NULL, 'M Lizut', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Mike', NULL, 'Wills', NULL, 'M Wills', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Hughie', NULL, 'Jamieson', NULL, 'H Jamieson', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Iain', NULL, 'Gordon', NULL, 'I Gordon', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'James', NULL, 'Jarvis', NULL, 'J Jarvis', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Ian', NULL, 'Whitfield', NULL, 'I Whitfield', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Akhil', NULL, 'Dogar', NULL, 'A Dogar', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Avi', NULL, 'Asthana', NULL, 'A Asthana', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'James', NULL, 'Hewlett', NULL, 'J Hewlett', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Neil', NULL, 'Whitfield', NULL, 'N Whitfield', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Rich', NULL, 'Wills', NULL, 'R Wills', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Charles', NULL, 'Hatton', NULL, 'C Hatton', NULL, NULL, NULL)
, (default, (SELECT id FROM this_team), 'Will', NULL, 'Hawkins', NULL, 'W Hawkins', NULL, NULL, NULL)
;

-- Opposition
INSERT INTO team
VALUES
  (default, 'Hendricks XI')
, (default, 'Cumnor Challengers')
, (default, 'Princes Head CC')
, (default, 'Holtwhites Trinibis')
, (default, 'Kings Road')
, (default, 'Stanmore Warriors')
, (default, 'Roehampton CC')
, (default, 'Flying Ducksmen')
, (default, 'Railway Taverners')
, (default, 'Crossbats CC')
, (default, 'Southbank CC')
, (default, 'Graces')
, (default, 'Clapham CC')
, (default, 'Camel CC')
, (default, 'Egham Roses')
, (default, 'Gentlemen of West London')
, (default, 'Norwood Exiles')
, (default, 'Woodside Green')
, (default, 'Cincinnati CC')
, (default, 'Winchmore Hill Tigers')
, (default, 'Merton Boars')
, (default, 'Old Minchendenians')
, (default, 'Mavericks CC')
, (default, 'Clapham In CC')
, (default, 'St Anne''s Allstars')
, (default, 'Bricklayers Arms')
;