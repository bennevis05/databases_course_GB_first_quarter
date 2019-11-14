-- Generation time: Thu, 14 Nov 2019 19:51:12 +0000
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

DROP TABLE IF EXISTS `communities`;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `communities` VALUES ('69','a'),
('96','accusamus'),
('20','adipisci'),
('19','aliquid'),
('75','animi'),
('76','at'),
('84','at'),
('18','atque'),
('40','atque'),
('36','aut'),
('43','autem'),
('90','blanditiis'),
('16','commodi'),
('23','commodi'),
('68','consequatur'),
('81','consequatur'),
('48','cumque'),
('77','delectus'),
('32','distinctio'),
('25','dolor'),
('55','dolorem'),
('49','dolorum'),
('93','ea'),
('12','eaque'),
('58','et'),
('60','et'),
('82','et'),
('88','et'),
('89','et'),
('28','eum'),
('11','eveniet'),
('71','ex'),
('72','excepturi'),
('98','exercitationem'),
('14','id'),
('37','id'),
('73','id'),
('54','illo'),
('62','incidunt'),
('67','inventore'),
('26','ipsa'),
('13','iste'),
('63','itaque'),
('15','labore'),
('41','laboriosam'),
('27','minus'),
('80','minus'),
('29','modi'),
('79','modi'),
('33','molestiae'),
('8','mollitia'),
('2','necessitatibus'),
('65','nemo'),
('70','neque'),
('5','nobis'),
('50','non'),
('10','omnis'),
('22','omnis'),
('66','pariatur'),
('56','perferendis'),
('44','porro'),
('17','possimus'),
('61','praesentium'),
('86','provident'),
('31','quae'),
('74','quae'),
('3','qui'),
('85','qui'),
('97','qui'),
('57','quia'),
('64','quia'),
('95','quibusdam'),
('92','quidem'),
('24','quis'),
('30','quis'),
('39','quod'),
('21','ratione'),
('87','ratione'),
('59','rerum'),
('52','saepe'),
('38','sapiente'),
('46','sed'),
('51','soluta'),
('47','tempora'),
('9','temporibus'),
('6','tenetur'),
('100','totam'),
('1','ut'),
('78','ut'),
('94','ut'),
('4','vel'),
('35','vel'),
('53','vel'),
('83','vel'),
('7','veniam'),
('45','veniam'),
('99','veritatis'),
('91','vero'),
('42','vitae'),
('34','voluptatem'); 




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

