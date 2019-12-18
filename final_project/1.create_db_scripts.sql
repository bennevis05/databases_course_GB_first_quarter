/*
	Steam является онлайн-сервисом цифрового распространения компьютерных игр и программного обеспечения.
	Особенностью Steam является то, что данный сервис объединяет в себе интернет магазин и социальную сеть.
	База данных такого сервиса должна обеспечивать хранение данных о распространяемых продуктах,
	а также о пользователях, их взаимодействии друг с другом, и обо всем медиа-контенте создаваемого пользователями.
*/

/*
	СКРИПТЫ СОЗДАНИЯ СТРУКТУРЫ БД
*/

DROP DATABASE IF EXISTS my_steam;
CREATE DATABASE my_steam;
USE my_steam;

-- Создаем таблицу для хранения информации о категориях товаров
DROP TABLE IF EXISTS product_category;
CREATE TABLE product_category (
	name VARCHAR(255) PRIMARY KEY, -- Так как наименование должно быть уникальным, можем использовать поле name как первичный ключ
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Создаем таблицу для хранения информации о разработчиках и издателях програмных продуктов
DROP TABLE IF EXISTS developers_and_publishers;
CREATE TABLE developers_and_publishers (
	name VARCHAR(255) PRIMARY KEY, -- Так как наименование должно быть уникальным, можем использовать поле name как первичный ключ
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Создаем таблицу для хранения информации о товарах
DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	category_name VARCHAR(255) NOT NULL,
	title VARCHAR(255) NOT NULL,
	desription TEXT COMMENT 'Описание товара',
	release_date DATE,
	upcoming_release_date DATE,
	developer VARCHAR(255) NOT NULL COMMENT 'Разработчик',
	publisher VARCHAR(255) COMMENT 'Издатель',
	price DECIMAL(11,2),
	age_rating VARCHAR(4),
	metacritic_rating TINYINT UNSIGNED,
	total_sold INT DEFAULT 0 COMMENT 'Общее количество проданного товара',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	CONSTRAINT fk_cat_name FOREIGN KEY(category_name)
	REFERENCES product_category (name) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_dev_name FOREIGN KEY(developer)
	REFERENCES developers_and_publishers(name) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_publish_name FOREIGN KEY(publisher)
	REFERENCES developers_and_publishers(name) ON DELETE RESTRICT ON UPDATE CASCADE,
	
	INDEX(title),
	INDEX(developer),
	INDEX(price)
);


-- Создаем таблицу для хранения информации о жанрах, который обязателен для многих програмных продуктов
DROP TABLE IF EXISTS genres;
CREATE TABLE genres (
	name VARCHAR(255) PRIMARY KEY, -- Так как наименование должно быть уникальным, можем использовать поле name как первичный ключ
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	INDEX(name)
);


-- Создаем таблицу для отражения связи типа "многие ко многим" для жанров
DROP TABLE IF EXISTS product_genre;
CREATE TABLE product_genre (
	product_id BIGINT UNSIGNED NOT NULL,
	genre_name VARCHAR(255) NOT NULL,
	
	PRIMARY KEY(product_id, genre_name),
	
	CONSTRAINT fk_genre_prod_id FOREIGN KEY(product_id)
	REFERENCES products(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_genre_name FOREIGN KEY(genre_name)
	REFERENCES genres(name) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- Создаем таблицу для хранения информации о тэгах (метках)
DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
	name VARCHAR(255) PRIMARY KEY, -- Так как наименование должно быть уникальным, можем использовать поле name как первичный ключ
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	INDEX(name)
);


-- Создаем таблицу для отражения связи типа "многие ко многим" для тэгов
DROP TABLE IF EXISTS product_tag;
CREATE TABLE product_tag (
	product_id BIGINT UNSIGNED NOT NULL,
	tag_name VARCHAR(255) NOT NULL,
	
	PRIMARY KEY(product_id, tag_name),
	CONSTRAINT fk_tag_prod_id FOREIGN KEY(product_id)
	REFERENCES products(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_tag_name FOREIGN KEY(tag_name)
	REFERENCES tags(name) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- Создаем таблицу для хранения информации о дополнительных особенностях, которые есть у каждого продукта
DROP TABLE IF EXISTS additional_features;
CREATE TABLE additional_features (
	name VARCHAR(255) PRIMARY KEY, -- Так как наименование должно быть уникальным, можем использовать поле name как первичный ключ
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	INDEX(name)
)COMMENT 'Дополнительные особенности';


-- Создаем таблицу для отражения связи типа "многие ко многим" для дополнительных особенностей
DROP TABLE IF EXISTS product_features;
CREATE TABLE product_features (
	product_id BIGINT UNSIGNED NOT NULL,
	features_name VARCHAR(255) NOT NULL,
	
	PRIMARY KEY(product_id, features_name),
	CONSTRAINT fk_features_prod_id FOREIGN KEY(product_id)
	REFERENCES products(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_features_name FOREIGN KEY(features_name)
	REFERENCES additional_features(name) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- Создаем таблицу для хранения информации о языках, которые поддерживаются у продукта
CREATE TABLE languages (
	`language` VARCHAR(255) PRIMARY KEY COMMENT 'Наименование языка', 
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Создаем таблицу для отражения связи типа "многие ко многим" для языков
DROP TABLE IF EXISTS product_language;
CREATE TABLE product_language (
	product_id BIGINT UNSIGNED NOT NULL,
	`language` VARCHAR(255) NOT NULL,
	
	PRIMARY KEY(product_id, `language`),
	CONSTRAINT fk_language_prod_id FOREIGN KEY(product_id)
	REFERENCES products(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_language FOREIGN KEY(`language`)
	REFERENCES languages(`language`) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- Создаем таблицу для хранения информации о пользователях
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	profile_name VARCHAR(64) NOT NULL UNIQUE,
	email VARCHAR(255) NOT NULL UNIQUE,
	pass_hash VARCHAR(255),
	nickname VARCHAR(255),
	real_name VARCHAR(255),
	country VARCHAR(255),
	state VARCHAR(255),
	city VARCHAR(255),
	summary VARCHAR(255) COMMENT 'Краткая информация о себе',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	INDEX(profile_name),
	INDEX(email)
);


-- Создаем таблицу для хранения информации о заказах пользователей
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	order_status ENUM('processing', 'completed'),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	CONSTRAINT fk_user_id FOREIGN KEY(user_id)
	REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- Создаем таблицу для хранения информации о составе заказа
DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
	id SERIAL PRIMARY KEY,
	order_id BIGINT UNSIGNED NOT NULL,
	product_id BIGINT UNSIGNED NOT NULL,
	product_price DECIMAL(11,2) UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(product_price) REFERENCES products(price) ON DELETE RESTRICT ON UPDATE RESTRICT
) COMMENT = 'Состав заказа';


-- Создаем таблицу для хранения информации о пользовательских коллекциях. О продуктах, которые уже приобретены пользователем
DROP TABLE IF EXISTS user_collections;
CREATE TABLE user_collections (
	user_id BIGINT UNSIGNED NOT NULL,
	product_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	PRIMARY KEY(user_id, product_id),
	FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	
	INDEX(user_id),
	INDEX(product_id)
) COMMENT = 'Коллекции продуктов пользователей';


-- Создаем таблицу для хранения информации о друзьях пользователей
DROP TABLE IF EXISTS friends;
CREATE TABLE friends (
	initiator_user_id BIGINT UNSIGNED NOT NULL,
	target_user_id BIGINT UNSIGNED NOT NULL,
	relation_status ENUM ('requested', 'approved', 'declined', 'unfriended', 'blocked'),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	PRIMARY KEY(initiator_user_id, target_user_id),
	FOREIGN KEY(initiator_user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(target_user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	
	INDEX(initiator_user_id),
	INDEX(target_user_id)
);


/*
	Steam позволяет отправлять сообщения только друзьям.
	Поэтому создаем таблицу для хранения информации о сообщениях которые друзья отправляют друг другу
*/
DROP TABLE IF EXISTS friends_messages;
CREATE TABLE friends_messages ( -- Нужно еще добавить триггер
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	FOREIGN KEY(from_user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(to_user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	
	INDEX(from_user_id),
	INDEX(to_user_id)
);


-- Создаем таблицу для хранения информации о группах сообщества
DROP TABLE IF EXISTS community_groups;
CREATE TABLE community_groups (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	group_access_status ENUM ('private group', 'public group'),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	INDEX(name)
);


-- Создаем таблицу для хранения информации о группах, в которых состоят пользователи
DROP TABLE IF EXISTS users_groups;
CREATE TABLE users_groups (
	user_id BIGINT UNSIGNED NOT NULL,
	group_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	PRIMARY KEY(user_id, group_id),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(group_id) REFERENCES community_groups(id)
);


-- Создаем таблицу для хранения информации о типах содержимого
DROP TABLE IF EXISTS content_types;
CREATE TABLE content_types (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Создаем таблицу для хранения информации о созданном содержимом
DROP TABLE IF EXISTS content;
CREATE TABLE content (
	id SERIAL PRIMARY KEY,
	content_type_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	product_id BIGINT UNSIGNED,
	body TEXT,
	filename VARCHAR(255),
	file_size INT,
	metadata JSON,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	FOREIGN KEY(content_type_id) REFERENCES content_types(id),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(product_id) REFERENCES products(id),
	
	INDEX(user_id),
	INDEX(product_id)
);


-- Вместо лайков есть рекомендации любого содержимого. Создаем таблицу для хранения этой информации
DROP TABLE IF EXISTS recommendations;
CREATE TABLE recommendations (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	content_id BIGINT UNSIGNED NOT NULL,
	recommendation ENUM('yes', 'no'),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(content_id) REFERENCES content(id)
);


-- Создаем таблицу для хранения информации о коментариях, которые пользователи могут оставлять к содержимому
DROP TABLE IF EXISTS content_comments;
CREATE TABLE content_comments (
	user_id BIGINT UNSIGNED NOT NULL,
	content_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	PRIMARY KEY(user_id, content_id),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(content_id) REFERENCES content(id)
);
