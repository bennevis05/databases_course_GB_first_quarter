/*
	СКРИПТЫ НАПОЛНЕНИЯ БД ДАННЫМИ
*/

/*
	Перед началом заполнения таблиц, создадим несколько триггеров,
	которые позволят избежать дублирования информации и запросов на вставку.
*/

/*
	Первый триггер будет обновлять поле total_sold таблицы products сразу после вставки данных в таблицу
	orders_products. Таким образом, если товар был приобретен, то мы сразу увидим информацию об общем количестве
	проданного товара.
	Также этот триггер добавлять данные в таблицу user_collections, так как все необходимые данные можно
	извлечь из таблиц orders и orders_products
*/
DELIMITER //
CREATE TRIGGER insert_orders_products AFTER INSERT ON orders_products
FOR EACH ROW
BEGIN
	UPDATE products SET total_sold = total_sold + 1 WHERE id = NEW.product_id;
	INSERT INTO user_collections VALUES ((SELECT user_id FROM orders WHERE id = NEW.order_id), NEW.product_id, DEFAULT, DEFAULT);
END
DELIMITER ;

/*
	Второй триггер будет позволять отпралять запрос на добавление "в друзья" пользователю только в том случае,
	если этот пользователь сам еще не отправил запрос в друзья
*/
DELIMITER //
CREATE TRIGGER insert_friends BEFORE INSERT ON friends
FOR EACH ROW
BEGIN
	IF NEW.initiator_user_id = (SELECT target_user_id FROM friends WHERE 
		initiator_user_id = NEW.target_user_id ORDER BY target_user_id DESC LIMIT 1) 
		OR NEW.initiator_user_id = (SELECT target_user_id FROM friends WHERE 
		initiator_user_id = NEW.target_user_id LIMIT 1) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT cancelled';
	END IF;
END
DELIMITER ;


INSERT INTO product_category (name) VALUES 
('game'), ('software'), ('demo'), ('video'), ('soundtrack'), ('hardware');


INSERT INTO developers_and_publishers (name) VALUES
('cd project red'), ('larian studios'), ('rockstar north'), ('rockstar games'), ('id software'), ('bethesda softworks'),
('bethesda game studios'), ('valve'), ('techland'), ('techland publishing'), ('stress level zero'), ('za/um'),
('asobo studio'), ('focus home interactive'), ('fromsoftware'), ('activision'), ('experiment 101'), ('thq nordic'),
('kojima productions'), ('505 games'), ('decent software llc'), ('magix software gmbh'), ('adobe');


