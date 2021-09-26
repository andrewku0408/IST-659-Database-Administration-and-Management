/*
Andrew Ku Project 
Physical Database Design
*/
DROP TABLE IF exists lol_match_detail_list
DROP TABLE IF exists lol_champion_role_list
DROP TABLE IF exists lol_player_champion_list
DROP TABLE IF exists lol_game_match
DROP TABLE IF exists lol_role
DROP TABLE IF exists lol_champion
DROP TABLE IF exists lol_player

--Creating player table
CREATE TABLE lol_player (
	lol_player_id int identity primary key,
	lol_user_name varchar(30) not null,
	CONSTRAINT U1_lol_player UNIQUE (lol_user_name)
)


--Creating champion table
CREATE TABLE lol_champion (
	lol_champion_id int identity primary key,
	lol_champion_name varchar(30) not null,
	CONSTRAINT U1_lol_champion UNIQUE (lol_champion_name)
)

--Creating role table 
CREATE TABLE lol_role (
	lol_role_id int identity primary key,
	lol_role_name varchar(30) not null,
	CONSTRAINT U1_lol_role UNIQUE (lol_role_name)
)

--Creating game match table 
CREATE TABLE lol_game_match (
	lol_game_match_id int identity Primary key, 
	lol_match_date_time datetime not null default getdate() 
)


--Creating player champion list table 
CREATE TABLE lol_player_champion_list (
	lol_player_champion_list_id int identity Primary key,
	lol_player_id int not null FOREIGN KEY REFERENCES lol_player(lol_player_id),
	lol_champion_id int not null FOREIGN KEY REFERENCES lol_champion(lol_champion_id)
)

--Creating champion_role_list table 
CREATE TABLE lol_champion_role_list (
	lol_champion_role_list_id int identity Primary key, 
	lol_champion_id int not null FOREIGN KEY REFERENCES lol_champion(lol_champion_id),
	lol_role_id int not null FOREIGN KEY REFERENCES lol_role(lol_role_id)
)

--Creating match_detail_list table 
CREATE TABLE lol_match_detail_list (
	lol_match_detail_id int identity primary key,
	lol_game_match_id int not null foreign key references lol_game_match(lol_game_match_id),
	lol_player_champion_list_id int not null foreign key references lol_player_champion_list(lol_player_champion_list_id),
	lol_role_id int not null foreign key references lol_role(lol_role_id),
	lol_win bit not null
)