-- ПРАКТИЧЕСКОЕ ЗАДАНИЕ ПО ТЕМЕ “Транзакции, переменные, представления”

/*
 	ЗАДАНИЕ 1.
 	В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
 	Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
*/

START TRANSACTION;
INSERT INTO sample.users (id, name, birthday_at, created_at, updated_at) SELECT * FROM shop.users WHERE id = 1;
COMMIT;





/*
 	ЗАДАНИЕ 2.
 	Создайте представление, которое выводит название name товарной позиции из таблицы products
 	и соответствующее название каталога name из таблицы catalogs.
*/

CREATE VIEW prod_cat AS
SELECT p.name AS product_name, c.name AS catalog_name FROM products AS p
RIGHT JOIN catalogs AS c ON p.catalog_id = c.id;

SELECT * FROM prod_cat;





/*
 	ЗАДАНИЕ 3.
 	(по желанию) Пусть имеется таблица с календарным полем created_at.
 	В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
 	Составьте запрос, который выводит полный список дат за август,
 	выставляя в соседнем поле значение 1, если дата присутствует в исходной таблице и 0, если она отсутствует.
*/

-- Заполним таблицу users данными для примера
INSERT INTO users (name, created_at) VALUES
('Сергей', NULL),
('Наталья', '2018-08-01'),
('Алексей', NULL),
('Людмила', '2018-08-04'),
('Арина', NULL),
('Виктория', '2018-08-16'),
('Анна', NULL),
('Рина', '2018-08-10'),
('Никита', '2018-08-17'),
('Александр', NULL);

-- Для удобства создадим таблицу и наполним ее всеми нужными датами
DROP TABLE IF EXISTS calendar;
CREATE TABLE IF NOT EXISTS calendar(calendar_date DATE NOT NULL PRIMARY KEY);

-- Создадим процедуру для быстрого заполнения таблицы датами

DROP PROCEDURE IF EXISTS FillCalendar;

DELIMITER //
CREATE PROCEDURE FillCalendar(start_date DATE, end_date DATE) 
BEGIN 
	DECLARE crt_date DATE;
	SET crt_date = start_date;
	WHILE crt_date <= end_date DO
		INSERT IGNORE INTO calendar VALUES(crt_date);
		SET crt_date = ADDDATE(crt_date, INTERVAL 1 DAY);
	END WHILE; 
END
DELIMITER ;

CALL FillCalendar('2018-08-01', '2018-08-31');

SELECT c.calendar_date, IF (c.calendar_date = u.created_at, '1', '0') AS flag 
FROM calendar c LEFT JOIN users u ON c.calendar_date = u.created_at ORDER BY c.calendar_date;





/*
 	ЗАДАНИЕ 4.
 	(по желанию) Пусть имеется любая таблица с календарным полем created_at.
 	Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
*/

INSERT INTO users (name, created_at) VALUES
('Сергей', '2019-08-01'),
('Наталья', '2017-08-01'),
('Алексей', '2018-08-01'),
('Людмила', '2018-08-04'),
('Арина', '2014-08-01'),
('Виктория', '2018-08-16'),
('Анна', '2012-08-01'),
('Рина', '2011-08-01'),
('Никита', '2010-08-17'),
('Александр', '2009-08-01');

-- С использованием вложенных запросов
START TRANSACTION;
DELETE FROM users WHERE id NOT IN (SELECT id FROM (SELECT id, created_at FROM users ORDER BY created_at DESC LIMIT 5) AS t);
COMMIT;

-- Или с использованием JOIN
START TRANSACTION;
DELETE FROM users WHERE id NOT IN (SELECT id FROM 
(SELECT u1.id FROM users AS u1 JOIN users AS u2 USING (created_at) ORDER BY u2.created_at DESC LIMIT 5) AS t);
COMMIT;







-- ПРАКТИЧЕСКОЕ ЗАДАНИЕ ПО ТЕМЕ “Администрирование MySQL”

/*
 	ЗАДАНИЕ 1.
 	Создайте двух пользователей которые имеют доступ к базе данных shop.
 	Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
 	второму пользователю shop — любые операции в пределах базы данных shop.
*/

-- Создаем пользователей:
CREATE USER test1 IDENTIFIED WITH sha256_password BY 'testpass';
CREATE USER test2 IDENTIFIED WITH sha256_password BY 'testpass';

-- Первому пользователю даем права на чтение:
GRANT SELECT ON shop.* TO tes1;

-- Второму даем все права в пределах базы данных shop
GRANT ALL ON shop.* TO tes1;





/*
 	ЗАДАНИЕ 2.
 	(по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password,
 	содержащие первичный ключ, имя пользователя и его пароль.
 	Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name.
 	Создайте пользователя user_read, который бы не имел доступа к таблице accounts,
 	однако, мог бы извлекать записи из представления username.
*/

