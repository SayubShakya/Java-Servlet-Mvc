-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: crud
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE crud_new;

USE crud_new;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin','2025-07-01 08:37:14',NULL,1),(2,'Editor','2025-07-01 08:37:14',NULL,1),(3,'Viewer','2025-07-01 08:37:14',NULL,1),(4,'CHEF','2025-07-07 09:43:02',NULL,1);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `totp_secret_key` varchar(255) DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_email` (`email`),
  KEY `fk_role_id` (`role_id`),
  CONSTRAINT `fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (12,'Manjits','Shakya','9825545122','mnzitshakya@gmail.com','123123','2025-06-27 11:08:15','2025-07-08 09:29:27',1,'EZQHE7IKSX7F7KGYPCWG2ZADMES6OLFJ',1),(13,'ram','shakya','9898878766','ram123@gmail.com','321','2025-06-29 13:22:46','2025-07-08 09:29:27',1,'4XLW3BYMLCG6QTPYO5SNWRDQTABCFB46',1),(14,'sayub','shakya','9828897288','sayub@gmail.com','123','2025-06-29 13:27:35','2025-07-08 09:29:27',1,'R7W3YLGEW3ZZWKP4G6BEX4NYW7UKT4OB',1),(15,'sus','Shakya','9898878766','sus@gmail.com','123','2025-06-29 14:03:53','2025-07-08 09:29:27',1,'YTI5Y4NHMHEVD6W52T5VFWOISHJBOOEW',1),(16,'shri','shakya','9898878766','shri123@gmail.com','123','2025-06-29 16:47:34','2025-07-08 09:37:40',1,'VQMI7XRBLVH2A6NZKSFPWXZEG3JXK7G2',1),(17,'sam','shakya','9878877099','sam@gmail.com','123','2025-06-29 17:24:07','2025-07-08 09:37:40',1,'ZGQHVBK2QGBFKRJVMFNWPVH4TKEC5NMK',1),(18,'dip','shakya','9890098988','dipesh@gmail.com','123','2025-06-30 01:51:39','2025-07-08 09:37:40',1,'B4ATTMBFQNVLXWLPR47STRMWCAGEI5RE',1),(19,'aayush','shakya','988988980','aayush123@gmail.com','123','2025-06-30 02:01:48','2025-07-08 09:37:40',1,'OYZBVCZVYGX55IH4IMA77DMDJWDXXUHK',1),(20,'test','test','9898898788','test@gmail.com','123','2025-06-30 02:23:42','2025-07-08 09:37:40',1,'IOU5IALDXS4JLPVIR6PIZPH5SRC3BVKJ',1),(21,'ram','ram','9898878766','ram@gmail.com','123','2025-06-30 02:37:37','2025-07-08 09:37:40',1,'QVREIIKQUZNY676BJXZL33ZZUQHHZUUJ',1),(22,'radha','kumar','69696969','radha@kumar.com','123','2025-06-30 11:09:34','2025-07-08 09:37:40',1,'RPARI2GG5ZBGBLGFM7WQ6F5AYOIUI3PR',1),(23,'aayush','shakya','9898878766','aayush@gmail.com','123','2025-07-01 02:28:49','2025-07-08 09:37:40',1,'T2AHWBMXLZK6WG7ENGHFWG2DRZIINUZZ',1),(24,'editor','shakya','9898898788','editor@gmail.com','123','2025-07-03 11:13:47','2025-07-08 09:37:40',1,'N5X2U4BG6BSEOXOMTW6GVM56CTFJRTV6',2),(25,'one','shakya','1111111111','one@gmail.com','123','2025-07-08 09:40:08',NULL,1,'XNF66JBJB2GELVGK7TWEGRBQNNV6MBDQ',3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-08 15:43:04
