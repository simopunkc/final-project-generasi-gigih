DROP TABLE IF EXISTS `tb_member`;
CREATE TABLE `tb_member` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `email` varchar(60) NOT NULL,
  `bio` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
LOCK TABLES `tb_member` WRITE;
INSERT INTO `tb_member` (id,username,email,bio) VALUES (1,'admin','admin@web.com','saya admin lho'),(2,'user2','user2@web.com','saya user 2'),(3,'user3','user3@web.com','saya user 3');
UNLOCK TABLES;


DROP TABLE IF EXISTS `tb_post`;
CREATE TABLE `tb_post` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_member` int(10) NOT NULL,
  `id_parent_post` int(10) NOT NULL DEFAULT 0,
  `text` text NOT NULL,
  `waktu` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_member`) REFERENCES tb_member(`id`),
  KEY `id_parent_post` (`id_parent_post`),
  FULLTEXT KEY `text` (`text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
LOCK TABLES `tb_post` WRITE;
INSERT INTO `tb_post` (id,id_member,text) VALUES (1,1,'lorem ipsum #gigih'),(2,2,'lorem ipsum #bisa'),(3,3,'lorem #bisa ipsum'),(4,1,'lorem ipsum #generasi'),(5,1,'lorem ipsum #bisa'),(6,1,'lorem #gigih ipsum'),(7,1,'ipsum #gigih ipsum'),(8,1,'#gigih lorem ipsum');
INSERT INTO `tb_post` (id,id_member,id_parent_post,text) VALUES (9,1,1,'comment ipsum #gigih'),(10,1,1,'comment lorem ipsum #bisa'),(11,3,1,'lorem #bisa ipsum');
UNLOCK TABLES;


DROP TABLE IF EXISTS `tb_hashtag`;
CREATE TABLE `tb_hashtag` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `hashtag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashtag` (`hashtag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
LOCK TABLES `tb_hashtag` WRITE;
INSERT INTO `tb_hashtag` (id,hashtag) VALUES (1,'gigih'),(2,'generasi'),(3,'bisa');
UNLOCK TABLES;


DROP TABLE IF EXISTS `tb_hashtag_post`;
CREATE TABLE `tb_hashtag_post` (
  `id_hashtag` int(10) NOT NULL,
  `id_post` int(10) NOT NULL,
  FOREIGN KEY (`id_hashtag`) REFERENCES tb_hashtag(`id`),
  FOREIGN KEY (`id_post`) REFERENCES tb_post(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
LOCK TABLES `tb_hashtag_post` WRITE;
INSERT INTO `tb_hashtag_post` (id_hashtag,id_post) VALUES (1,1),(3,2),(3,3),(2,4),(3,5),(1,6),(1,7),(1,8);
UNLOCK TABLES;


DROP TABLE IF EXISTS `tb_media`;
CREATE TABLE `tb_media` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `lokasi` varchar(255) NOT NULL,
  `mime` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lokasi` (`lokasi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
LOCK TABLES `tb_media` WRITE;
INSERT INTO `tb_media` (id,lokasi,mime) VALUES (1,'upload/member1/2021-August-10/test-reflektif.txt','');
UNLOCK TABLES;


DROP TABLE IF EXISTS `tb_post_media`;
CREATE TABLE `tb_post_media` (
  `id_post` int(10) NOT NULL,
  `id_media` int(10) NOT NULL,
  FOREIGN KEY (`id_post`) REFERENCES tb_post(`id`),
  FOREIGN KEY (`id_media`) REFERENCES tb_media(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
LOCK TABLES `tb_post_media` WRITE;
INSERT INTO `tb_post_media` (id_post,id_media) VALUES (1,1);
UNLOCK TABLES;