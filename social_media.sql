create database social_media;

use social_media;
  create table Users (
  id int NOT NULL AUTO_INCREMENT,
  username varchar(256) NOT NULL UNIQUE,
  email varchar(255) NOT NULL,
  bio varchar(255) default NULL,
  primary key (id)
  );

  create table Posts (
  id int NOT NULL AUTO_INCREMENT,
  id_user int NOT NULL,
  caption varchar(1000) default NULL,
  attachment varchar(256) default NULL,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  KEY `id_user` (`id_user`),
  CONSTRAINT `id_user_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `Users` (`id`),
  primary key (id)
  );

  create table Comments (
  id int NOT NULL AUTO_INCREMENT,
  id_user int NOT NULL,
  id_post int NOT NULL,
  comment varchar(1000) default NULL,
  attachment varchar(256) default NULL,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  KEY `id_user` (`id_user`),
  KEY `id_post` (`id_post`),
  CONSTRAINT `id_user_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `Users` (`id`),
  CONSTRAINT `id_post_ibfk_1` FOREIGN KEY (`id_post`) REFERENCES `Posts` (`id`),
  primary key (id)
  );

  create table Hastags (
  id int NOT NULL AUTO_INCREMENT,
  hastag varchar(256) UNIQUE,
  primary key (id)
  );

  create table Post_hastags (
  id int NOT NULL AUTO_INCREMENT,
  id_post int default NULL,
  id_hastag int NOT NULL,
  id_comment int default NULL,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  KEY `id_post` (`id_post`),
  KEY `id_hastag` (`id_hastag`),
  KEY `id_comment` (`id_comment`),
  CONSTRAINT `id_post_ibfk_2` FOREIGN KEY (`id_post`) REFERENCES `Posts` (`id`),
  CONSTRAINT `id_hastag_ibfk_1` FOREIGN KEY (`id_hastag`) REFERENCES `Hastags` (`id`),
  CONSTRAINT `id_comment_ibfk_1` FOREIGN KEY (`id_comment`) REFERENCES `Comments` (`id`),
  primary key (id)
  );