INSERT INTO products VALUES
(DEFAULT, 'game', 'the witcher 3: wild hunt', 'As war rages on throughout the Northern Realms, you take...', '2015-05-18',
NULL, 'cd project red', 'cd project red', 1199.00, NULL, 93, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'divinity: original sin - enhanced edition', 'Gather your party and get ready for...', '2015-10-27',
NULL, 'larian studios', 'larian studios', 699.00, NULL, 94, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'grand theft auto v', 'When a young street hustler, a retired bank robber...', '2015-04-14',
NULL, 'rockstar north', 'rockstar games', 1499.00, NULL, 96, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'doom', 'Developed by id software, the studio that pioneered...', '2016-05-13',
NULL, 'id software', 'bethesda softworks', 799.00, '18+', 85, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'the elder scrolls v: skyrim', 'The next chapter in the highly...', '2011-11-11',
NULL, 'bethesda game studios', 'bethesda softworks', 399.00, NULL, 94, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'half-life 2', 'By taking the suspense, challenge and visceral charge...', '2004-11-16',
NULL, 'valve', 'valve', 259.00, NULL, 96, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'dying light', 'First-person action survival game...', '2015-01-26',
NULL, 'techland', 'techland publishing', 1099.00, '18+', 87, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'red dead redemption 2', 'Red Dead Redemption 2, the critically acclaimed open...', '2019-12-05',
NULL, 'rockstar games', 'rockstar games', 2499.00, '18+', 93, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'boneworks', 'BONEWORKS is an Experimental Physics VR Adventure...', '2019-12-10',
NULL, 'stress level zero', 'stress level zero', 515.00, NULL, NULL, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'disco elysium', 'Disco Elysium is a groundbreaking open world...', '2019-10-15',
NULL, 'za/um', 'za/um', 725.00, NULL, 91, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'a plague tale: innocence', 'Follow the grim tale of young...', '2019-05-14',
NULL, 'asobo studio', 'focus home interactive', 1499.00, NULL, 81, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'sekiro: shadows die twice', 'Carve your own clever path to vengeance in...', '2019-03-21',
NULL, 'fromsoftware', 'activision', 1999.00, NULL, 88, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'biomutant', 'BIOMUTANT is an open-world, post-apocalyptic...', NULL,
'2020-02-01', 'experiment 101', 'thq nordic', NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'half-life: alyx', 'Half-Life: Alyx is Valve’s VR return to the Half-Life...', NULL,
'2020-03-01', 'valve', 'valve', 1085.00, NULL, NULL, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'cyberpunk 2077', 'Cyberpunk 2077 is an open-world, action-adventure...', NULL,
'2020-04-16', 'cd project red', 'cd project red', 1999.00, NULL, NULL, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'death stranding', 'From legendary game creator Hideo Kojima...', NULL,
'2020-06-01', 'kojima productions', '505 games', 3499.00, NULL, NULL, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'game', 'doom eternal', 'As the DOOM Slayer, you return to find...', NULL,
'2020-03-20', 'id software', 'bethesda softworks', 1999.00, NULL, NULL, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'software', 'decent icons 2', 'Decent Icons 2 is a Game Launcher for Windows...', '2019-09-26',
NULL, 'decent software llc', 'decent software llc', 82.00, NULL, NULL, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'software', 'vegas pro 15 edit steam edition', 'VEGAS Pro 15 Edit – Steam Edition provides...', '2017-09-05',
NULL, 'magix software gmbh', 'magix software gmbh', 5399.00, NULL, NULL, DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 'software', 'substance painter 2020', 'Substance Painter is the reference texturing...', NULL,
'2020-03-01', 'adobe', 'adobe', 2669.00, NULL, NULL, DEFAULT, DEFAULT, DEFAULT);


INSERT INTO genres (name) VALUES
('free to play'), ('early access'), ('action'), ('adventure'), ('casual'), ('indie'),
('massively multiplayer'), ('racing'), ('rpg'), ('simulation'), ('sports'), ('strategy'),
('design & illustration'), ('photo editing'), ('utilities'), ('audio production'), ('video production'),
('animation & modeling'), ('game development');


INSERT INTO product_genre VALUES
('1', 'rpg'), ('2', 'adventure'), ('2', 'indie'), ('2', 'rpg'), ('2', 'strategy'),
('3', 'action'), ('3', 'adventure'), ('4', 'action'), ('5', 'rpg'), ('6', 'action'),
('7', 'action'), ('7', 'rpg'), ('8', 'action'), ('8', 'adventure'), ('9', 'action'),
('9', 'adventure'), ('9', 'indie'), ('9', 'simulation'), ('10', 'rpg'), ('11', 'action'),
('11', 'adventure'), ('12', 'action'), ('12', 'adventure'), ('13', 'action'), ('13', 'rpg'),
('14', 'action'), ('14', 'adventure'), ('15', 'rpg'), ('16', 'action'), ('16', 'adventure'),
('17', 'action'), ('18', 'design & illustration'), ('18', 'photo editing'), ('18', 'utilities'),
('18', 'early access'), ('19', 'audio production'), ('19', 'video production'), ('20', 'animation & modeling'),
('20', 'design & illustration'), ('20', 'game development');


INSERT INTO tags (name) VALUES
('open world'), ('rpg'), ('story rich'), ('atmospheric'), ('turn-based'), ('co-op'),
('fantasy'), ('adventure'), ('action'), ('multiplayer'), ('third person'), ('fps'),
('gore'), ('shooter'), ('demons'), ('sci-fi'), ('dragons'), ('classic'), ('singleplayer'),
('zombies'), ('survival'), ('parkour'), ('western'), ('masterpiece'), ('vr'), ('physics'),
('simulation'), ('choices matter'), ('detective'), ('noir'), ('female protagonist'), ('stealth'),
('souls-like'), ('difficult'), ('ninja'), ('cyberpunk'), ('walking simulator'), 
('violent'), ('great soundtrack'), ('early access'), ('utilities'), ('design & illustration'),
('video production'), ('game development'), ('animation & modeling'), ('software');


