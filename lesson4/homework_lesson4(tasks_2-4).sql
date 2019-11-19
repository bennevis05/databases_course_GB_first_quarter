/* Задание 2
	Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
*/

USE my_vk;

-- Добавим пользователей с одинаковыми именами
INSERT INTO users (firstname, lastname, email, pass_hash, phone) VALUES
('Domingo', 'Jekson', 'example@example.org', 'fca328c72114d1f9f598b57d0d35622f28929932', '856.158.2068'),
('Domingo', 'Hiller', 'example2@example.org', 'fea328c72114d1f9f598b57d0d35622f28929932', '855.128.2368');

-- Далее выбираем только имена пользователей без повторений в алфавитном порядке
SELECT DISTINCT firstname FROM users ORDER BY firstname ASC;





/* Задание 3
	Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = true).
	При необходимости предварительно добавить такое поле в таблицу profiles со значением по умолчанию = false (или 0)
*/

-- Добавим необходимое поле со значением по умолчанию
ALTER TABLE profiles ADD not_active ENUM('True', 'False') DEFAULT 'False';

-- Можем посмотреть текущий возраст пользователей
SELECT birth_day, CURDATE(), TIMESTAMPDIFF(YEAR, birth_day, CURDATE()) AS age FROM profiles ORDER BY age;

-- Обновляем данные в теблице profiles
UPDATE profiles SET not_active = 'True' WHERE TIMESTAMPDIFF(YEAR, profiles.birth_day, CURDATE()) < 18;





/* Задание 4
	Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)
*/

-- Для примера, добавим пару сообщений "из будущего"
INSERT INTO messages (from_user_id, to_user_id, body, created_at) VALUES
('5', '1', 'Suscipit voluptatem iste quia ea et. Et doloremque ut aliquam.','2023-07-27 02:10:58'),
('10', '2', 'Enim quia temporibus fuga dolores iusto. Perspiciatis in ab mollitia alias id in blanditiis.','2030-01-09 07:34:46');

-- Удаляем сообщения
DELETE FROM messages WHERE created_at > CURDATE();
