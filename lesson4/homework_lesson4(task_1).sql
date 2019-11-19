/* Задание 1
	Заполнить все таблицы БД vk данными (по 10-100 записей в каждой таблице)
*/

USE my_vk;

INSERT INTO users (firstname, lastname, email, pass_hash, phone) VALUES
('Domingo', 'Hilpert', 'gregoria62@example.org', 'fca308c62114f1f9f588b57d0d35622f28929932', '866.658.3068'),
('Alberta', 'Spinka', 'tblick@example.org', '0691ab19ff741774d62c44cb2a4db16335baf06b', '03390359951'),
('Shania', 'Feest', 'kjacobson@example.org', '5ae2e28564a43f5e21be39854684df4d744af82e', '1-233-381-66'),
('Onie', 'Nicolas', 'reta76@example.net', '5ad21a3d3e0412ff8e007c65bed3fec2834da8ac', '875.547.7172'),
('Norwood', 'Schinner', 'haag.cullen@example.com', '463d4f90f3965340434b20cf98f459ad80ce23f1', '(981)180-123'),
('Kathlyn', 'Bins', 'alek43@example.org', '6890f9230431df21a32cf5f07cca76b8f020913f', '(446)783-951'),
('Doris', 'Heaney', 'pwill@example.org', '13ecbb9fbf05e5d1d57ae4fb2726c0a9fe5d729e', '438.471.0961'),
('Jessie', 'Brown', 'corrine54@example.com', '6d19cb18c3ba58d32fd3c2ec394c9e5f6ead7a1c', '+04(6)554389'),
('Florian', 'Corkery', 'abelardo93@example.com', 'f6014161645ed923af8051f6fa94f8290340dc1b', '05817070725'),
('London', 'Jaskolski', 'scrist@example.org', 'b239cbae60e29c5e51c72fd21c36099cef65a16b', '760-021-7692'),
('Edison', 'Doyle', 'cristal.schiller@example.net', '374b78724779027934ce45c47b80dbff590e1ab5', '427-531-6999');

INSERT INTO media_types (name) VALUES
('est'),
('facere'),
('quam'),
('sit'),
('accusamus'),
('perspiciatis'),
('aut'),
('suscipit'),
('enim'),
('optio'),
('veritatis');

INSERT INTO media (media_type_id, user_id, body, filename, file_size, metadata, created_at, updated_at) VALUES
('1','1','Sunt minus accusamus qui quia est non. Perferendis ex et dolor maiores provident. Id iure voluptas rerum magnam labore ipsam est. Odio qui voluptas iure quidem quis quos repudiandae.','et','51613',NULL,'1977-06-26 16:20:58','2001-05-12 09:28:33'),
('2','2','Aut ut ratione mollitia voluptatum sunt labore laborum. Harum nesciunt nostrum qui molestiae vitae. Consequatur blanditiis repudiandae accusantium iste.','omnis','12',NULL, DEFAULT,NULL),
('3','3','Quam in nemo rerum maxime. Dolores qui eveniet eveniet vero esse dolor quaerat tempore. Aut totam est aut magni. Saepe voluptatum et suscipit et asperiores velit.','et','49',NULL,'1987-07-10 19:52:27','1995-01-13 11:51:13'),
('4','4','Maiores provident excepturi sapiente id. Ea consequatur vel odio qui et est corporis ut. Tempore sequi iusto temporibus consequatur non dolores. Distinctio aut ipsa modi nisi quos quia et quo.','corporis','80',NULL, DEFAULT,NULL),
('5','5','Accusantium rem doloribus consequatur dignissimos rerum repellendus. Quod esse ab iure sit sit et aperiam. Quos dolorum quisquam pariatur voluptatum aspernatur quia sequi adipisci. Omnis consequatur nam debitis consequatur deleniti optio.','beatae','1912',NULL,'1977-04-10 09:13:53','2015-11-01 19:54:55'),
('6','6','Voluptates non nesciunt quasi similique. Perferendis delectus et consectetur dicta. Cupiditate aspernatur eius laudantium laborum. Modi laboriosam dolore id.','voluptatem','209',NULL, DEFAULT,NULL),
('7','7','Possimus illum voluptas esse blanditiis explicabo error vel ratione. Incidunt fugiat laboriosam voluptatem natus qui. Quibusdam velit ut laborum eligendi et perferendis. Rem asperiores aliquid voluptatem nesciunt.','libero','0',NULL,'1977-06-10 20:58:55','1984-03-14 10:08:25'),
('8','8','Veniam in iste ullam quidem ut quisquam. Labore placeat voluptas dolores velit est accusantium aliquid. Qui numquam exercitationem rerum est fuga est. Eaque architecto ut commodi magnam porro tempora recusandae.','repellendus','358858',NULL,'1993-01-18 14:18:19','1978-07-19 20:36:52'),
('9','9','Atque praesentium voluptatem natus voluptatem qui expedita minima. Ullam occaecati facilis ex at quia natus rem. Placeat deleniti nostrum corporis sint eaque molestiae.','id','0',NULL, DEFAULT,NULL),
('10','10','Eligendi adipisci dolore et dolores neque accusamus et. Et omnis ea eveniet qui dolorum commodi. Necessitatibus quidem ad officia a.','et','8022080',NULL,'1976-03-27 11:10:01','1982-09-20 13:22:56'),
('11','11','Perspiciatis repellat dolorem error earum. Eum animi quibusdam ipsum non quae ad. Corporis et omnis culpa voluptatem et dolores.','unde','670834495',NULL, DEFAULT,NULL);