INSERT INTO product_tag VALUES
('1', 'open world'), ('1', 'rpg'), ('1', 'story rich'), ('1', 'atmospheric'), ('2', 'rpg'),
('2', 'turn-based'), ('2', 'co-op'), ('2', 'fantasy'), ('2', 'adventure'), ('3', 'open world'),
('3', 'action'), ('3', 'multiplayer'), ('3', 'third person'), ('4', 'fps'), ('4', 'gore'), ('4', 'action'),
('4', 'shooter'), ('4', 'demons'), ('4', 'sci-fi'),('5', 'open world'), ('5', 'rpg'), ('5', 'fantasy'),
('5', 'adventure'), ('5', 'dragons'), ('6', 'fps'), ('6', 'action'), ('6', 'sci-fi'), ('6', 'classic'),
('6', 'singleplayer'), ('7', 'zombies'), ('7', 'survival'), ('7', 'open world'), ('7', 'parkour'), ('7', 'co-op'),
('8', 'adventure'), ('8', 'action'), ('8', 'western'), ('8', 'masterpiece'), ('8', 'fps'),
('9', 'vr'), ('9', 'action'), ('9', 'masterpiece'), ('9', 'physics'), ('9', 'simulation'),
('10', 'rpg'), ('10', 'choices matter'), ('10', 'story rich'), ('10', 'detective'), ('10', 'noir'), 
('11', 'story rich'), ('11', 'adventure'), ('11', 'female protagonist'), ('11', 'stealth'),
('12', 'souls-like'),('12', 'difficult'), ('12', 'action'), ('12', 'singleplayer'), ('12', 'ninja'),
('13', 'open world'), ('13', 'action'), ('13', 'rpg'), ('13', 'adventure'), ('13', 'fantasy'),
('14', 'masterpiece'), ('14', 'vr'), ('14', 'action'), ('14', 'female protagonist'),
('15', 'cyberpunk'), ('15', 'masterpiece'), ('15', 'open world'), ('15', 'rpg'), ('15', 'fps'), 
('16', 'walking simulator'), ('16', 'open world'), ('16', 'story rich'), ('16', 'sci-fi'), 
('17', 'gore'), ('17', 'action'), ('17', 'violent'), ('17', 'fps'), ('17', 'great soundtrack'),
('18', 'early access'), ('18', 'utilities'), ('18', 'design & illustration'), ('19', 'video production'), 
('20', 'game development'), ('20', 'animation & modeling'), ('20', 'software');


INSERT INTO additional_features (name) VALUES
('single-player'), ('steam achievements'), ('full controller support'), ('steam cloud'), ('remote play on tv'),
('cross-platform multiplayer'), ('steam trading cards'), ('captions available'), ('remote play together'),
('partial controller support'), ('steam workshop'), ('includes source sdk'),('valve anti-cheat enabled'), 
('includes level editor'), ('online pvp'), ('online co-op'), ('in-app purchases');


INSERT INTO product_features VALUES
('1', 'single-player'), ('1', 'steam achievements'), ('1', 'full controller support'), ('1', 'steam cloud'), 
('1', 'remote play on tv'), ('2', 'single-player'), ('2', 'cross-platform multiplayer'), ('2', 'steam achievements'),
('2', 'full controller support'), ('2', 'steam trading cards'), ('2', 'captions available'), ('2', 'steam cloud'),
('2', 'remote play together'), ('3', 'single-player'), ('3', 'steam achievements'), ('3', 'full controller support'),
('3', 'remote play on tv'), ('4', 'single-player'), ('4', 'steam achievements'),('4', 'steam trading cards'), 
('4', 'partial controller support'), ('4', 'steam cloud'), ('5', 'single-player'), ('5', 'steam achievements'),
('5', 'steam trading cards'), ('5', 'steam workshop'), ('5', 'partial controller support'), ('5', 'steam cloud'),
('6', 'single-player'), ('6', 'steam achievements'), ('6', 'steam trading cards'), ('6', 'captions available'), 
('6', 'partial controller support'), ('6', 'steam cloud'), ('6', 'includes source sdk'), ('6', 'remote play together'),
('7', 'single-player'), ('7', 'steam achievements'), ('7', 'full controller support'), ('7', 'steam trading cards'),
('7', 'steam workshop'), ('7', 'steam cloud'), ('7', 'valve anti-cheat enabled'), ('7', 'includes level editor'),
('7', 'remote play on tv'), ('8', 'single-player'), ('8', 'online pvp'), ('8', 'online co-op'),
('8', 'steam achievements'), ('8', 'in-app purchases'), ('8', 'partial controller support'), ('9', 'single-player'), 
('9', 'steam achievements'), ('10', 'single-player'), ('10', 'steam achievements'), ('10', 'steam trading cards'),
('10', 'steam cloud'), ('11', 'single-player'), ('11', 'steam achievements'), ('11', 'full controller support'), 
('11', 'steam trading cards'), ('11', 'steam cloud'), ('11', 'remote play on tv'), ('12', 'single-player'), 
('12', 'steam achievements'), ('12', 'full controller support'), ('12', 'steam trading cards'), ('12', 'steam cloud'),
('13', 'single-player'), ('13', 'steam achievements'), ('13', 'full controller support'), ('13', 'steam trading cards'),
('13', 'steam cloud'), ('14', 'single-player'), ('14', 'steam achievements'), ('14', 'captions available'), 
('14', 'steam workshop'), ('14', 'includes level editor'), ('15', 'single-player'), ('16', 'single-player'),
('16', 'steam achievements'), ('16', 'partial controller support'), ('17', 'single-player'), ('17', 'online pvp'),
('17', 'partial controller support'), ('18', 'steam workshop');


