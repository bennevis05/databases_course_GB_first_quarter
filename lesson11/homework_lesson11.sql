-- ПРАКТИЧЕСКОЕ ЗАДАНИЕ ПО ТЕМЕ “Оптимизация запросов”
/*
 	Задание 1.
 	Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs
 	и products в таблицу logs помещается время и дата создания записи, название таблицы,
 	идентификатор первичного ключа и содержимое поля name.
*/

-- Создаем таблицу типа Archive
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME,
	table_name VARCHAR(255),
	field_id INT,
	field_content VARCHAR(255)
)ENGINE=Archive;

/*
	Создадим триггер для каждой таблицы, который будет после вставки в таблицы
	users, catalogs или products, добавлять последние записи из этих таблиц в таблицу logs
*/

DROP TRIGGER IF EXISTS insert_users;

-- Создаем триггер на вставку в users
DELIMITER //
CREATE TRIGGER insert_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs VALUES (
	(SELECT NEW.created_at FROM users WHERE id = NEW.id),
	'users',
	NEW.id,
	(SELECT NEW.name FROM users WHERE id = NEW.id));
END
DELIMITER ;

INSERT INTO users (name) VALUES
('Алексей');

SELECT * FROM logs;


DROP TRIGGER IF EXISTS insert_catalogs;

-- Создаем триггер на вставку в catalogs
DELIMITER //
CREATE TRIGGER insert_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs VALUES (
	NOW(),
	'catalogs',
	NEW.id,
	(SELECT NEW.name FROM catalogs WHERE id = NEW.id));
END
DELIMITER ;

INSERT INTO catalogs (name) VALUES
('Кулеры');

SELECT * FROM logs;


DROP TRIGGER IF EXISTS insert_products;

-- Создаем триггер на вставку в products
DELIMITER //
CREATE TRIGGER insert_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs VALUES (
	(SELECT NEW.created_at FROM products WHERE id = NEW.id),
	'products',
	NEW.id,
	(SELECT NEW.name FROM products WHERE id = NEW.id));
END
DELIMITER ;

INSERT INTO products (name, catalog_id) VALUES
('SAMSUNG S27F358FWI', '6');

SELECT * FROM logs;





/*
 	Задание 2.
 	(по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
*/

/*
	Создадим процедуру для заполения таблицы нужным количеством значений.
	Во время выполнения процедуры, сначала вставим в таблицу два значения,
	на случай если таблица пустая. Далее в цикле вставляем в таблицу значения этой же таблицы,
	объедененные с самими собой с помощью UNION соеденения.
	Таким образом количество вставляемых значений растет в прогрессии и
	за максимум 12 итераций (если таблица была пустая) позволяет вставить чуть более 1 млн. значений.
	Решение данной задачи таким способом позволяет вставить большое количество значений относительно быстро. 
*/

DROP PROCEDURE IF EXISTS fill_table;

-- Создаем процедуру
DELIMITER //
CREATE PROCEDURE fill_table() 
BEGIN
	DECLARE i INT DEFAULT 0; -- Создаем переменную-счетчик
	INSERT INTO users (name) VALUES ('Сергей'), ('Алексей'); -- Вставляем значения на случай если таблица пустая
	WHILE i <= 1000000 DO -- Вставляем значения в таблицу пока переменная-счетчик меньше или равна 1 млн.
		INSERT INTO users (name)
		SELECT u1.name FROM users AS u1
		UNION ALL
		SELECT u2.name FROM users AS u2;
		SET i = (SELECT COUNT(*) FROM users); -- Изменяем значение переменной, присваивая значение общего количества строк
	END WHILE; 
END
DELIMITER ;

-- Заполняем таблицу
CALL fill_table();

-- Проверяем количество строк в таблице
SELECT COUNT(*) AS total_rows FROM users;







-- ПРАКТИЧЕСКОЕ ЗАДАНИЕ ПО ТЕМЕ “NoSQL”
/*
 	Задание 1.
 	В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов. 
*/

-- Думаю, что для решения данной задачи подойдет тип данных Хэш

/*
 	Сначала создадим ключ, например users:ip, с которым ассоциируем поля, все IP адреса
 	со значениями в виде целого числа. После каждого посещения с определенного IP адреса
 	можем увеличивать числовое значение на единицу. Далее в любой момент можно запросить
 	значение данного поля, число будет равно количеству посещений.
*/

HMSET users:ip 127.0.0.1 1 127.0.0.2 1
HINCRBY users:ip 127.0.0.1 1
HGET users:ip 127.0.0.1





/*
 	Задание 2.
 	При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот,
 	поиск электронного адреса пользователя по его имени.
*/

-- Создаем хэш с полями в виде имен пользователей и значениями в виде email
HMSET emails:by:name John john@example.com Harry harry1992@example.com

-- Получаем email пользователя по имени
HGET emails:by:name John
HGET emails:by:name Harry

-- Так как нет возможности получить поле по значению, а только значение по полю, создадим еще один хеш
HMSET name:by:emails john@example.com John harry1992@example.com Harry
HGET name:by:emails john@example.com
HGET name:by:emails harry1992@example.com





/*
 	Задание 3.
 	Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB
*/

/*
 	Так как значения ключей в JSON документе допускают произвольную глубину вложений, можем 
 	значением первого ключа установить массив. Этот массив будет включать в себя другие JSON документы
 	значениеми первых ключей которых также будут массивы из нескольких JSON документов.
*/

db.shop.insert({'catalogs_and_products': [
	{'Процессоры': [
		{'name': 'Intel Core i3-8100', 'description': 'Процессор для компьютеров', 'price', '7890.00', 'created_at': '2019-11-27 10:57:02'},
		{'name': 'Intel Core i5-7400', 'description': 'Процессор для компьютеров', 'price', '12700.00', 'created_at': '2019-11-27 10:57:02'},
		{'name': 'AMD FX-8320E', 'description': 'Процессор для компьютеров', 'price', '4780.00', 'created_at': '2019-11-27 10:57:02'},
		{'name': 'AMD FX-8320', 'description': 'Процессор для компьютеров', 'price', '7120.00', 'created_at': '2019-11-27 10:57:02'}
	]},
	{'Материнские платы': [
		{'name': 'ASUS ROG MAXIMUS X HERO', 'description': 'Материнская плата', 'price', '19310.00', 'created_at': '2019-11-27 10:57:02'},
		{'name': 'Gigabyte H310M S2H', 'description': 'Материнская плата', 'price', '4790.00', 'created_at': '2019-11-27 10:57:02'},
		{'name': 'MSI B250M GAMING PRO', 'description': 'Материнская плата', 'price', '5060.00', 'created_at': '2019-11-27 10:57:02'}
	]}
]})
