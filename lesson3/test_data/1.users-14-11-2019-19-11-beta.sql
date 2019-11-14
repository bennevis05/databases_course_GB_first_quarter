-- Generation time: Thu, 14 Nov 2019 19:11:34 +0000
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

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pass_hash` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `users_phone_idx` (`phone`),
  KEY `firstname` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` VALUES ('1','Daisy','Rath','abbey58@example.net','34c0e0a074b9e55dcfde10501adac9fe14825f8c','1-323-895-67'),
('2','Mohammed','Erdman','josie.lueilwitz@example.com','80a901d666aa66c10f68e45bdb493d6333b10e20','019.809.0504'),
('3','Gerry','Gulgowski','rolfson.bertram@example.com','12c1f7ff707057247de317d9b3f53e9fc56c82da','340.307.1475'),
('4','Viola','Feil','kris.princess@example.org','7589d68d12c7b0fbc1111160a1e6ad18fbb079fa','510.385.1216'),
('5','Ike','Rolfson','schaefer.josiah@example.org','2538318875d1f454087f7fc9844c126f8d2e3228','225.166.1259'),
('6','Demario','Cormier','snienow@example.com','7a591870734ca3cd9e95de46e50a5fdad31324cf','1-658-364-57'),
('7','Arthur','Schuster','turner.eduardo@example.org','6cb3f7f0a28cdefd995018197a63b7066c365c17','1-265-714-17'),
('8','Dylan','Schimmel','shields.adele@example.net','5a5f600941d8c86c490c5568f69d8f2e7f3a64f7','896.624.7802'),
('9','Clemmie','Treutel','damon36@example.net','e190682a557a4731d8d8550e6206e518e6b942fd','1-027-184-57'),
('10','Cooper','Gorczany','dooley.alejandra@example.net','5abacb7585c9309271bd461e0b2e51c0bf8ee896','913.655.5714'),
('11','Pietro','Moen','kylie.fadel@example.org','69c16b9c16749855334235cf4f92755e2f40d63b','(001)472-820'),
('12','Julian','Kunde','carlee.hills@example.com','71225160ca1d59d2229423fe49c532e6658f5a41','410.032.2669'),
('13','Eino','Lemke','earlene.bosco@example.org','4a90a2cb3530621959d6858b027fd1d1f2839d2e','(596)978-486'),
('14','Kathryne','Jaskolski','kirlin.euna@example.org','e1937f4d34a79b46def55ee1555f413697fb66c2','(465)816-798'),
('15','Kelly','Macejkovic','lew85@example.org','6c0fb526256a7bec6d901ca9d1e795110b361fec','(532)956-872'),
('16','Mason','Weissnat','quinten.steuber@example.net','af2dd8eb791a54720dda8a94346b32397d4425d5','1-601-910-68'),
('17','Bethel','Ferry','ryder32@example.org','c9d5e207a74a55bbc4ecdc2accd553be61fc0c1d','263-979-8153'),
('18','Neoma','Reinger','pkoss@example.com','46366e076cb0e8b6be2d6bd7891df28428b08982','068.495.2241'),
('19','Gayle','O\'Hara','keegan.padberg@example.net','e2ef59b77a49fdf5ab99104b5273ee8e49d76aa7','1-857-522-39'),
('20','Fiona','Little','vmosciski@example.com','3255e5fbf87f6fa23fc5cf3095b749abae456564','088-597-1937'),
('21','Francis','Von','ebalistreri@example.net','0504fb0a1716fa32f43633e9b4af7bc502ca5cc2','123.726.5030'),
('22','Otto','Pfeffer','ybecker@example.com','e79215f5ced761bed736b5ad2b72ed2cbb08e965','+10(0)853522'),
('23','Keyshawn','Roob','merlin.spencer@example.org','f814d2e02195702b2fd053330c63bde32be3229c','986-942-5504'),
('24','Don','Koss','alison.harber@example.net','b1213fa548508eb0f6e99bbd0f91aad7262385cc','557-144-9021'),
('25','Mireya','Keeling','krajcik.arvilla@example.net','815bc07151f9818b3b6888be63fbb381e1b69e69','1-408-732-63'),
('26','Karlee','Becker','weston89@example.org','57861c1dab3a501292cab48caa249fc95154e4b9','1-878-516-24'),
('27','Alexys','Douglas','summer.blanda@example.org','4a3d4ec960bd2e0034ecb010ace644f7a71e8f41','1-682-939-50'),
('28','Jaclyn','Ebert','lueilwitz.cindy@example.org','762abc989a426e3480cfc937cdc80affa595574f','(356)519-794'),
('29','Sigrid','Franecki','zoey.herzog@example.com','0890a9394ba9228fcef4d0e36fc450141b45a0e8','1-218-060-29'),
('30','Jefferey','Robel','veum.harold@example.net','68e65063aaf1344a3bddd555c13e36330e6ba2e2','1-419-098-87'),
('31','Myles','Davis','elissa.carroll@example.net','d61f41cc00668e69e4967ca63102c49295ef78c5','(055)152-133'),
('32','Jerad','Ferry','rubye.kozey@example.net','8d9dab27aa61fefaed93ab22528f969d0ca8cb89','(782)856-502'),
('33','Joyce','Buckridge','berge.casper@example.net','c3e2f152db4175018fdb2ebd6041cb7e4f7b07e0','310-176-1727'),
('34','Jesus','Boyer','linnea20@example.org','4aaa7edb2e6b3681db6c603c07666cccff0490ca','(919)392-007'),
('35','Santina','Weber','jarvis28@example.com','6e08248505377557e21c6adc9f6db3fb9d7521fb','242-425-8745'),
('36','Justen','Hermiston','haley.mallory@example.com','7a525b8eec349e819c92b9139eb7a3c52cd1de73','+09(8)564555'),
('37','Sallie','Okuneva','dina.altenwerth@example.com','ab4f0b15d2f8eb545ebbde13855b92295164dfcc','(425)173-684'),
('38','Elmer','Rohan','justyn.considine@example.org','d5f7ad35c8653a5a940b450d7edde6318ab8f551','(508)166-367'),
('39','Emil','Oberbrunner','richie.shields@example.net','9effb93ce641d209b347afa931ccc45fe3ad3588','1-064-958-83'),
('40','Hanna','McClure','wpredovic@example.com','be4e77a5aa172f984b1fc5dab3fc299ff043442a','951-764-1884'),
('41','Herbert','Steuber','ddeckow@example.com','c518ab34d0c381aa1287a8bef7d81e0d54d2ff94','03422989657'),
('42','Hershel','McClure','danial.swaniawski@example.net','e03c1a6274c49ac65019de1747f67713969c6792','05736320448'),
('43','Gabe','Goldner','wintheiser.vivian@example.com','72ad5b4b6c04c94b76c6b6152ceee65b7ad50b5d','(791)017-942'),
('44','Bennie','Spencer','talia04@example.net','75bb830e4957c85e2c2ebeb283ee834cdd77ef1e','035.739.3559'),
('45','Velva','Kohler','richmond.price@example.com','7610fe66b3c414e84ac6fbfb94c41887ad09f583','+75(6)996306'),
('46','Leann','Steuber','brooks.hartmann@example.net','8512edc22080dcd060c6723a629bcd8112f3ff82','1-363-576-33'),
('47','Grant','Schneider','aimee16@example.org','6d91721d358ee745f3fff46bf4c7da589b45b1a6','(303)534-462'),
('48','Verla','Renner','camila22@example.com','ab38a0f299f416d0f6d7020b66af866519203d93','689.350.5016'),
('49','Lurline','Cole','jswaniawski@example.com','24c14c24b813baf999c1c3eace423c72165451b6','1-319-725-83'),
('50','Leonora','Wyman','rene28@example.org','e0adb2cfef4c355ef82fd65a0e3d1ee378663614','431-891-1807'),
('51','Enrique','Stanton','korbin.grady@example.org','b043d338d01d5882f28bdd214e2e348c6acc584f','402-605-5615'),
('52','Josue','Kunde','glover.delaney@example.net','7f152a745e5d2f436a1151a5ca92e9b5ecf7ad8c','200.525.7872'),
('53','Arvel','Purdy','fern31@example.com','dad35ed523623b2143bf7ca74ef6e2d1c5a67418','+76(5)118706'),
('54','Makayla','Dietrich','margarett.weissnat@example.net','3e3c97bf7c0d0044b8ded630596a2f598dbdbdf4','1-058-930-10'),
('55','Ashly','Hammes','xtorp@example.org','d8202b66eb6d65d35944a9e57c8f4bb2c861a925','616-080-9568'),
('56','Jazmyn','Grimes','crona.melyna@example.com','f4cee8c0bb981e9ae1fad141f31a03aee75826a0','726.057.4284'),
('57','Rosalinda','Dicki','mae81@example.com','34032775756e858e14be33dfe1f058a9889850a5','1-905-898-87'),
('58','Travon','Muller','kylee33@example.net','1846320e1c8d8bfd7658c2010153d0a254ac73e4','1-317-133-76'),
('59','Leilani','Bosco','becker.shyann@example.org','98d4657f019bed9fbf46af257fb1de8264933b66','389-322-2853'),
('60','Raegan','Boyer','zelma.kovacek@example.org','bb71ab5339e3f4379481d6c279969908e745c88a','416.046.7257'),
('61','Ozella','Sporer','ardith.sanford@example.com','2c5b96690549fdb23ad733bb802638020fc7b021','07292411383'),
('62','Albin','Halvorson','zkeebler@example.org','b348e42e50323d560045daa58779a2cbe1e360c4','773.443.1725'),
('63','Matt','Jacobson','hickle.susana@example.net','8eb82d286e668adc86e99b668a2e9985216fbdcd','1-567-395-53'),
('64','Merritt','Durgan','zemlak.monserrate@example.org','4a384d00a6836b2bc71a4b532769f412c9ea536f','09141798148'),
('65','Eulah','Parisian','writchie@example.com','cdc1745944bce0b45269e1a11d76e9bf04b65733','1-645-905-24'),
('66','Brenda','Champlin','dangelo.pfeffer@example.net','3cba4d8179a55c4aecbb459ead32bc29c54d1817','810-058-5853'),
('67','Ada','Rolfson','keagan.lesch@example.org','78a3979732da01c8377326733f604bcf14aa5417','(549)705-744'),
('68','Raphaelle','Jones','hilbert98@example.com','b5c9c0120180d80cbc2996767993c6fc3e96d157','824.074.3649'),
('69','Rickey','Donnelly','shanahan.abigail@example.org','32373d5221d48578d53d8d9be219a99395a989db','1-477-726-89'),
('70','Peter','Durgan','darron.satterfield@example.org','38df39b29389b506c21d3ebcf192aacc19d87719','231.175.2442'),
('71','Kayli','Predovic','flatley.luther@example.net','a07bb1868d73d1c4621aad5281bf94d25cc23258','(482)375-620'),
('72','Elwyn','Gorczany','little.nella@example.org','c2dd5d0e6287fd5fd10c52c47cb75612ba088e0b','867-895-9961'),
('73','Joey','Weber','elliot.dach@example.net','a92c0aac9c2288622e1dfab8b83cf05ca7705bd3','1-977-575-78'),
('74','Gerry','Gottlieb','treutel.kris@example.com','071409f8182f4d27f468f0ddcd8365f7cdfaf1d4','(738)427-107'),
('75','Kaylah','Romaguera','mccullough.reid@example.org','83a3b7e5c6abfa63cc2fe808767ca92fb363c824','+51(7)248817'),
('76','Max','Kuhlman','keeling.mozelle@example.org','005a6e70eb9428b4708c4decd435436c883d2ebe','293.132.0777'),
('77','Nicklaus','Zemlak','allene.connelly@example.net','03694893513f4b76054d34a3f18a47cc24251faf','950-203-1902'),
('78','Sasha','Rutherford','kemmerich@example.net','7d55713ca63bb81b5f744a2e87ef69c0eb19359c','(312)474-229'),
('79','Deion','Thiel','schuyler89@example.com','d1e59ead5a507ac20ccea75e7c6682f9b06065e0','826.588.0911'),
('80','Jaylen','Jakubowski','abagail04@example.com','beaa49e2f69d11b71c62d9c46ba4258eaf5ed6c7','741.622.8198'),
('81','Haskell','Kerluke','swift.caleigh@example.com','d2cf8683caeb42b7bcd3f139957c46a602717560','192.891.5696'),
('82','Destinee','Beatty','erik.kuhn@example.net','07a82f7c67849aafdac931e518a28343695244c3','1-260-829-28'),
('83','Derick','Homenick','karlee.gleichner@example.com','08ae60f193f80474db682bb1b7303b5ca85a29b4','1-826-529-67'),
('84','Nora','Green','willis.effertz@example.net','d620637b202b1316262fac61d7f649e3d6491854','627-860-9851'),
('85','Jazmyne','King','deontae.mitchell@example.org','072d6c14e4dd6c80fe2ea891d214c2c3492b684e','484-522-6644'),
('86','Dulce','Greenholt','loraine.donnelly@example.org','6f18dd2e1d858abc26a0a668fc986770f195beab','(794)470-874'),
('87','Muriel','Batz','dokuneva@example.com','5c2d36cdc551f7aaa18a29aca3c44306bec884c4','(370)204-188'),
('88','Kavon','Johnston','lfeeney@example.net','fa228619530e48642828db1203ea21c3ae3139e3','012-172-1462'),
('89','Michele','Kassulke','mann.adolphus@example.net','5125587f4613b7ff56dfee4396e77ce30c68fd0c','(934)050-995'),
('90','Stella','Sporer','maria09@example.net','07e91c5ca8d821c81236466feaa24f8d917a25b2','347.749.4798'),
('91','Annamarie','Luettgen','elian.pouros@example.net','03ca308d83262e8c015eeca47eb4369f2e31f9cd','(696)255-265'),
('92','Ayden','Legros','consuelo96@example.com','abd4fc86321bb913061ef37bcc7499d79d693bc8','1-244-107-73'),
('93','Hiram','O\'Conner','dallin35@example.net','cbf1fdfbbb8be6676a49bb812ecf5160fc14efe0','065.019.9280'),
('94','Larue','Nitzsche','estella.gutmann@example.com','ccdf8f125a6286f930a297db8aabd356cf520982','1-465-919-93'),
('95','Briana','Bednar','legros.sarai@example.net','ae67b754cd1093cd35d13f661634e80d76ffa493','939-458-3594'),
('96','Mathias','Rogahn','daren44@example.com','41a3d7344a5df9c1bf8f6aa2cd602615f74a77e1','605-806-2454'),
('97','Arlie','Armstrong','alba.rath@example.org','2ada50c7919d4d7ac22802f008e97466036dda1d','(673)290-296'),
('98','Emmalee','Aufderhar','icassin@example.net','e21488f045e2442a925ffa13b02fd2ef4629aa02','222.302.4290'),
('99','Addie','Carroll','vnikolaus@example.com','5562023c8f54211d2389ad62ea4f190c5de73f0a','817.130.2630'),
('100','Tiffany','Friesen','llewellyn.okuneva@example.net','69129995e1894c8df09e7a5aeffcf58fceae55ec','1-849-655-62'); 




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