INSERT INTO languages (`language`) VALUES
('english'), ('french'), ('italian'), ('german'), ('spanish'), ('arabic'), ('czech'), ('hungarian'), ('japanese'),
('korean'), ('polish'), ('portuguese'), ('russian'), ('traditional chinese'), ('turkish'), ('simplified chinese'),
('dutch'), ('danish'), ('finnish'), ('norwegian'), ('swedish'), ('thai');


INSERT INTO product_language VALUES
('1', 'english'), ('1', 'french'), ('1', 'italian'), ('1', 'german'), ('1', 'spanish'), ('1', 'arabic'),
('1', 'czech'), ('1', 'hungarian'), ('1', 'japanese'), ('1', 'korean'), ('1', 'polish'), ('1', 'portuguese'),
('1', 'russian'), ('1', 'traditional chinese'), ('1', 'turkish'), ('1', 'simplified chinese'),
('2', 'english'), ('2', 'french'), ('2', 'italian'), ('2', 'german'), ('2', 'spanish'),('2', 'czech'), 
('2', 'polish'), ('2', 'russian'), ('2', 'simplified chinese'), ('3', 'english'), ('3', 'french'), ('3', 'italian'),
('3', 'german'), ('3', 'spanish'), ('3', 'japanese'), ('3', 'korean'), ('3', 'polish'), ('3', 'portuguese'),
('3', 'russian'), ('3', 'traditional chinese'), ('3', 'simplified chinese'), ('4', 'english'), ('4', 'french'),
('4', 'italian'), ('4', 'german'), ('4', 'spanish'), ('4', 'japanese'), ('4', 'polish'), ('4', 'portuguese'),
('4', 'russian'), ('4', 'traditional chinese'), ('5', 'english'), ('5', 'french'), ('5', 'italian'), ('5', 'german'),
('5', 'spanish'), ('5', 'czech'), ('5', 'japanese'), ('5', 'polish'), ('5', 'russian'), ('6', 'english'), 
('6', 'french'), ('6', 'italian'), ('6', 'german'), ('6', 'spanish'), ('6', 'thai'), ('6', 'japanese'), 
('6', 'polish'), ('6', 'portuguese'), ('6', 'dutch'), ('6', 'danish'), ('6', 'finnish'), ('6', 'russian'),
('6', 'traditional chinese'), ('6', 'swedish'), ('6', 'simplified chinese'), ('6', 'norwegian'), ('7', 'english'),
('7', 'french'), ('7', 'italian'), ('7', 'german'), ('7', 'spanish'), ('7', 'arabic'), ('7', 'czech'),
('7', 'hungarian'), ('7', 'japanese'), ('7', 'korean'), ('7', 'polish'), ('7', 'portuguese'), ('7', 'russian'),
('7', 'traditional chinese'), ('7', 'turkish'), ('7', 'simplified chinese'), ('8', 'english'), ('8', 'french'),
('8', 'italian'), ('8', 'german'), ('8', 'spanish'), ('8', 'japanese'), ('8', 'korean'), ('8', 'polish'),
('8', 'portuguese'), ('8', 'russian'), ('8', 'traditional chinese'), ('8', 'turkish'), ('8', 'simplified chinese'),
('9', 'english'), ('10', 'english'), ('11', 'english'), ('11', 'french'), ('11', 'italian'), ('11', 'german'), 
('11', 'spanish'), ('11', 'czech'), ('11', 'japanese'), ('11', 'korean'), ('11', 'polish'), ('11', 'portuguese'),
('11', 'russian'), ('11', 'traditional chinese'), ('11', 'turkish'), ('11', 'simplified chinese'),
('12', 'english'), ('12', 'french'), ('12', 'italian'), ('12', 'german'), ('12', 'spanish'), ('12', 'thai'),
('12', 'japanese'), ('12', 'korean'), ('12', 'polish'), ('12', 'portuguese'), ('12', 'russian'),
('12', 'traditional chinese'), ('12', 'turkish'), ('12', 'simplified chinese'), ('13', 'english'), ('13', 'french'), 
('13', 'italian'), ('13', 'german'), ('13', 'spanish'), ('14', 'english'), ('14', 'french'), ('14', 'italian'),
('14', 'german'), ('14', 'spanish'), ('14', 'japanese'), ('14', 'korean'), ('14', 'polish'), ('14', 'russian'), 
('14', 'traditional chinese'), ('14', 'simplified chinese'), ('15', 'english'), ('15', 'french'), ('15', 'italian'),
('15', 'german'), ('15', 'spanish'), ('15', 'arabic'), ('15', 'czech'), ('15', 'hungarian'), ('15', 'japanese'), 
('15', 'korean'), ('15', 'polish'), ('15', 'portuguese'), ('15', 'russian'), ('15', 'traditional chinese'), 
('15', 'turkish'), ('15', 'simplified chinese'), ('16', 'english'), ('16', 'french'), ('16', 'italian'), 
('16', 'german'), ('16', 'spanish'), ('16', 'arabic'), ('16', 'czech'), ('16', 'hungarian'), ('16', 'japanese'),
('16', 'korean'), ('16', 'polish'), ('16', 'portuguese'), ('16', 'russian'), ('16', 'traditional chinese'),
('16', 'turkish'), ('16', 'simplified chinese'), ('16', 'dutch'), ('16', 'danish'), ('16', 'finnish'),
('16', 'norwegian'), ('17', 'english'), ('17', 'french'), ('17', 'italian'), ('17', 'german'), ('17', 'spanish'),
('17', 'japanese'), ('17', 'korean'), ('17', 'polish'), ('17', 'portuguese'), ('17', 'russian'), 
('17', 'traditional chinese'), ('17', 'turkish'), ('17', 'simplified chinese'), ('18', 'english'), ('18', 'french'),
('18', 'italian'), ('18', 'german'), ('18', 'spanish'), ('18', 'japanese'), ('18', 'korean'), ('18', 'russian'),
('19', 'english'), ('19', 'french'), ('19', 'german'), ('19', 'spanish'), ('20', 'english'), ('20', 'japanese'),
('20', 'simplified chinese');


