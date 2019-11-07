/* Задача NN
Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
*/

DROP DATABASE IF EXISTS example;
CREATE DATABASE example;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id INT,
	name VARCHAR(255))