-- Создаем представление
CREATE VIEW username AS
SELECT a.id, a.name FROM accounts AS a;

-- Создаем пользователя
CREATE USER test1 IDENTIFIED WITH sha256_password BY 'testpass';

-- Так как к представлению можно обратиться как к обычной таблице, установим привелегии только на чтение данной таблицы
GRANT SELECT ON shop.username TO tes1;







-- ПРАКТИЧЕСКОЕ ЗАДАНИЕ ПО ТЕМЕ “Хранимые процедуры и функции, триггеры”

/*
 	ЗАДАНИЕ 1.
 	Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
 	С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
 	с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер",
 	с 00:00 до 6:00 — "Доброй ночи".
*/

DROP FUNCTION hello;

DELIMITER //
CREATE FUNCTION hello()
RETURNS TEXT DETERMINISTIC
BEGIN
	DECLARE greet TEXT;
	DECLARE crt_time TIME;
	SET crt_time = HOUR(NOW());
	IF crt_time >= 6 AND crt_time < 12 THEN 
		SET greet = 'Доброе утро!';
	ELSEIF crt_time >= 12 AND crt_time < 18 THEN 
		SET greet = 'Добрый день!';
	ELSEIF crt_time >= 18 AND crt_time <= 23 THEN
		SET greet = 'Добрый вечер!';
	ELSE
		SET greet = 'Доброй ночи!';
	END IF;
	RETURN greet;
END
DELIMITER ;

SELECT hello() AS greetings;





/*
 	ЗАДАНИЕ 2.
 	В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
 	Допустимо присутствие обоих полей или одного из них. Ситуация,
 	когда оба поля принимают неопределенное значение NULL неприемлема.
 	Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
 	При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';


DROP TRIGGER insert_prod;

-- Создаем триггер для проверки вставки
DELIMITER //
CREATE TRIGGER insert_prod BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled. It is necessary to fill in the field "name" or "description"';
	END IF;
END
DELIMITER ;

/*
	При попытке вставить пустые значения в оба поля, срабатывает триггер и выводит ошибку с информацией. Операция отменяется.
	В случае заполнения хотя бы одного поля, ошибки не возникает, операция не отменяется
*/
INSERT INTO products (name, description, price, catalog_id) VALUES
  (NULL, NULL, 7890.00, 1);


DROP TRIGGER update_prod;

-- Создаем триггер для проверки обновления таблицы
DELIMITER //
CREATE TRIGGER update_prod BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SET NEW.name = OLD.name;
		SET NEW.description = OLD.description;
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled. "name" or "description" field cannot be empty.';
	END IF;
END
DELIMITER ;

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1);

/*
	При попытке обновить таблицу и установить новые значения NULL для обоих полей, операция обновления отменяется,
	полям присваиваются старые значения. Выводится информация о причине отмены операции.
	В случае установления значения NULL только для одного триггер не срабатывает. Операция не отменяется.
*/
UPDATE products SET name = NULL, description = NULL WHERE id = 1;





/*
 	ЗАДАНИЕ 3.
 	(по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
 	Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
 	Вызов функции FIBONACCI(10) должен возвращать число 55.

*/
/*
	Первая функция (fibonacci_elem) для получения любого элемента последовательности чисел Фибоначчи.
	FIBONACCI(10) возвращает число 55, так как 55 - это десятый элемент последовательности.
*/

DROP FUNCTION fibonacci_elem;

DELIMITER //
CREATE FUNCTION fibonacci_elem(num INT)
RETURNS TEXT DETERMINISTIC
BEGIN
	DECLARE a INT DEFAULT 0;
	DECLARE b INT DEFAULT 1;
	DECLARE c INT;
	DECLARE n INT DEFAULT 0;
	WHILE n < num DO
		SET c = a;
		SET a = b + c;
		SET b = c;
		SET n = n + 1;
	END WHILE;
	RETURN a;
END
DELIMITER ;

SELECT fibonacci_elem(10);

/*
	Вторая функция (fibonacci_seq) возвращает всю последовательность чисел Фибоначчи,
	последнее число которой не превышает заданного числа.
*/

DROP FUNCTION fibonacci_seq;

DELIMITER //
CREATE FUNCTION fibonacci_seq(num INT)
RETURNS TEXT DETERMINISTIC
BEGIN
	DECLARE a INT DEFAULT 0;
	DECLARE b INT DEFAULT 1;
	DECLARE c INT;
	DECLARE fibo_numbers TEXT DEFAULT '';
	WHILE a < num DO
		SET fibo_numbers = CONCAT(fibo_numbers, CONCAT(a, ' '));
		SET c = a;
		SET a = b + c;
		SET b = c;
	END WHILE;
	RETURN fibo_numbers;
END
DELIMITER ;

SELECT fibonacci_seq(1000);
