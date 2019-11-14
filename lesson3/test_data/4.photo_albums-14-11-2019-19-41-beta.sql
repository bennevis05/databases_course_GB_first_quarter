-- Generation time: Thu, 14 Nov 2019 19:41:46 +0000
-- Host: mysql.hostinger.ro
-- DB name: u574849695_25
/*!40030 SET NAMES UTF8 */;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `photo_albums` VALUES ('1','corporis','1'),
('2','esse','2'),
('3','excepturi','3'),
('4','molestias','4'),
('5','velit','5'),
('6','assumenda','6'),
('7','aliquid','7'),
('8','quibusdam','8'),
('9','cum','9'),
('10','placeat','10'),
('11','corporis','11'),
('12','sed','12'),
('13','quaerat','13'),
('14','libero','14'),
('15','error','15'),
('16','recusandae','16'),
('17','corporis','17'),
('18','molestias','18'),
('19','sit','19'),
('20','ut','20'),
('21','voluptates','21'),
('22','quam','22'),
('23','recusandae','23'),
('24','deleniti','24'),
('25','modi','25'),
('26','dolor','26'),
('27','vel','27'),
('28','vel','28'),
('29','fugiat','29'),
('30','quaerat','30'),
('31','accusantium','31'),
('32','illum','32'),
('33','dolor','33'),
('34','voluptatem','34'),
('35','impedit','35'),
('36','expedita','36'),
('37','fugiat','37'),
('38','necessitatibus','38'),
('39','corrupti','39'),
('40','necessitatibus','40'),
('41','unde','41'),
('42','inventore','42'),
('43','officia','43'),
('44','vero','44'),
('45','voluptas','45'),
('46','cumque','46'),
('47','non','47'),
('48','minima','48'),
('49','vero','49'),
('50','rerum','50'),
('51','sed','51'),
('52','perferendis','52'),
('53','aut','53'),
('54','sit','54'),
('55','non','55'),
('56','atque','56'),
('57','doloremque','57'),
('58','sunt','58'),
('59','voluptas','59'),
('60','eligendi','60'),
('61','est','61'),
('62','aliquid','62'),
('63','eveniet','63'),
('64','tenetur','64'),
('65','magni','65'),
('66','aperiam','66'),
('67','id','67'),
('68','et','68'),
('69','consequatur','69'),
('70','modi','70'),
('71','optio','71'),
('72','ratione','72'),
('73','hic','73'),
('74','optio','74'),
('75','id','75'),
('76','dolorem','76'),
('77','autem','77'),
('78','iste','78'),
('79','amet','79'),
('80','qui','80'),
('81','est','81'),
('82','repudiandae','82'),
('83','exercitationem','83'),
('84','et','84'),
('85','perferendis','85'),
('86','eius','86'),
('87','fuga','87'),
('88','qui','88'),
('89','eveniet','89'),
('90','dolor','90'),
('91','quam','91'),
('92','voluptatum','92'),
('93','impedit','93'),
('94','nulla','94'),
('95','reiciendis','95'),
('96','hic','96'),
('97','hic','97'),
('98','delectus','98'),
('99','est','99'),
('100','ipsum','100'); 




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

