DROP DATABASE IF EXISTS db_generasigigih;
CREATE DATABASE db_generasigigih;
DROP USER IF EXISTS 'gigih'@'localhost';
CREATE USER 'gigih'@'localhost' IDENTIFIED BY 'gigih';
GRANT ALL PRIVILEGES ON db_generasigigih.* TO 'gigih'@'localhost';
FLUSH PRIVILEGES;
USE db_generasigigih;