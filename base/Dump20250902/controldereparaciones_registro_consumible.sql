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
-- Table structure for table `registro_consumible`
--

DROP TABLE IF EXISTS `registro_consumible`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro_consumible` (
  `reg_consumible_id` int NOT NULL AUTO_INCREMENT,
  `consumible_id` int DEFAULT NULL,
  `inventario` varchar(15) DEFAULT NULL,
  `tipo_ref_id` int DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `usuario_id` int DEFAULT NULL,
  `area_id` int DEFAULT NULL,
  `marca` varchar(100) DEFAULT NULL,
  `modelo` varchar(100) DEFAULT NULL,
  `fecha` date DEFAULT (curdate()),
  `hora` time DEFAULT (curtime()),
  PRIMARY KEY (`reg_consumible_id`),
  KEY `consumible_id` (`consumible_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `area_id` (`area_id`),
  KEY `fk_tipo_ref` (`tipo_ref_id`),
  CONSTRAINT `fk_tipo_ref` FOREIGN KEY (`tipo_ref_id`) REFERENCES `tipo_refaccion` (`tipo_ref_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `registro_consumible_ibfk_1` FOREIGN KEY (`consumible_id`) REFERENCES `catalogo_consumibles` (`consumible_id`),
  CONSTRAINT `registro_consumible_ibfk_3` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`),
  CONSTRAINT `registro_consumible_ibfk_4` FOREIGN KEY (`area_id`) REFERENCES `areas` (`area_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro_consumible`
--

LOCK TABLES `registro_consumible` WRITE;
/*!40000 ALTER TABLE `registro_consumible` DISABLE KEYS */;
INSERT INTO `registro_consumible` VALUES (18,2,'5151000234-0046',2,'Se entrega teclado nuevo.',55,2,'Vorago','STG','2025-08-27','12:52:51'),(19,3,'00',2,'Se remplaza el cable DisplayPort en equipo de cómputo',56,3,'Genérica','Genérico','2025-08-27','16:01:57'),(20,4,'0',2,'Se toman bote de conectores.',58,2,'Keystone','RJ45','2025-08-28','11:56:17'),(21,8,'5151000234-0043',2,'Se reemplaza router del área.',60,3,'TP-Link','A500','2025-09-02','10:41:44');
/*!40000 ALTER TABLE `registro_consumible` ENABLE KEYS */;
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