INSERT INTO users VALUES
(DEFAULT, 'example1', 'example1@mail.com', 'qiyh4XPJGsOZ2M', 'user1', 'Jeff', NULL, NULL, NULL, 'I like games!', DEFAULT, DEFAULT),
(DEFAULT, 'example2', 'example2@mail.com', 'qiyh4XPJGsOZ2M', 'user2', 'Tom', NULL, NULL, NULL, 'I like games!', DEFAULT, DEFAULT),
(DEFAULT, 'example3', 'example3@mail.com', 'qiyh4XPJGsOZ2M', 'user3', NULL, NULL, NULL, NULL, 'I like games!', DEFAULT, DEFAULT),
(DEFAULT, 'example4', 'example4@mail.com', 'qiyh4XPJGsOZ2M', 'user4', 'Anna Brown', NULL, NULL, NULL, 'I like games!', DEFAULT, DEFAULT),
(DEFAULT, 'example5', 'example5@mail.com', 'qiyh4XPJGsOZ2M', 'user5', NULL, NULL, NULL, NULL, 'I like games!', DEFAULT, DEFAULT),
(DEFAULT, 'example6', 'example6@mail.com', 'qiyh4XPJGsOZ2M', 'user6', 'Harry', NULL, NULL, NULL, 'I like games!', DEFAULT, DEFAULT),
(DEFAULT, 'example7', 'example7@mail.com', 'qiyh4XPJGsOZ2M', 'user7', NULL, NULL, NULL, NULL, 'I like games!', DEFAULT, DEFAULT),
(DEFAULT, 'example8', 'example8@mail.com', 'qiyh4XPJGsOZ2M', 'user8', 'John', NULL, NULL, NULL, 'I like games!', DEFAULT, DEFAULT),
(DEFAULT, 'example9', 'example9@mail.com', 'qiyh4XPJGsOZ2M', 'user9', NULL, NULL, NULL, NULL, 'I like games!', DEFAULT, DEFAULT),
(DEFAULT, 'example10', 'example10@mail.com', 'qiyh4XPJGsOZ2M', 'user10', 'John Black', NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);


