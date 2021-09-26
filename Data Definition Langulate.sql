--inserting values into lol_role
SELECT*FROM lol_role
INSERT INTO lol_role (lol_role_name)
VALUES               ('Top'), ('Jungle'), ('Mid'), ('Bot'), ('Support')

--inserting values into lol_champion
SELECT*FROM lol_champion
INSERT INTO lol_champion (lol_champion_name)
VALUES                   ('Fiora'), ('Sett'), ('Tahm Kench'), ('Camille'), ('Irelia'),
                         ('Lee Sin'), ('Jarvan IV'), ('Xin Zhao'), ('Shaco'), ('Taliyah'),
						 ('LeBlanc'), ('Katarina'), ('Talon'), ('Zed'), ('Akshan'),
						 ('Vayne'), ('Ashe'), ('Ezreal'), ('Ziggs'), ('Samira'),
						 ('Blizcrank'), ('Leona'), ('Amumu'), ('Lulu'), ('Thresh')

--inserting values into lol_player
SELECT*FROM lol_player
ORDER BY lol_player_id
INSERT INTO lol_player(lol_user_name)
VALUES                
					  ('Overthrower'), ('Flashpoint'), ('BlueWhale'), ('Tsunami'),
                      ('Parabolo'), ('Possessed'), ('Divinity'), ('Steadfast'), ('Smokescreen')
INSERT INTO lol_player(lol_user_name)
VALUES 
					  ('AndyKu')

--inserting values into lol_game_match
SELECT*FROM lol_game_match
INSERT INTO lol_game_match(lol_match_date_time)
VALUES                    ('3/1/2021 14:00'), ('3/1/2021 14:15'), ('3/1/2021 14:21')

SELECT * FROM lol_role
SELECT * FROM lol_champion
ORDER BY lol_champion_id
--inserting values into lol_champion_role_list
SELECT * FROM lol_champion_role_list
INSERT INTO lol_champion_role_list(lol_champion_id, lol_role_id)
VALUES
                                  (1,1),(6,2),(11,3),(16,4),(21,5),
								  (2,1),(7,2),(12,3),(17,4),(22,5),
								  (3,1),(8,2),(13,3),(18,4),(23,5),
								  (4,1),(9,2),(14,3),(19,4),(24,5),
								  (5,1),(10,2),(15,3),(20,4),(25,5)
SELECT * FROM lol_player
ORDER BY lol_player_id
SELECT * FROM lol_champion
ORDER BY lol_champion_id
--inserting values into lol_player_champion_list
SELECT * FROM lol_player_champion_list
INSERT INTO lol_player_champion_list(lol_player_id, lol_champion_id)
VALUES
                                    (1,1),(2,6),(3,11),(4,16),(5,21),
									(6,2),(7,7),(8,12),(9,17), (10,22),
									(1,2),(2,7),(3,12),(4,17),(5,22),
									(6,3),(7,8),(8,13),(9,18), (10,23),
									(1,3),(2,8),(3,13),(4,18),(5,23),
									(6,4),(7,9),(8,14),(9,19), (10,24)

--inserting values 
SELECT * FROM lol_champion
SELECT * FROM lol_player_champion_list
SELECT * FROM lol_match_detail_list
INSERT INTO lol_match_detail_list(lol_game_match_id,lol_player_champion_list_id,lol_role_id,lol_win)
VALUES
                                 (1,1,1,1), (1,2,2,1),  (1,3,3,1), (1,4,4,1), (1,5,5,1),
								 (1,6,1,0), (1,7,2,0), (1,8,3,0), (1,9,4,0), (1,10,5,0),
								 (2,11,1,0), (2,12,2,0), (2,13,3,0), (2,14,4,0), (2,15,5,0),
								 (2,16,1,1), (2,17,2,1), (2,18,3,1), (2,19,4,1), (2,20,5,1),
								 (3,21,1,1), (3,22,2,1), (3,23,3,1), (3,24,4,1), (3,25,5,1),
								 (3,26,1,0), (3,27,2,0), (3,28,3,0), (3,29,4,0), (3,30,5,0)



--WHAT WAS THE PLAY AMOUNT OF EACH CHAMPION?
GO
CREATE FUNCTION dbo.lol_championMatchCount (@championID int)
RETURNS int AS
BEGIN
	DECLARE @returnValue int 
	SELECT @returnValue = COUNT(lol_player_id) FROM lol_player_champion_list 
	WHERE lol_player_champion_list.lol_champion_id = @championID
	RETURN @returnValue
END

--VIEW
GO
CREATE or ALTER VIEW championDetails AS
SELECT 
	lol_player_champion_list.lol_champion_id
	, lol_champion.lol_champion_name
	, SUM(CAST(lol_win AS int)) as winAmount
	, dbo.lol_championMatchCount(lol_champion.lol_champion_id) AS matchAmount
	, lol_role.lol_role_name AS playedRoles
FROM lol_match_detail_list
RIGHT JOIN lol_player_champion_list ON lol_player_champion_list.lol_player_champion_list_id = lol_match_detail_list.lol_player_champion_list_id
JOIN lol_champion ON lol_champion.lol_champion_id = lol_player_champion_list.lol_champion_id
JOIN lol_role ON lol_role.lol_role_id = lol_match_detail_list.lol_role_id
GROUP BY
	lol_player_champion_list.lol_champion_id
	, lol_champion.lol_champion_name
	, dbo.lol_championMatchCount(lol_champion.lol_champion_id) 
	, lol_role.lol_role_name

SELECT * FROM championDetails