-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: controldereparaciones
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `usuario_id` int NOT NULL AUTO_INCREMENT,
  `expediente` varchar(5) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `area_id` int NOT NULL,
  PRIMARY KEY (`usuario_id`),
  KEY `area_id` (`area_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `areas` (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'21111','Jorge',1),(2,'23444','Pedro',1),(3,'23315','Eunice Platanares',1),(4,'23122','Ernesto la Guardia',1),(5,'24555','Eva María',1),(6,'12099','Eduardo Perez',1),(7,'00000','Mariana V.',1),(8,'19002','Gerardo V.',1),(9,'23706','Geovani Ramirez',1),(10,'23706','Geovani Peña',2),(11,'23707','Osvaldo Guerrero',3),(12,'23706','pablo',2),(13,'22706','Eduardo P.',3),(14,'23706','Geovani Ramirez',2),(15,'23707','Osvaldo Guerrero',3),(16,'23709','Eduardo Martinez',3),(17,'23709','Eduardo Martinez',3),(18,'23709','Eduardo Martinez',3),(19,'23710','Carlos Sanchez',4),(20,'23711','Soporte 01',2),(21,'23712','Angie Vasquez',4),(22,'23713','Soporte 02',3),(23,'23714','Soporte 03',2),(24,'23715','Soporte 04',1),(25,'23715','Soporte 04',1),(26,'23715','Soporte 04',1),(27,'23715','Soporte 04',1),(28,'23715','Soporte 04',1),(29,'23715','Soporte 04',1),(30,'23715','Soporte 05',1),(31,'23716','Soporte 06',4),(32,'23717','Geovani Ramirez',3),(33,'23718','Soporte 07',1),(34,'23718','Soporte 07',1),(35,'23718','Soporte 07',1),(36,'23717','Soporte 10',2),(37,'np','P1',2),(38,'23719','Sopor12',3),(39,'23720','Soporte A',2),(40,'','Soporte B',1),(41,NULL,'Eunice Platanares',2),(42,NULL,'Eunice Platanares',2),(43,NULL,'Eunice Platanares',5),(44,NULL,'Marco Solis',5),(45,NULL,'Diego Solares',4),(46,NULL,'Carlos Enrique',5),(47,NULL,'Jorge Campos',5),(48,'','Karla Pozos Mejia',4),(49,NULL,'rfrffr rfrf ',5),(50,NULL,'Jorge Rosas',5),(51,NULL,'Jorge Rosas',5),(52,NULL,'Jorge Rosas',5),(53,NULL,'Jorge Rosas',5),(54,NULL,'Jorge Rosas',5),(55,NULL,'Ing Cochio',2),(56,NULL,'Miguel Veracruz',3),(57,'','Ricardo Salinas',3),(58,NULL,'Geovani Pena',2),(59,'23800','Karina Mejia',5),(60,NULL,'Marco Antonio',3);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-02 14:47:26