INSERT INTO photo_albums (name, user_id) VALUES
('id','1'),
('dolore','2'),
('hic','3'),
('minus','4'),
('omnis','5'),
('officia','6'),
('dicta','7'),
('qui','8'),
('qui','9'),
('et','10'),
('minima','11');

INSERT INTO communities (name) VALUES
('autem'),
('corrupti'),
('culpa'),
('excepturi'),
('neque'),
('occaecati'),
('quia'),
('quo'),
('quod'),
('repudiandae'),
('veniam');

INSERT INTO likes VALUES
('1','1','1','2002-06-03 03:45:16'),
('2','2','2','1995-03-25 07:16:49'),
('3','3','3','1994-06-18 23:32:34'),
('4','4','4','2015-07-07 21:38:40'),
('5','5','5','2015-04-10 07:47:41'),
('6','6','6','2000-08-20 12:33:32'),
('7','7','7','2000-10-25 08:02:34'),
('8','8','8','1978-09-15 03:31:38'),
('9','9','9','2009-12-04 02:13:03'),
('10','10','10','1989-08-13 23:50:21'),
('11','11','11','1986-10-30 15:31:29');

INSERT INTO photos VALUES
('1','possimus','1','1'),
('2','omnis','2','2'),
('3','ut','3','3'),
('4','temporibus','4','4'),
('5','quam','5','5'),
('6','quibusdam','6','6'),
('7','occaecati','7','7'),
('8','sequi','8','8'),
('9','voluptates','9','9'),
('10','distinctio','10','10'),
('11','corporis','11','11');

INSERT INTO profiles VALUES
('1',NULL,'2007-06-12','1',NULL,'1987-06-07 14:55:02'),
('2',NULL,'1990-02-23','2',NULL,'2000-12-25 08:20:06'),
('3',NULL,'1997-01-29','3',NULL,'1971-04-21 16:36:00'),
('4',NULL,'1989-12-19','4',NULL,'1973-03-01 12:49:06'),
('5',NULL,'2006-04-21','5',NULL,'1985-11-18 02:55:23'),
('6',NULL,'2007-10-07','6',NULL,'1975-02-13 08:06:14'),
('7',NULL,'1984-07-03','7',NULL,'2017-08-20 00:18:00'),
('8',NULL,'2001-08-06','8',NULL,'1981-08-01 04:11:53'),
('9',NULL,'1998-09-06','9',NULL,'1989-07-24 00:47:59'),
('10',NULL,'1981-03-31','10',NULL,'1976-03-04 06:10:12'),
('11',NULL,'2007-10-03','11',NULL,'1977-12-13 00:19:23');

