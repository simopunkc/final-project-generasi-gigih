CREATE DATABASE db_generasigigih;
CREATE USER 'gigih'@'localhost' IDENTIFIED BY 'gigih';
GRANT ALL PRIVILEGES ON db_generasigigih.* TO 'gigih'@'localhost';
FLUSH PRIVILEGES;


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
UNLOCK TABLES;


DROP TABLE IF EXISTS `tb_post`;
CREATE TABLE `tb_post` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_member` int(10) NOT NULL,
  `id_parent_post` int(10) DEFAULT NULL,
  `text` text NOT NULL,
  `waktu` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_member`) REFERENCES tb_member(`id`),
  KEY `id_parent_post` (`id_parent_post`),
  FULLTEXT KEY `text` (`text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
LOCK TABLES `tb_post` WRITE;
UNLOCK TABLES;


DROP TABLE IF EXISTS `tb_hashtag_post`;
CREATE TABLE `tb_hashtag_post` (
  `id_hashtag` int(10) NOT NULL,
  `id_post` int(10) NOT NULL,
  FOREIGN KEY (`id_hashtag`) REFERENCES tb_hashtag(`id`),
  FOREIGN KEY (`id_post`) REFERENCES tb_post(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
LOCK TABLES `tb_hashtag_post` WRITE;
UNLOCK TABLES;


DROP TABLE IF EXISTS `tb_hashtag`;
CREATE TABLE `tb_hashtag` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `hashtag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashtag` (`hashtag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
LOCK TABLES `tb_hashtag` WRITE;
UNLOCK TABLES;