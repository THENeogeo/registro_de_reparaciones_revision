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
-- Table structure for table `refacciones`
--

DROP TABLE IF EXISTS `refacciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refacciones` (
  `refaccion_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `refaccion_inventario` varchar(50) DEFAULT NULL,
  `tipo_id` int DEFAULT NULL,
  `tipo_ref_id` int DEFAULT NULL,
  PRIMARY KEY (`refaccion_id`),
  KEY `fk_refacciones_tipo` (`tipo_id`),
  KEY `fk_refaccion_tipo_ref` (`tipo_ref_id`),
  CONSTRAINT `fk_refaccion_tipo_ref` FOREIGN KEY (`tipo_ref_id`) REFERENCES `tipo_refaccion` (`tipo_ref_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_refacciones_tipo` FOREIGN KEY (`tipo_id`) REFERENCES `tipos_equipos` (`tipo_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refacciones`
--

LOCK TABLES `refacciones` WRITE;
/*!40000 ALTER TABLE `refacciones` DISABLE KEYS */;
INSERT INTO `refacciones` VALUES (7,'Kit De Mantenimiento','UIBSAS00-9KIJ96',3,NULL),(8,'Unidad de Imagen','S/N',3,2),(9,'Cinta','UIBS002',3,1),(10,'Fusor','UIBS0011',3,1),(11,'Rodillos','UIBS007',3,2),(12,'Sensor de papel','UIBSHHD-099988J',3,2),(13,'Tarjeta Lógica',NULL,3,NULL),(14,'Fuente de Alimentación',NULL,3,NULL),(15,'Disco Duro',NULL,1,NULL),(16,'Memoria RAM','S/N',1,2),(17,'Fuente de Poder',NULL,1,NULL),(18,'Tarjeta Madre','UIUBS9080-98222',1,1),(19,'Procesador','UIBS007',1,2),(20,'Tarjeta de Red','UIBS001',1,2),(21,'Disco Duro','UIBS003',2,2),(22,'Memoria RAM','inventario2',2,1),(23,'Fuente de Poder',NULL,2,NULL),(24,'Tarjeta Madre','UIBS011',2,1),(25,'Procesador',NULL,2,NULL),(26,'Batería CMOS','UIBS010',1,2),(27,'Batería CMOS','UIBS0010',2,2);
/*!40000 ALTER TABLE `refacciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-02 14:47:23
