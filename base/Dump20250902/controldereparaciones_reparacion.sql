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
-- Table structure for table `reparacion`
--

DROP TABLE IF EXISTS `reparacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reparacion` (
  `reparacion_id` int NOT NULL AUTO_INCREMENT,
  `inventario` varchar(15) DEFAULT NULL,
  `refaccion_id` int DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `usuario_id` int NOT NULL,
  `modelo_id` int NOT NULL,
  `hora` time DEFAULT NULL,
  PRIMARY KEY (`reparacion_id`),
  KEY `refaccion_id` (`refaccion_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `fk_reparacion_modelo` (`modelo_id`),
  CONSTRAINT `fk_reparacion_modelo` FOREIGN KEY (`modelo_id`) REFERENCES `modelos` (`modelo_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `reparacion_ibfk_1` FOREIGN KEY (`refaccion_id`) REFERENCES `refacciones` (`refaccion_id`),
  CONSTRAINT `reparacion_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reparacion`
--

LOCK TABLES `reparacion` WRITE;
/*!40000 ALTER TABLE `reparacion` DISABLE KEYS */;
INSERT INTO `reparacion` VALUES (14,'5151000138-0199',18,'Se remplaza la tarjeta madre.','2025-08-15 00:00:00',14,2,'14:56:37'),(15,'5151000138-0566',22,'Se aumenta la memoria RAM del equipo.','2025-08-15 00:00:00',15,8,'16:38:14'),(17,'5151000138-0897',12,'Se remplaza sensor de hojas de la charola principal.','2025-08-15 00:00:00',18,5,'17:15:21'),(18,'5151000138-0001',20,'Se agrega tarjeta de red.','2025-08-15 00:00:00',19,1,'17:20:03'),(19,'5151000138-0002',9,'Se remplaza la cinta.','2025-08-15 00:00:00',20,6,'17:22:26'),(20,'5151000138-0003',21,'Se remplaza el disco duro por un SSD.','2025-08-15 00:00:00',21,7,'17:24:36'),(21,'5151000138-0004',8,'Se remplaza la unidad de imagen.','2025-08-15 00:00:00',22,4,'17:26:59'),(22,'5151000138-0005',19,'Se remplaza procesador.','2025-08-15 00:00:00',23,2,'17:29:02'),(23,'5151000138-0006',19,'Se remplaza el procesador.','2025-08-15 00:00:00',30,1,'17:44:02'),(24,'5151000138-0007',11,'Se remplaza el rodillo de la charola principal.','2025-08-15 00:00:00',31,5,'17:50:02'),(25,'5151000138-0093',10,'Se remplaza fusor.','2025-08-18 00:00:00',35,5,'10:21:20'),(26,'5151000138-0009',26,'Se remplaza la batería del CMOS.','2025-08-20 00:00:00',36,1,'10:03:24'),(27,'5151000138-1111',16,'Descripción p1','2025-08-20 00:00:00',37,2,'10:16:04'),(28,'5151000138-0094',22,'Memoria Ram','2025-08-21 00:00:00',38,7,'12:38:50'),(29,'5151000138-0010',27,'Se remplaza la batería CMOS.','2025-08-25 00:00:00',39,8,'12:57:12'),(30,'5151000138-0011',24,'Se remplaza la tarjeta madre.','2025-08-25 00:00:00',40,7,'14:06:47'),(31,'5151000138-0012',10,'Se remplaza fusor.','2025-08-27 00:00:00',48,5,'09:49:23'),(32,'5151000138-0045',16,'Se aumenta la memoria RAM.','2025-08-28 00:00:00',57,2,'11:54:57'),(33,'5151000138-0087',8,'Se remplaza la unidad de imagen.','2025-09-02 00:00:00',59,5,'10:36:30');
/*!40000 ALTER TABLE `reparacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-02 14:47:25
