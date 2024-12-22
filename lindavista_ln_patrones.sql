-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: lindavista
-- ------------------------------------------------------
-- Server version	8.4.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ln_patrones`
--

DROP TABLE IF EXISTS `ln_patrones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ln_patrones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `patron` varchar(255) NOT NULL,
  `consultasql` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ln_patrones`
--

LOCK TABLES `ln_patrones` WRITE;
/*!40000 ALTER TABLE `ln_patrones` DISABLE KEYS */;
INSERT INTO `ln_patrones` VALUES (1,'busco tipo','SELECT * FROM viviendas WHERE tipo = \'%1\''),(2,'busco zona','SELECT * FROM viviendas WHERE zona = \'%1\''),(3,'busco tipo zona','SELECT * FROM viviendas WHERE tipo = \'%1\' AND zona = \'%2\''),(4,'busco tipo numero dormitorios zona','SELECT * FROM viviendas WHERE tipo = \'%1\' AND ndormitorios = \'%2\' AND zona = \'%3\''),(5,'deseo una casa en el centro o en Nervión','SELECT * FROM viviendas WHERE zona = \'Centro\' OR zona = \'Nervión\''),(6,'deseo un piso barato','SELECT * FROM viviendas WHERE precio < 200000'),(7,'deseo un piso con más de dos dormitorios en el centro','SELECT * FROM viviendas WHERE ndormitorios > 2 AND zona = \'Centro\''),(8,'deseo una casa de más de 100 metros cuadrados','SELECT * FROM viviendas WHERE tamano > 100'),(9,'deseo un piso en Nervión con garaje','SELECT * FROM viviendas WHERE zona = \'Nervión\' AND extras LIKE \'%Garage%\'');
/*!40000 ALTER TABLE `ln_patrones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-21 21:28:55
