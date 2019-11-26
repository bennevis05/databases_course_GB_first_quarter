/*
	Задание 1.
	Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека,
	который больше всех общался с нашим пользователем.
*/

SELECT COUNT(to_user_id) AS total_messages, to_user_id AS user_id FROM messages WHERE to_user_id IN (
	SELECT initiator_user_id FROM friend_requests WHERE target_user_id = 1 AND status = 'approved'
	UNION
	SELECT target_user_id FROM friend_requests WHERE initiator_user_id = 1 AND status = 'approved'
) GROUP BY to_user_id
UNION
SELECT COUNT(from_user_id) AS total_messages, from_user_id FROM messages WHERE from_user_id IN (
	SELECT initiator_user_id FROM friend_requests WHERE target_user_id = 1 AND status = 'approved'
	UNION
	SELECT target_user_id FROM friend_requests WHERE initiator_user_id = 1 AND status = 'approved'
) GROUP BY from_user_id;



/*
	Задание 2.
	Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
*/

SELECT COUNT(*) AS total_likes FROM likes WHERE media_id IN (
	SELECT id FROM media WHERE user_id IN (
		SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 10));



/*
	Задание 3.
	Определить кто больше поставил лайков (всего) - мужчины или женщины?
*/

SELECT COUNT(*) AS total_likes, (SELECT 'men') AS gender FROM likes WHERE user_id IN (
	SELECT user_id FROM profiles WHERE gender = 'm')
UNION
SELECT COUNT(*), (SELECT 'women') FROM likes WHERE user_id IN (
	SELECT user_id FROM profiles WHERE gender = 'f') ORDER BY total_likes DESC;
