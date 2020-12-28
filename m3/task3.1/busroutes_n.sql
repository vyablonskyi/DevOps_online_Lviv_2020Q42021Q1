-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: d1.c724bfxym5yf.eu-central-1.rds.amazonaws.com    Database: busroutes
-- ------------------------------------------------------
-- Server version	8.0.20

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `BUS`
--

DROP TABLE IF EXISTS `BUS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BUS` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `license_plate` char(8) NOT NULL,
  `inspection` date NOT NULL,
  `route_id` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `carlicence` (`license_plate`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BUS`
--

LOCK TABLES `BUS` WRITE;
/*!40000 ALTER TABLE `BUS` DISABLE KEYS */;
INSERT INTO `BUS` VALUES (1,'BC0345AA','2012-03-20',23),(2,'BC0335AA','2021-04-20',23),(3,'BC0325AA','2021-04-20',23),(4,'BC0315AA','2028-11-20',45),(5,'BC3467BC','2018-10-20',45),(6,'BC3468BC','2018-10-20',45),(7,'BC4563CA','2031-12-20',23),(8,'BC7777BB','2023-01-20',23),(9,'BC0987BB','2023-01-20',76),(10,'BC5463BC','2013-04-20',76);
/*!40000 ALTER TABLE `BUS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daylog`
--

DROP TABLE IF EXISTS `daylog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daylog` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `route_id` int NOT NULL,
  `bus_id` int NOT NULL,
  `driver_id` int NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `countoftrips` int NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daylog`
--

LOCK TABLES `daylog` WRITE;
/*!40000 ALTER TABLE `daylog` DISABLE KEYS */;
INSERT INTO `daylog` VALUES (1,76,10,5,'2020-12-24 06:30:00','2020-12-24 15:30:00',4),(2,23,7,11,'2020-12-24 06:40:00','2020-12-24 15:45:00',4),(3,23,1,3,'2020-12-24 06:40:00','2020-12-24 15:45:00',4),(4,76,9,1,'2020-12-24 05:45:00','2020-12-24 13:45:00',3),(5,45,6,9,'2020-12-24 06:30:00','2020-12-24 15:30:00',7);
/*!40000 ALTER TABLE `daylog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `driver`
--

DROP TABLE IF EXISTS `driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `driver` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `licence` char(10) NOT NULL,
  `Name` char(30) NOT NULL,
  `lname` char(30) NOT NULL,
  `bus_id` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `licence` (`licence`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driver`
--

LOCK TABLES `driver` WRITE;
/*!40000 ALTER TABLE `driver` DISABLE KEYS */;
INSERT INTO `driver` VALUES (1,'AA7654675','John','Lennon',9),(2,'XT6755425','Sarra','Konnor',3),(3,'BX4785434','Elton','John',1),(4,'BX4785433','Koty','Riker',1),(5,'AS4573903','Tom','Morris',10),(6,'AS4763898','Neo','Matrix',8),(7,'XX4763845','Atrhur','King',4),(8,'XS3763834','Pappa','Roach',2),(9,'OO3345534','Vasia','Pupkin',6),(10,'BB0998876','Vitia','Yanukovych',7),(11,'BB6666666','Mikola','Azirov',7),(12,'GT9595959','Vova','Bubochka',5);
/*!40000 ALTER TABLE `driver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route` (
  `ID` int NOT NULL,
  `lenght` int NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (23,16,'06:00:00','23:30:00'),(45,8,'06:30:00','22:45:00'),(76,25,'05:45:00','00:15:00');
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-28  0:37:45