INSERT INTO orders VALUES
(DEFAULT, '1', 'completed', DEFAULT, DEFAULT),
(DEFAULT, '2', 'completed', DEFAULT, DEFAULT),
(DEFAULT, '3', 'completed', DEFAULT, DEFAULT),
(DEFAULT, '4', 'completed', DEFAULT, DEFAULT),
(DEFAULT, '5', 'completed', DEFAULT, DEFAULT),
(DEFAULT, '6', 'completed', DEFAULT, DEFAULT),
(DEFAULT, '7', 'completed', DEFAULT, DEFAULT),
(DEFAULT, '8', 'completed', DEFAULT, DEFAULT),
(DEFAULT, '10', 'completed', DEFAULT, DEFAULT),
(DEFAULT, '2', 'completed', DEFAULT, DEFAULT);


INSERT INTO orders_products VALUES
(DEFAULT, '1', '1', 1199.00, DEFAULT, DEFAULT), (DEFAULT, '1', '3', 1499.00, DEFAULT, DEFAULT),
(DEFAULT, '1', '5', 399.00, DEFAULT, DEFAULT), (DEFAULT, '1', '7', 1099.00, DEFAULT, DEFAULT),
(DEFAULT, '1', '8', 2499.00, DEFAULT, DEFAULT), (DEFAULT, '1', '10', 725.00, DEFAULT, DEFAULT),
(DEFAULT, '1', '12', 1999.00, DEFAULT, DEFAULT), (DEFAULT, '2', '2', 699.00, DEFAULT, DEFAULT),
(DEFAULT, '2', '4', 799.00, DEFAULT, DEFAULT), (DEFAULT, '2', '5', 399.00, DEFAULT, DEFAULT),
(DEFAULT, '3', '12', 1999.00, DEFAULT, DEFAULT), (DEFAULT, '4', '1', 1199.00, DEFAULT, DEFAULT),
(DEFAULT, '4', '2', 699.00, DEFAULT, DEFAULT), (DEFAULT, '4', '3', 1499.00, DEFAULT, DEFAULT),
(DEFAULT, '4', '4', 799.00, DEFAULT, DEFAULT), (DEFAULT, '4', '5', 399.00, DEFAULT, DEFAULT),
(DEFAULT, '4', '6', 259.00, DEFAULT, DEFAULT), (DEFAULT, '4', '7', 1099.00, DEFAULT, DEFAULT),
(DEFAULT, '4', '8', 2499.00, DEFAULT, DEFAULT), (DEFAULT, '4', '9', 515.00, DEFAULT, DEFAULT),
(DEFAULT, '4', '10', 725.00, DEFAULT, DEFAULT), (DEFAULT, '4', '11', 1499.00, DEFAULT, DEFAULT),
(DEFAULT, '4', '12', 1999.00, DEFAULT, DEFAULT), (DEFAULT, '5', '2', 699.00, DEFAULT, DEFAULT),
(DEFAULT, '5', '10', 725.00, DEFAULT, DEFAULT), (DEFAULT, '5', '1', 1199.00, DEFAULT, DEFAULT),
(DEFAULT, '6', '1', 1199.00, DEFAULT, DEFAULT), (DEFAULT, '6', '10', 725.00, DEFAULT, DEFAULT),
(DEFAULT, '7', '2', 699.00, DEFAULT, DEFAULT), (DEFAULT, '7', '12', 1999.00, DEFAULT, DEFAULT),
(DEFAULT, '8', '8', 2499.00, DEFAULT, DEFAULT), (DEFAULT, '8', '4', 799.00, DEFAULT, DEFAULT),
(DEFAULT, '10', '1', 725.00, DEFAULT, DEFAULT);


