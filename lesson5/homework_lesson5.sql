/*
 	ПРАКТИЧЕСКОЕ ЗАДАНИЕ ПО ТЕМЕ "Операторы, фильтрация, сортировка и ограничение"

 	Задание 1.
 	Пусть в таблице users поля created_at и updated_at оказались незаполненными.
 	Заполните их текущими датой и временем.
 */

DROP TABLE IF EXISTS users;

-- Создаем таблицу
CREATE TABLE users
(id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
fname VARCHAR(255),
lname VARCHAR(255),
birth_date DATE,
created_at DATETIME,
updated_at DATETIME);

-- Заполняем таблицу
INSERT INTO users VALUES 
('1','et','sit','1986-07-09', NULL, NULL),
('2','est','assumenda','2005-11-08',NULL, NULL),
('3','sapiente','nostrum','2003-01-18',NULL, NULL),
('4','error','labore','1978-04-26',NULL, NULL),
('5','quis','eveniet','2015-09-19',NULL, NULL);

-- Заполняем значения полей created_at и updated_at текущими датой и временем
UPDATE users SET
created_at = NOW(),
updated_at = NOW();



/*
 	Задание 2.
 	Таблица users была неудачно спроектирована.
 	Записи created_at и updated_at были заданы типом VARCHAR
 	и в них долгое время помещались значения в формате "20.10.2017 8:10".
 	Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
 */

DROP TABLE IF EXISTS users;

-- Создаем таблицу
CREATE TABLE users
(id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
fname VARCHAR(255),
lname VARCHAR(255),
birth_date DATE,
created_at VARCHAR(255),
updated_at VARCHAR(255));

-- Заполняем таблицу нужными для форматирования значениями
INSERT INTO users VALUES 
('1','et','sit','1986-07-09','22.10.2017 8:10','22.10.2017 8:10'),
('2','est','assumenda','2005-11-08','22.10.2017 8:10','22.10.2017 8:10'),
('3','sapiente','nostrum','2003-01-18','22.10.2017 8:10','22.10.2017 8:10'),
('4','error','labore','1978-04-26','22.10.2017 8:10','22.10.2017 8:10'),
('5','quis','eveniet','2015-09-19','22.10.2017 8:10','22.10.2017 8:10'),
('6','ullam','quidem','1998-08-25','22.10.2017 8:10','22.10.2017 8:10'),
('7','et','nesciunt','1993-02-24','22.10.2017 8:10','22.10.2017 8:10'),
('8','explicabo','eveniet','2000-08-19','22.10.2017 8:10','22.10.2017 8:10'),
('9','doloribus','maxime','1987-10-30','22.10.2017 8:10','22.10.2017 8:10'),
('10','non','omnis','1986-10-05','22.10.2017 8:10','22.10.2017 8:10'),
('11','maxime','aperiam','1974-10-15','22.10.2017 8:10','22.10.2017 8:10'),
('12','ratione','consequatur','2010-06-06','22.10.2017 8:10','22.10.2017 8:10'),
('13','eveniet','aut','1990-11-20','22.10.2017 8:10','22.10.2017 8:10'),
('14','id','omnis','2007-03-17','22.10.2017 8:10','22.10.2017 8:10'),
('15','magni','velit','1989-12-19','22.10.2017 8:10','22.10.2017 8:10'),
('16','omnis','facere','1988-07-29','22.10.2017 8:10','22.10.2017 8:10'),
('17','ut','voluptatum','1971-10-23','22.10.2017 8:10','22.10.2017 8:10'),
('18','modi','impedit','1987-12-16','22.10.2017 8:10','22.10.2017 8:10'),
('19','quasi','eligendi','2002-11-19','22.10.2017 8:10','22.10.2017 8:10'),
('20','deserunt','animi','1971-05-17','22.10.2017 8:10','22.10.2017 8:10');

