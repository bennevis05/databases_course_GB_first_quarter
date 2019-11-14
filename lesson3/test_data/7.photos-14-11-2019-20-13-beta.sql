-- Generation time: Thu, 14 Nov 2019 20:13:24 +0000
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

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `album_id` bigint(20) unsigned DEFAULT NULL,
  `media_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`),
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `photos` VALUES ('1','et','1','1'),
('2','ab','2','2'),
('3','aliquid','3','3'),
('4','mollitia','4','4'),
('5','similique','5','5'),
('6','suscipit','6','6'),
('7','itaque','7','7'),
('8','nihil','8','8'),
('9','esse','9','9'),
('10','perspiciatis','10','10'),
('11','excepturi','11','11'),
('12','aut','12','12'),
('13','ut','13','13'),
('14','sed','14','14'),
('15','porro','15','15'),
('16','harum','16','16'),
('17','a','17','17'),
('18','numquam','18','18'),
('19','quia','19','19'),
('20','sunt','20','20'),
('21','quisquam','21','21'),
('22','accusamus','22','22'),
('23','fugiat','23','23'),
('24','facere','24','24'),
('25','laborum','25','25'),
('26','hic','26','26'),
('27','non','27','27'),
('28','cumque','28','28'),
('29','recusandae','29','29'),
('30','natus','30','30'),
('31','quidem','31','31'),
('32','quam','32','32'),
('33','repellat','33','33'),
('34','velit','34','34'),
('35','ut','35','35'),
('36','maxime','36','36'),
('37','repellendus','37','37'),
('38','doloribus','38','38'),
('39','delectus','39','39'),
('40','officiis','40','40'),
('41','autem','41','41'),
('42','cum','42','42'),
('43','veritatis','43','43'),
('44','et','44','44'),
('45','qui','45','45'),
('46','deleniti','46','46'),
('47','id','47','47'),
('48','fugit','48','48'),
('49','et','49','49'),
('50','molestiae','50','50'),
('51','quia','51','51'),
('52','velit','52','52'),
('53','aut','53','53'),
('54','necessitatibus','54','54'),
('55','quia','55','55'),
('56','consequatur','56','56'),
('57','deserunt','57','57'),
('58','dolor','58','58'),
('59','omnis','59','59'),
('60','dolores','60','60'),
('61','voluptas','61','61'),
('62','pariatur','62','62'),
('63','qui','63','63'),
('64','fuga','64','64'),
('65','placeat','65','65'),
('66','ut','66','66'),
('67','libero','67','67'),
('68','aut','68','68'),
('69','facere','69','69'),
('70','quasi','70','70'),
('71','quia','71','71'),
('72','qui','72','72'),
('73','minima','73','73'),
('74','aperiam','74','74'),
('75','voluptas','75','75'),
('76','enim','76','76'),
('77','necessitatibus','77','77'),
('78','libero','78','78'),
('79','officia','79','79'),
('80','harum','80','80'),
('81','et','81','81'),
('82','dolorum','82','82'),
('83','laudantium','83','83'),
('84','cumque','84','84'),
('85','iusto','85','85'),
('86','assumenda','86','86'),
('87','cumque','87','87'),
('88','molestiae','88','88'),
('89','sed','89','89'),
('90','qui','90','90'),
('91','alias','91','91'),
('92','dolores','92','92'),
('93','ex','93','93'),
('94','aut','94','94'),
('95','sint','95','95'),
('96','in','96','96'),
('97','quam','97','97'),
('98','minima','98','98'),
('99','repellat','99','99'),
('100','nisi','100','100'); 




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