INSERT INTO users_communities VALUES
('1','1'),
('2','2'),
('3','3'),
('4','4'),
('5','5'),
('6','6'),
('7','7'),
('8','8'),
('9','9'),
('10','10'),
('11','11');

INSERT INTO friend_requests VALUES
('1','2','declined','1972-01-06 03:05:53','2017-06-21 18:40:46'),
('2','1','declined','2007-01-03 14:50:39','1982-08-31 10:38:57'),
('3','4','unfriended','2009-07-15 12:42:51','1979-01-04 13:55:02'),
('4','3','unfriended','1999-09-12 06:44:10','1982-08-25 19:40:04'),
('5','6','requested','1970-08-06 20:47:44','1975-02-23 10:30:43'),
('6','5','approved','2016-11-18 04:55:16','1993-10-13 14:23:43'),
('7','8','requested','1970-03-10 18:05:12','2014-09-25 10:13:12'),
('8','7','unfriended','1973-11-23 19:30:23','1982-12-04 12:20:20'),
('9','10','approved','1998-09-26 18:05:42','1989-07-28 23:42:54'),
('10','9','declined','2018-07-14 16:36:57','1995-10-19 09:39:16'),
('11','1','declined','2013-06-04 10:51:36','1999-05-23 14:39:12');

INSERT INTO messages VALUES
('1','1','2','Suscipit voluptatem iste quia ea et. Dolore et aut facilis laborum quia molestias qui voluptatem. Veniam sit eius molestias eaque velit voluptas quas. Et doloremque ut aliquam.','2012-07-27 02:10:58'),
('2','2','1','Enim quia temporibus fuga dolores iusto. Aut delectus praesentium ut occaecati optio sed. Perspiciatis in ab mollitia alias id in blanditiis.','1999-01-09 07:34:46'),
('3','3','4','Dolores eaque ut occaecati mollitia totam non delectus omnis. Consectetur error quo libero quod ipsum a. Id et id ipsum blanditiis aliquid ut cumque.','2019-03-28 02:29:00'),
('4','4','3','Dolore deserunt et impedit repellendus. In omnis doloremque magnam rerum perferendis nihil.','1975-10-18 22:25:53'),
('5','5','6','Non cupiditate ratione dolores sit a amet. Officiis eum ut repellendus tempora dolor dolore quos. Sint harum consectetur delectus dolorem laborum voluptas cumque.','2016-08-01 20:29:11'),
('6','6','5','Id aut consequatur est earum. Debitis sequi fugit fugiat ipsum. Aperiam repellendus enim distinctio rem fugiat sit.','2014-02-20 21:25:16'),
('7','7','8','Architecto exercitationem aperiam dignissimos. Praesentium ratione reiciendis quam dolores laborum tempore. Veritatis ut quod praesentium.','2011-10-30 17:21:14'),
('8','8','7','Itaque nam minima temporibus ducimus iure repellendus. Eos quis odio magnam eveniet. Excepturi ex expedita nostrum nobis.','1985-10-29 03:47:17'),
('9','9','10','Sunt rem dolores officiis. Aperiam fuga fuga qui officia quis officia. Aliquam necessitatibus et dicta nesciunt. In dolore vitae repudiandae occaecati.','1975-02-06 21:12:35'),
('10','10','9','Ipsum dolores tempora nam magni deleniti. Distinctio corrupti ut beatae. Cumque exercitationem aperiam voluptas et et.','1979-11-20 21:40:16'),
('11','11','1','Harum recusandae veniam at non ut. Quis nisi beatae qui in temporibus. Voluptatibus veritatis ut eaque iusto delectus ut.','1995-09-30 18:57:13');



