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
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `areas` (
  `area_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`area_id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` VALUES (1,'Gerencia de Tecnologías de la Información y Comunicaciones'),(4,'Subgerencia de Gestión y Supervisión de Tecnologías de Peaje'),(2,'Subgerencia de Infraestructura Informática y de Comunicaciones'),(3,'Subgerencia de Sistemas de Información');
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_consumibles`
--

DROP TABLE IF EXISTS `catalogo_consumibles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_consumibles` (
  `consumible_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`consumible_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_consumibles`
--

LOCK TABLES `catalogo_consumibles` WRITE;
/*!40000 ALTER TABLE `catalogo_consumibles` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogo_consumibles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos` (
  `equipo_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `marca_id` int NOT NULL,
  `modelo_id` int NOT NULL,
  PRIMARY KEY (`equipo_id`),
  KEY `marca_id` (`marca_id`),
  KEY `modelo_id` (`modelo_id`),
  CONSTRAINT `equipos_ibfk_1` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`marca_id`),
  CONSTRAINT `equipos_ibfk_2` FOREIGN KEY (`modelo_id`) REFERENCES `modelos` (`modelo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcas`
--

DROP TABLE IF EXISTS `marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marcas` (
  `marca_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `tipo_id` int NOT NULL,
  PRIMARY KEY (`marca_id`),
  KEY `tipo_id` (`tipo_id`),
  CONSTRAINT `marcas_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipos_equipos` (`tipo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas`
--

LOCK TABLES `marcas` WRITE;
/*!40000 ALTER TABLE `marcas` DISABLE KEYS */;
INSERT INTO `marcas` VALUES (1,'HP',1),(2,'Dell',1),(3,'HP',2),(4,'Acer',2),(5,'Lexmark',3),(6,'Evolis',3);
/*!40000 ALTER TABLE `marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modelos`
--

DROP TABLE IF EXISTS `modelos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modelos` (
  `modelo_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `marca_id` int NOT NULL,
  PRIMARY KEY (`modelo_id`),
  KEY `fk_modelo_marca` (`marca_id`),
  CONSTRAINT `fk_modelo_marca` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`marca_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modelos`
--

LOCK TABLES `modelos` WRITE;
/*!40000 ALTER TABLE `modelos` DISABLE KEYS */;
INSERT INTO `modelos` VALUES (1,'Compaq',1),(2,'Elitedesk',1),(3,'Optiplex',2),(4,'MS610dn',5),(5,'MS811dn',5),(6,'Primary',6),(7,'Pavilion',3),(8,'TravelMate',4);
/*!40000 ALTER TABLE `modelos` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `refacciones` VALUES (7,'Kit De Mantenimiento','UIBSAS00-9KIJ96',3,NULL),(8,'Unidad de Imagen','UIBS004',3,1),(9,'Cinta','UIBS002',3,1),(10,'Fusor','UIBS009',3,1),(11,'Rodillos','UIBS007',3,2),(12,'Sensor de papel','UIBSHHD-099988J',3,2),(13,'Tarjeta Lógica',NULL,3,NULL),(14,'Fuente de Alimentación',NULL,3,NULL),(15,'Disco Duro',NULL,1,NULL),(16,'Memoria RAM','inventariop1',1,1),(17,'Fuente de Poder',NULL,1,NULL),(18,'Tarjeta Madre','UIUBS9080-98222',1,1),(19,'Procesador','UIBS007',1,2),(20,'Tarjeta de Red','UIBS001',1,2),(21,'Disco Duro','UIBS003',2,2),(22,'Memoria RAM','UIBS006',2,2),(23,'Fuente de Poder',NULL,2,NULL),(24,'Tarjeta Madre','UIBS008',2,2),(25,'Procesador',NULL,2,NULL),(26,'Batería CMOS','UIBS010',1,2),(27,'Batería CMOS',NULL,2,NULL);
/*!40000 ALTER TABLE `refacciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro_consumible`
--

DROP TABLE IF EXISTS `registro_consumible`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro_consumible` (
  `reg_consumible_id` int NOT NULL,
  `consumible_id` int DEFAULT NULL,
  `inventario` varchar(15) DEFAULT NULL,
  `tipo_ref_id` int DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `usuario_id` int DEFAULT NULL,
  `area_id` int DEFAULT NULL,
  PRIMARY KEY (`reg_consumible_id`),
  KEY `consumible_id` (`consumible_id`),
  KEY `tipo_ref_id` (`tipo_ref_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `area_id` (`area_id`),
  CONSTRAINT `registro_consumible_ibfk_1` FOREIGN KEY (`consumible_id`) REFERENCES `catalogo_consumibles` (`consumible_id`),
  CONSTRAINT `registro_consumible_ibfk_2` FOREIGN KEY (`tipo_ref_id`) REFERENCES `refacciones` (`tipo_ref_id`),
  CONSTRAINT `registro_consumible_ibfk_3` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`),
  CONSTRAINT `registro_consumible_ibfk_4` FOREIGN KEY (`area_id`) REFERENCES `areas` (`area_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro_consumible`
--

LOCK TABLES `registro_consumible` WRITE;
/*!40000 ALTER TABLE `registro_consumible` DISABLE KEYS */;
/*!40000 ALTER TABLE `registro_consumible` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reparacion`
--

LOCK TABLES `reparacion` WRITE;
/*!40000 ALTER TABLE `reparacion` DISABLE KEYS */;
INSERT INTO `reparacion` VALUES (14,'5151000138-0199',18,'Se remplaza la tarjeta madre.','2025-08-15 00:00:00',14,2,'14:56:37'),(15,'5151000138-0566',22,'Se aumenta la memoria RAM del equipo.','2025-08-15 00:00:00',15,8,'16:38:14'),(17,'5151000138-0897',12,'Se remplaza sensor de hojas de la charola principal.','2025-08-15 00:00:00',18,5,'17:15:21'),(18,'5151000138-0001',20,'Se agrega tarjeta de red.','2025-08-15 00:00:00',19,1,'17:20:03'),(19,'5151000138-0002',9,'Se remplaza la cinta.','2025-08-15 00:00:00',20,6,'17:22:26'),(20,'5151000138-0003',21,'Se remplaza el disco duro por un SSD.','2025-08-15 00:00:00',21,7,'17:24:36'),(21,'5151000138-0004',8,'Se remplaza la unidad de imagen.','2025-08-15 00:00:00',22,4,'17:26:59'),(22,'5151000138-0005',19,'Se remplaza procesador.','2025-08-15 00:00:00',23,2,'17:29:02'),(23,'5151000138-0006',19,'Se remplaza el procesador.','2025-08-15 00:00:00',30,1,'17:44:02'),(24,'5151000138-0007',11,'Se remplaza el rodillo de la charola principal.','2025-08-15 00:00:00',31,5,'17:50:02'),(25,'5151000138-0093',10,'Se remplaza fusor.','2025-08-18 00:00:00',35,5,'10:21:20'),(26,'5151000138-0009',26,'Se remplaza la batería del CMOS.','2025-08-20 00:00:00',36,1,'10:03:24'),(27,'5151000138-1111',16,'Descripción p1','2025-08-20 00:00:00',37,2,'10:16:04');
/*!40000 ALTER TABLE `reparacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_refaccion`
--

DROP TABLE IF EXISTS `tipo_refaccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_refaccion` (
  `tipo_ref_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`tipo_ref_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_refaccion`
--

LOCK TABLES `tipo_refaccion` WRITE;
/*!40000 ALTER TABLE `tipo_refaccion` DISABLE KEYS */;
INSERT INTO `tipo_refaccion` VALUES (1,'Externo'),(2,'Interno');
/*!40000 ALTER TABLE `tipo_refaccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_equipos`
--

DROP TABLE IF EXISTS `tipos_equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_equipos` (
  `tipo_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`tipo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_equipos`
--

LOCK TABLES `tipos_equipos` WRITE;
/*!40000 ALTER TABLE `tipos_equipos` DISABLE KEYS */;
INSERT INTO `tipos_equipos` VALUES (1,'PC'),(2,'Laptop'),(3,'Impresora');
/*!40000 ALTER TABLE `tipos_equipos` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'21111','Jorge',1),(2,'23444','Pedro',1),(3,'23315','Eunice Platanares',1),(4,'23122','Ernesto la Guardia',1),(5,'24555','Eva María',1),(6,'12099','Eduardo Perez',1),(7,'00000','Mariana V.',1),(8,'19002','Gerardo V.',1),(9,'23706','Geovani Ramirez',1),(10,'23706','Geovani Peña',2),(11,'23707','Osvaldo Guerrero',3),(12,'23706','pablo',2),(13,'22706','Eduardo P.',3),(14,'23706','Geovani Ramirez',2),(15,'23707','Osvaldo Guerrero',3),(16,'23709','Eduardo Martinez',3),(17,'23709','Eduardo Martinez',3),(18,'23709','Eduardo Martinez',3),(19,'23710','Carlos Sanchez',4),(20,'23711','Soporte 01',2),(21,'23712','Angie Vasquez',4),(22,'23713','Soporte 02',3),(23,'23714','Soporte 03',2),(24,'23715','Soporte 04',1),(25,'23715','Soporte 04',1),(26,'23715','Soporte 04',1),(27,'23715','Soporte 04',1),(28,'23715','Soporte 04',1),(29,'23715','Soporte 04',1),(30,'23715','Soporte 05',1),(31,'23716','Soporte 06',4),(32,'23717','Geovani Ramirez',3),(33,'23718','Soporte 07',1),(34,'23718','Soporte 07',1),(35,'23718','Soporte 07',1),(36,'23717','Soporte 10',2),(37,'np','P1',2);
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

-- Dump completed on 2025-08-20 16:33:13