/*
	Данные в таблицу user_collections вставляются с помощью триггера, который извлекает информацию
	из таблиц orders и orders_products. Но можно вставить и отдельным запросом.
	
	INSERT INTO user_collections VALUES
	('1', '1', DEFAULT, DEFAULT), ('1', '3', DEFAULT, DEFAULT), ('1', '5', DEFAULT, DEFAULT),
	('1', '7', DEFAULT, DEFAULT), ('1', '8', DEFAULT, DEFAULT), ('1', '10', DEFAULT, DEFAULT),
	('1', '12', DEFAULT, DEFAULT), ('2', '2', DEFAULT, DEFAULT), ('2', '4', DEFAULT, DEFAULT),
	('2', '5', DEFAULT, DEFAULT), ('2', '1', DEFAULT, DEFAULT), ('3', '12', DEFAULT, DEFAULT),
	('4', '1', DEFAULT, DEFAULT), ('4', '2', DEFAULT, DEFAULT), ('4', '3', DEFAULT, DEFAULT),
	('4', '4', DEFAULT, DEFAULT), ('4', '5', DEFAULT, DEFAULT), ('4', '6', DEFAULT, DEFAULT),
	('4', '7', DEFAULT, DEFAULT), ('4', '8', DEFAULT, DEFAULT), ('4', '9', DEFAULT, DEFAULT),
	('4', '10', DEFAULT, DEFAULT), ('4', '11', DEFAULT, DEFAULT), ('4', '12', DEFAULT, DEFAULT),
	('5', '2', DEFAULT, DEFAULT), ('5', '10', DEFAULT, DEFAULT), ('5', '1', DEFAULT, DEFAULT),
	('6', '1', DEFAULT, DEFAULT), ('6', '10', DEFAULT, DEFAULT), ('7', '2', DEFAULT, DEFAULT), 
	('7', '12', DEFAULT, DEFAULT), ('8', '8', DEFAULT, DEFAULT), ('8', '4', DEFAULT, DEFAULT);
*/


INSERT INTO friends VALUES
('1', '2', 'requested', DEFAULT, DEFAULT), ('1', '3', 'requested', DEFAULT, DEFAULT),
('1', '5', 'requested', DEFAULT, DEFAULT), ('1', '6', 'requested', DEFAULT, DEFAULT), 
('3', '2', 'requested', DEFAULT, DEFAULT), ('3', '4', 'requested', DEFAULT, DEFAULT), 
('5', '2', 'requested', DEFAULT, DEFAULT), ('5', '10', 'requested', DEFAULT, DEFAULT), 
('10', '1', 'requested', DEFAULT, DEFAULT), ('10', '2', 'requested', DEFAULT, DEFAULT), 
('10', '3', 'requested', DEFAULT, DEFAULT), ('10', '4', 'requested', DEFAULT, DEFAULT), 
('7', '1', 'requested', DEFAULT, DEFAULT), ('7', '8', 'requested', DEFAULT, DEFAULT), 
('7', '9', 'requested', DEFAULT, DEFAULT), ('7', '10', 'requested', DEFAULT, DEFAULT), 
('9', '1', 'requested', DEFAULT, DEFAULT), ('9', '2', 'requested', DEFAULT, DEFAULT);

UPDATE friends SET relation_status = 'approved';

INSERT INTO friends_messages VALUES
(DEFAULT, '1', '2', 'quis pharetra elit. Aenean sit amet', DEFAULT, DEFAULT),
(DEFAULT, '1', '2', 'mauris elit fringilla libero', DEFAULT, DEFAULT),
(DEFAULT, '2', '1', 'pulvinar eget lobortis sit amet', DEFAULT, DEFAULT),
(DEFAULT, '10', '1', 'quis pharetra elit. Aenean sit amet', DEFAULT, DEFAULT),
(DEFAULT, '10', '3', 'quis pharetra elit. Aenean sit amet', DEFAULT, DEFAULT);


INSERT INTO community_groups VALUES
(DEFAULT, 'we love games', 'public group', DEFAULT, DEFAULT),
(DEFAULT, 'we hate games', 'public group', DEFAULT, DEFAULT),
(DEFAULT, 'play together', 'public group', DEFAULT, DEFAULT);