-- Изменяем значения полей created_at и updated_at в соответсвии с нужным форматом
UPDATE users SET
created_at = (SELECT DATE_FORMAT(STR_TO_DATE(users.created_at, '%d.%m.%Y %k:%i'), '%Y-%m-%d %H:%i:00')),
updated_at = (SELECT DATE_FORMAT(STR_TO_DATE(users.updated_at, '%d.%m.%Y %k:%i'), '%Y-%m-%d %H:%i:00'));

-- Изменяем тип данных полей created_at и updated_at
ALTER TABLE users MODIFY created_at DATETIME, MODIFY updated_at DATETIME;



/*
 	Задание 3.
 	В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
 	0, если товар закончился и выше нуля, если на складе имеются запасы.
 	Необходимо отсортировать записи таким образом, чтобы они выводились в порядке
 	увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
 */

DROP TABLE IF EXISTS storehouses_products;

-- Создаем таблицу
CREATE TABLE storehouses_products
(id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
value INT);

-- Заполняем таблицу значениями
INSERT INTO storehouses_products VALUES
('1','7'), ('2','0'), ('3','1'), ('4','1'), ('5','2'), ('6','3'), ('7','6'),
('8','5'), ('9','7'), ('10','9'), ('11','9'), ('12','7'), ('13','0'), ('14','5'),
('15','8'), ('16','0'), ('17','1'), ('18','8'), ('19','0'),('20','1');

-- Выбираем значения value с нужной сортировкой
SELECT * FROM storehouses_products ORDER BY value < 1, value;



/*
 	Задание 4.
 	(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
 	Месяцы заданы в виде списка английских названий ('may', 'august')
 */

DROP TABLE IF EXISTS users;

-- Создаем таблицу
CREATE TABLE users
(id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
fname VARCHAR(255),
lname VARCHAR(255),
birth_date DATE,
created_at DATETIME,
updated_at DATETIME);

-- Заполняем таблицу
INSERT INTO users VALUES
('1','magni','velit','1989-12-19',NOW(),NOW()),
('2','omnis','facere','1988-08-29',NOW(),NOW()),
('3','ut','voluptatum','1971-10-23',NOW(),NOW()),
('4','modi','impedit','1987-08-16',NOW(),NOW()),
('5','quasi','eligendi','2002-11-19',NOW(),NOW()),
('6','deserunt','animi','1971-05-17',NOW(),NOW()),
('7','ullam','quidem','1998-08-25',NOW(),NOW()),
('8','et','nesciunt','1993-05-24',NOW(),NOW()),
('9','explicabo','eveniet','2000-08-19',NOW(),NOW()),
('10','doloribus','maxime','1987-10-30',NOW(),NOW());

-- Выбираем нужные значения и выводим в нужном формате
SELECT id, fname, lname, DATE_FORMAT(birth_date, '%M') AS birth_month
FROM users WHERE DATE_FORMAT(birth_date, '%M') = 'May'
OR DATE_FORMAT(birth_date, '%M') = 'August' ORDER BY birth_month DESC;



/*
 	Задание 5.
 	(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
 	SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
 	Отсортируйте записи в порядке, заданном в списке IN.
 */

DROP TABLE IF EXISTS catalogs;

-- Создаем таблицу
CREATE TABLE catalogs
(id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255),
created_at DATETIME DEFAULT NOW(),
updated_at DATETIME DEFAULT NOW());

-- Заполняем таблицу
INSERT INTO catalogs (id, name) VALUES
('1','officia'), ('2','aut'), ('3','in'), ('4','voluptatum'), ('5','eligendi'),
('6','reprehenderit'), ('7','praesentium'), ('8','error'), ('9','est'), ('10','consequuntur');

-- Выбираем значения value с нужной сортировкой
SELECT * FROM catalogs WHERE id IN(5,1,2) ORDER BY id = 2, id = 1, id = 5;





/*
	ПРАКТИЧЕСКОЕ ЗАДАНИЕ ПО ТЕМЕ "Агрегация данных"
	
	Задание 1.
	Подсчитайте средний возраст пользователей в таблице users
*/

DROP TABLE IF EXISTS users;

-- Создаем таблицу
CREATE TABLE users
(id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
fname VARCHAR(255),
lname VARCHAR(255),
birth_date DATE,
created_at DATETIME,
updated_at DATETIME);

