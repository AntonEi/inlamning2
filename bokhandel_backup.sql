-- MySQL dump 10.13  Distrib 9.5.0, for Win64 (x86_64)
--
-- Host: localhost    Database: bokhandel
-- ------------------------------------------------------
-- Server version	9.5.0

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

--
-- Table structure for table `bestallningar`
--

DROP TABLE IF EXISTS `bestallningar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bestallningar` (
  `bestallning_id` int NOT NULL AUTO_INCREMENT,
  `kund_id` int DEFAULT NULL,
  `datum` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bestallning_id`),
  KEY `kund_id` (`kund_id`),
  CONSTRAINT `bestallningar_ibfk_1` FOREIGN KEY (`kund_id`) REFERENCES `kunder` (`kund_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestallningar`
--

LOCK TABLES `bestallningar` WRITE;
/*!40000 ALTER TABLE `bestallningar` DISABLE KEYS */;
INSERT INTO `bestallningar` VALUES (1,1,'2026-04-07 21:01:53'),(2,1,'2026-04-07 21:01:53'),(3,1,'2026-04-07 21:01:53'),(4,2,'2026-04-07 21:01:53'),(5,3,'2026-04-07 21:01:53');
/*!40000 ALTER TABLE `bestallningar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bestallningsrader`
--

DROP TABLE IF EXISTS `bestallningsrader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bestallningsrader` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bestallning_id` int DEFAULT NULL,
  `produkt_id` int DEFAULT NULL,
  `antal` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bestallning_id` (`bestallning_id`),
  KEY `produkt_id` (`produkt_id`),
  CONSTRAINT `bestallningsrader_ibfk_1` FOREIGN KEY (`bestallning_id`) REFERENCES `bestallningar` (`bestallning_id`),
  CONSTRAINT `bestallningsrader_ibfk_2` FOREIGN KEY (`produkt_id`) REFERENCES `produkter` (`produkt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestallningsrader`
--

LOCK TABLES `bestallningsrader` WRITE;
/*!40000 ALTER TABLE `bestallningsrader` DISABLE KEYS */;
INSERT INTO `bestallningsrader` VALUES (1,1,1,1),(2,1,2,2),(3,2,3,1),(4,3,1,1),(5,4,2,1);
/*!40000 ALTER TABLE `bestallningsrader` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `minska_lager` AFTER INSERT ON `bestallningsrader` FOR EACH ROW BEGIN
    UPDATE produkter
    SET lagersaldo = lagersaldo - NEW.antal
    WHERE produkt_id = NEW.produkt_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kunder`
--

DROP TABLE IF EXISTS `kunder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kunder` (
  `kund_id` int NOT NULL AUTO_INCREMENT,
  `namn` varchar(100) DEFAULT NULL,
  `epost` varchar(100) DEFAULT NULL,
  `telefon` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kund_id`),
  KEY `idx_epost` (`epost`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kunder`
--

LOCK TABLES `kunder` WRITE;
/*!40000 ALTER TABLE `kunder` DISABLE KEYS */;
INSERT INTO `kunder` VALUES (1,'Anna Andersson','ny@mail.se','0701111111'),(2,'Bjorn Berg','bjorn@test.se','0702222222'),(3,'Clara Carlsson','clara@test.se','0703333333'),(4,'David Dahl','david@test.se','0704444444');
/*!40000 ALTER TABLE `kunder` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `logga_kund` AFTER INSERT ON `kunder` FOR EACH ROW BEGIN
    INSERT INTO kundlogg (kund_id, namn, epost)
    VALUES (NEW.kund_id, NEW.namn, NEW.epost);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kundlogg`
--

DROP TABLE IF EXISTS `kundlogg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kundlogg` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kund_id` int DEFAULT NULL,
  `namn` varchar(100) DEFAULT NULL,
  `epost` varchar(100) DEFAULT NULL,
  `datum` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kundlogg`
--

LOCK TABLES `kundlogg` WRITE;
/*!40000 ALTER TABLE `kundlogg` DISABLE KEYS */;
INSERT INTO `kundlogg` VALUES (1,1,'Anna Andersson','anna@test.se','2026-04-07 21:01:53'),(2,2,'Bjorn Berg','bjorn@test.se','2026-04-07 21:01:53'),(3,3,'Clara Carlsson','clara@test.se','2026-04-07 21:01:53'),(4,4,'David Dahl','david@test.se','2026-04-07 21:01:53');
/*!40000 ALTER TABLE `kundlogg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkter`
--

DROP TABLE IF EXISTS `produkter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produkter` (
  `produkt_id` int NOT NULL AUTO_INCREMENT,
  `titel` varchar(100) DEFAULT NULL,
  `forfattare` varchar(100) DEFAULT NULL,
  `pris` int DEFAULT NULL,
  `lagersaldo` int DEFAULT NULL,
  PRIMARY KEY (`produkt_id`),
  CONSTRAINT `produkter_chk_1` CHECK ((`pris` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkter`
--

LOCK TABLES `produkter` WRITE;
/*!40000 ALTER TABLE `produkter` DISABLE KEYS */;
INSERT INTO `produkter` VALUES (1,'Sagan om Ringen','Tolkien',199,8),(2,'1984','Orwell',129,17),(3,'Clean Code','Robert Martin',349,4);
/*!40000 ALTER TABLE `produkter` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-07 21:06:39