INSERT INTO users_groups VALUES
('1', '1', DEFAULT, DEFAULT), ('1', '2', DEFAULT, DEFAULT), ('2', '1', DEFAULT, DEFAULT),
('3', '3', DEFAULT, DEFAULT), ('4', '2', DEFAULT, DEFAULT), ('5', '1', DEFAULT, DEFAULT),
('6', '1', DEFAULT, DEFAULT), ('6', '2', DEFAULT, DEFAULT), ('6', '3', DEFAULT, DEFAULT),
('8', '1', DEFAULT, DEFAULT), ('9', '2', DEFAULT, DEFAULT), ('10', '1', DEFAULT, DEFAULT);


INSERT INTO content_types VALUES
(DEFAULT, 'screenshot', DEFAULT, DEFAULT), (DEFAULT, 'artwork', DEFAULT, DEFAULT),
(DEFAULT, 'video', DEFAULT, DEFAULT), (DEFAULT, 'news', DEFAULT, DEFAULT),
(DEFAULT, 'guides', DEFAULT, DEFAULT), (DEFAULT, 'reviews', DEFAULT, DEFAULT);


INSERT INTO content VALUES
(DEFAULT, '1', '1', '1', NULL, 'screenshot1.jpg', NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '1', '1', '1', NULL, 'screenshot2.jpg', NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '1', '1', '1', NULL, 'screenshot3.jpg', NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '2', '2', NULL, NULL, 'artwork1.jpg', NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '2', '2', NULL, NULL, 'artwork2.jpg', NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '1', '1', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '2', '1', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '3', '1', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '4', '1', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '5', '1', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '3', '2', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '5', '2', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '7', '3', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '1', '3', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '1', '4', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '2', '4', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '3', '4', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '1', '6', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '2', '6', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '3', '6', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '1', '8', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '2', '8', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT),
(DEFAULT, '6', '3', '8', 'pulvinar eget lobortis sit amet', NULL, NULL, NULL, DEFAULT, DEFAULT);


INSERT INTO recommendations VALUES
(DEFAULT, '2', '2', 'yes', DEFAULT, DEFAULT), (DEFAULT, '2', '3', 'yes', DEFAULT, DEFAULT),
(DEFAULT, '2', '1', 'no', DEFAULT, DEFAULT), (DEFAULT, '1', '4', 'yes', DEFAULT, DEFAULT),
(DEFAULT, '1', '6', 'yes', DEFAULT, DEFAULT), (DEFAULT, '2', '7', 'yes', DEFAULT, DEFAULT),
(DEFAULT, '3', '8', 'yes', DEFAULT, DEFAULT), (DEFAULT, '4', '9', 'yes', DEFAULT, DEFAULT),
(DEFAULT, '5', '10', 'no', DEFAULT, DEFAULT), (DEFAULT, '8', '5', 'no', DEFAULT, DEFAULT),
(DEFAULT, '1', '11', 'yes', DEFAULT, DEFAULT), (DEFAULT, '2', '12', 'no', DEFAULT, DEFAULT),
(DEFAULT, '1', '13', 'no', DEFAULT, DEFAULT), (DEFAULT, '2', '14', 'yes', DEFAULT, DEFAULT),
(DEFAULT, '1', '15', 'yes', DEFAULT, DEFAULT), (DEFAULT, '2', '16', 'yes', DEFAULT, DEFAULT),
(DEFAULT, '3', '17', 'no', DEFAULT, DEFAULT), (DEFAULT, '1', '18', 'yes', DEFAULT, DEFAULT),
(DEFAULT, '2', '19', 'yes', DEFAULT, DEFAULT), (DEFAULT, '3', '20', 'yes', DEFAULT, DEFAULT),
(DEFAULT, '3', '21', 'yes', DEFAULT, DEFAULT), (DEFAULT, '1', '22', 'yes', DEFAULT, DEFAULT),
(DEFAULT, '2', '23', 'no', DEFAULT, DEFAULT);


INSERT INTO content_comments VALUES
('1', '4', 'pulvinar eget lobortis', DEFAULT, DEFAULT), ('1', '5', 'pulvinar eget lobortis', DEFAULT, DEFAULT),
('4', '7', 'pulvinar eget lobortis', DEFAULT, DEFAULT), ('3', '8', 'pulvinar eget lobortis', DEFAULT, DEFAULT),
('1', '10', 'pulvinar eget lobortis', DEFAULT, DEFAULT), ('10', '18', 'pulvinar eget lobortis', DEFAULT, DEFAULT);
