/*
	Задание 1.
	Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
*/

INSERT INTO orders (user_id) VALUES (3), (1), (2), (3), (2);

-- Выводим id и имена пользователей, которые сделали один или более заказов
SELECT id, name FROM users WHERE id IN (SELECT user_id FROM orders);



/*
	Задание 2.
	Выведите список товаров products и разделов catalogs, который соответствует товару.
*/

SELECT id AS product_id, name AS product_name,
(SELECT name FROM catalogs WHERE catalogs.id = products.catalog_id) AS catalog_section_name FROM products;

-- Или с использованием JOIN
SELECT p.id, p.name, c.name FROM catalogs AS c JOIN products AS p ON c.id = p.catalog_id;



/*
	Задание 3.
	(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
	Поля from, to и label содержат английские названия городов, поле name — русское.
	Выведите список рейсов flights с русскими названиями городов.
*/

CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(255),
  `to` VARCHAR(255)
);

CREATE TABLE cities (
  id SERIAL PRIMARY KEY,
  label VARCHAR(255),
  name VARCHAR(255)
);

INSERT INTO flights (`from`, `to`) VALUES
('moscow', 'omsk'),
('novgorod', 'kazan'),
('irkutsk', 'moscow'),
('omsk', 'irkutsk'),
('moscow', 'kazan');

INSERT INTO cities (label, name) VALUES
('moscow', 'Москва'),
('irkutsk', 'Иркутск'),
('novgorod', 'Новгород'),
('kazan', 'Казань'),
('omsk', 'Омск');

-- Выводим список рейсов flights с русскими названиями городов
SELECT id, 
(SELECT name FROM cities WHERE cities.label = flights.`from`) AS `from`,
(SELECT name FROM cities WHERE cities.label = flights.`to`) AS `to` FROM flights;
