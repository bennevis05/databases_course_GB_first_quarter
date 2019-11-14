DROP DATABASE IF EXISTS my_vk;
CREATE DATABASE my_vk;
USE my_vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(100),
	lastname VARCHAR(100),
	email VARCHAR(100) UNIQUE,
	`pass_hash` VARCHAR(100),
	phone VARCHAR(12),
	
	INDEX users_phone_idx(phone),
	INDEX(firstname, lastname)
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
	user_id SERIAL PRIMARY KEY,
	gender CHAR(1),
	birth_day DATE,
	photo_id BIGINT UNSIGNED NOT NULL,
	hometown VARCHAR(100),
	created_at DATETIME DEFAULT NOW()
);

ALTER TABLE profiles
ADD CONSTRAINT fk_user_id FOREIGN KEY(user_id)
REFERENCES users(id)
ON UPDATE CASCADE
ON DELETE RESTRICT;

DROP TABLE IF EXISTS messages;
CREATE TABLE messages(
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY(from_user_id) REFERENCES users(id),
	FOREIGN KEY(to_user_id) REFERENCES users(id),
	INDEX(from_user_id),
	INDEX(to_user_id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests(
	initiator_user_id BIGINT UNSIGNED NOT NULL,
	target_user_id BIGINT UNSIGNED NOT NULL,
	`status` ENUM ('requested', 'approved', 'unfriended', 'declined'),
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
	PRIMARY KEY(initiator_user_id, target_user_id),
	INDEX(initiator_user_id),
	INDEX(target_user_id),
	FOREIGN KEY(initiator_user_id) REFERENCES users(id),
	FOREIGN KEY(target_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	
	INDEX(name)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY(user_id, community_id),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
	media_type_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	filename VARCHAR(255),
	file_size INT,
	metadata JSON,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME,
	
	FOREIGN KEY(media_type_id) REFERENCES media_types(id),
	FOREIGN KEY(user_id) REFERENCES users(id),
	INDEX(user_id)
);

DROP TABLE IF EXISTS photo_albums;
CREATE TABLE photo_albums(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	user_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY(user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS photos;
CREATE TABLE photos(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	album_id BIGINT UNSIGNED NULL,
	media_id BIGINT UNSIGNED NULL,
	
	FOREIGN KEY(album_id) REFERENCES photo_albums(id),
	FOREIGN KEY(media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
	media_id BIGINT UNSIGNED NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY(media_id) REFERENCES media(id),
	FOREIGN KEY(user_id) REFERENCES users(id)
);

ALTER TABLE profiles
ADD CONSTRAINT fk_photo_id FOREIGN KEY(photo_id)
REFERENCES media(id)
ON UPDATE CASCADE
ON DELETE RESTRICT;
