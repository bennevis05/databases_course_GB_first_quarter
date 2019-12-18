/*
	СКРИПТЫ ХАРАКТЕРНЫХ ВЫБОРОК;
	ПРЕДСТАВЛЕНИЯ (МИНИМУМ 2);
	ХРАНИМЫЕ ПРОЦЕДУРЫ/ТРИГГЕРЫ
*/

-- Характерной выборкой является получение списка самых продоваемых игр
SELECT title FROM products WHERE category_name = 'game' ORDER BY total_sold DESC;

-- Выборка для получения новых игр. Например не старше начала текущего года
SELECT title FROM products WHERE release_date > '2019-01-01';

-- Выборка для получения списка еще не вышедших игр
SELECT title FROM products WHERE release_date IS NULL;

-- Список игр стоимостью не более определенного значения
SELECT title FROM products WHERE price <= 1000;

-- Создадим представление которое сохраняет название продукта и соответствующую ему категорию
CREATE OR REPLACE VIEW prod_cat AS
	SELECT p.title, pc.name FROM products p
	JOIN product_category pc ON p.category_name = pc.name;

-- Получаем данные из созданного представления
SELECT * FROM prod_cat;


-- Создадим представление которое сохраняет название продукта и разработчика данного продукта
CREATE OR REPLACE VIEW product_dev AS
	SELECT p.title, dp.name FROM products p
	JOIN developers_and_publishers dp ON dp.name = p.publisher;

-- Получаем данные из созданного представления
SELECT * FROM product_dev;


-- Выборки продуктов по жанрам
SELECT title FROM products p 
JOIN product_genre pg ON p.id = pg.product_id
WHERE pg.genre_name = 'rpg';

SELECT title FROM products p 
JOIN product_genre pg ON p.id = pg.product_id
WHERE pg.genre_name = 'rpg' OR pg.genre_name = 'action';

SELECT title FROM products p 
JOIN product_genre pg1 ON p.id = pg1.product_id
JOIN product_genre pg2 ON p.id = pg2.product_id
WHERE pg1.genre_name = 'rpg' AND pg2.genre_name = 'strategy';


-- Выборки продуктов по тэгам
SELECT title FROM products p 
JOIN product_tag pt1 ON p.id = pt1.product_id
WHERE pt1.tag_name = 'rpg';

SELECT title FROM products p 
JOIN product_tag pt1 ON p.id = pt1.product_id
JOIN product_tag pt2 ON p.id = pt2.product_id
WHERE pt1.tag_name = 'rpg' AND pt2.tag_name = 'atmospheric';


-- Выборка продуктов по языкам
SELECT p.title FROM product_language pl
JOIN products p ON p.id = pl.product_id
WHERE pl.`language` = 'thai';


-- Список пользователей совершивших одну или более покупок
SELECT uc.user_id, u.profile_name FROM user_collections uc
JOIN users u ON uc.user_id = u.id
GROUP BY uc.user_id;

-- Получаем общую сумму отдельного заказа
SELECT SUM(product_price) AS total FROM orders_products op 
JOIN orders o ON op.order_id = o.id
WHERE o.id = 1;

-- Получаем среднюю сумму отдельного заказа
SELECT AVG(product_price) AS average FROM orders_products op 
JOIN orders o ON op.order_id = o.id
WHERE o.id = 1;


-- Список друзей пользователя
SELECT u.id AS friend_id, u.profile_name AS friends FROM friends f
JOIN users u ON f.target_user_id = u.id
WHERE initiator_user_id = '1' AND relation_status = 'approved'
UNION
SELECT u.id AS friend_id, u.profile_name FROM friends f
JOIN users u ON f.initiator_user_id = u.id
WHERE target_user_id = '1' AND relation_status = 'approved';


-- Можем получить список игр, которые есть у друзей
SELECT p.title FROM user_collections uc
JOIN products p ON uc.product_id = p.id
WHERE user_id IN(
	SELECT u.id AS friend_id FROM friends f
	JOIN users u ON f.target_user_id = u.id
	WHERE initiator_user_id = '1' AND relation_status = 'approved'
	UNION
	SELECT u.id AS friend_id FROM friends f
	JOIN users u ON f.initiator_user_id = u.id
	WHERE target_user_id = '1' AND relation_status = 'approved') GROUP BY p.title;

-- Для этой же цели можем создать процедуру, которая будет выводить список игр друзей указанного пользователя
DROP PROCEDURE IF EXISTS friends_games;
DELIMITER //
CREATE PROCEDURE friends_games(IN for_user_id INT) 
BEGIN 
	SELECT p.title FROM user_collections uc
	JOIN products p ON uc.product_id = p.id
	WHERE user_id IN(
	SELECT u.id AS friend_id FROM friends f
	JOIN users u ON f.target_user_id = u.id
	WHERE initiator_user_id = for_user_id AND relation_status = 'approved'
	UNION
	SELECT u.id AS friend_id FROM friends f
	JOIN users u ON f.initiator_user_id = u.id
	WHERE target_user_id = for_user_id AND relation_status = 'approved') GROUP BY p.title;
END
DELIMITER ;
-- На основании полученого списка продуктов друзей, можем рекомендовать эти продукты пользователю
-- Вызываем процедуру
CALL friends_games('1');
CALL friends_games('2');
CALL friends_games('3');



-- Можем посмотреть все ревью на отдельный продукт и рекомендации пользователей на него
SELECT c.content_type_id, c.product_id, r.recommendation FROM content c 
JOIN recommendations r ON r.content_id = c.id
WHERE c.content_type_id = '6' AND c.product_id = '1';

-- Или посчитать их количество
SELECT COUNT(*) FROM content c 
JOIN recommendations r ON r.content_id = c.id
WHERE c.content_type_id = '6' AND c.product_id = '1' AND r.recommendation = 'yes';

SELECT COUNT(*) FROM content c 
JOIN recommendations r ON r.content_id = c.id
WHERE c.content_type_id = '6' AND c.product_id = '1' AND r.recommendation = 'no';

/*
	У каждого продукта есть пользовательский рейтинг, который основывается на рекомендациях пользователей
	и расчитывается на отношении положительных и отрицательных рекомендаций
*/
-- Для такого расчета создадим процедуру
DROP PROCEDURE IF EXISTS user_rating;
DELIMITER //
CREATE PROCEDURE user_rating(IN for_prod_id INT)
BEGIN 
	DECLARE total_rec INT;
	DECLARE positive_rec INT;
	DECLARE rating FLOAT;
	SET total_rec = (SELECT COUNT(*) FROM content c 
		JOIN recommendations r ON r.content_id = c.id
		WHERE c.content_type_id = '6' AND c.product_id = for_prod_id);
	SET positive_rec = (SELECT COUNT(*) FROM content c 
		JOIN recommendations r ON r.content_id = c.id
		WHERE c.content_type_id = '6' AND c.product_id = for_prod_id AND r.recommendation = 'yes');
	SET rating = positive_rec / total_rec;
	SELECT ROUND(rating, 2);
END
DELIMITER ;

-- Получаем пользовательский рейтинг указанного продукта
CALL user_rating('1');
CALL user_rating('8');


/*
	Некоторые триггеры были созданы на этапе заполения таблиц базы данных.
	Здесь дублирую информацию о функциях выполняемыми триггерами

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