-- Заполняем таблицу
INSERT INTO users VALUES
('1','magni','velit','1989-12-19',NOW(),NOW()),
('2','omnis','facere','1988-08-29',NOW(),NOW()),
('3','ut','voluptatum','1971-10-23',NOW(),NOW()),
('4','modi','impedit','1987-08-16',NOW(),NOW()),
('5','quasi','eligendi','2002-11-19',NOW(),NOW()),
('6','deserunt','animi','1971-05-17',NOW(),NOW()),
('7','ullam','quidem','1998-08-25',NOW(),NOW()),
('8','et','nesciunt','1993-05-24',NOW(),NOW()),
('9','explicabo','eveniet','2000-08-19',NOW(),NOW()),
('10','doloribus','maxime','1987-10-30',NOW(),NOW());

-- Получаем средний возраст пользователей в таблице users с округлением до 2-ух десятичных знаков
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birth_date, CURDATE())), 2) AS avg_age FROM users;



/*
	Задание 2.
	Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
	Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/

DROP TABLE IF EXISTS users;

-- Создаем таблицу
CREATE TABLE users
(id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
fname VARCHAR(255),
lname VARCHAR(255),
birth_date DATE,
created_at DATETIME,
updated_at DATETIME);

-- Заполняем таблицу
INSERT INTO users VALUES
('1','magni','velit','1989-12-19',NOW(),NOW()),
('2','omnis','facere','1988-08-29',NOW(),NOW()),
('3','ut','voluptatum','1971-10-23',NOW(),NOW()),
('4','modi','impedit','1987-08-16',NOW(),NOW()),
('5','quasi','eligendi','2002-11-19',NOW(),NOW()),
('6','deserunt','animi','1971-05-17',NOW(),NOW()),
('7','ullam','quidem','1998-08-25',NOW(),NOW()),
('8','et','nesciunt','1993-05-24',NOW(),NOW()),
('9','explicabo','eveniet','2000-08-19',NOW(),NOW()),
('10','doloribus','maxime','1987-10-30',NOW(),NOW());

-- Формируем следующий запрос:
SELECT GROUP_CONCAT(fname SEPARATOR ', ') AS names,
COUNT(*) AS total,
DATE_FORMAT(CONVERT(CONCAT(YEAR(NOW()), '-', MONTH(birth_date), '-', DAY(birth_date)), DATE), '%W')
AS day_of_week_in_current_year FROM users GROUP BY day_of_week_in_current_year;
/*
 	В данном запросе сначала с помощью функций YEAR(), MONTH() и DAY() извлекаем текущий год,
 	а также месяц и день из даты рождения пользователя, из поля таблицы birth_date в виде отдельных строк
 	Далее объеденяем строки в одну строку с помощью функции CONCAT() и функцией CONVERT() конвертруем тип
 	данных в DATE. Полученную дату передаем в функцию DATE_FORMAT() и получаем с помощью данной функции
 	наименование дня недели.
 	После этого группируем с помощью GROUP BY и выводим дополнительные поля с помощью
 	CROUP_CONCAT() и COUNT() для отображения имен пользователей и общего количества родившихся
 	в данный день недели в текущем году.
 */

/*
	Задание 3.
	(по желанию) Подсчитайте произведение чисел в столбце таблицы
*/

DROP TABLE IF EXISTS users;

-- Создаем таблицу
CREATE TABLE users
(id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
value INT UNSIGNED);

-- Заполняем таблицу
INSERT INTO users VALUES
('1','3'), ('2','5'), ('3','7'), ('4','2'), ('5','1'), ('6','3');

/* Так как среди агрегатных функций SQL нет функции для нахождения произведения ряда чисел,
 	можем воспользоваться свойством натурального логарифма в соответствие с которым,
 	логарифм произведения равен сумме логарифмов и используем функции ln() и avg().
 	Но данный вариант сработает только с положительными числами.
 	Для другого случая необходимо писать более сложный запрос с условиями. 
 */
SELECT ROUND(EXP(SUM(LN(value)))) AS product FROM users;
