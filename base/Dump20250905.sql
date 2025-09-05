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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` VALUES (20,'Dirección Ejecutiva de Administración y Finanzas'),(48,'Dirección Ejecutiva de Desarrollo Tecnológico'),(5,'Dirección Ejecutiva de Mantenimiento'),(35,'Dirección Ejecutiva de Transportación'),(1,'Dirección General'),(2,'Gerencia Asuntos Jurídicos'),(31,'Gerencia de Administración de Capital Humano'),(21,'Gerencia de Finanzas'),(53,'Gerencia de Ingeniería y Tecnología'),(11,'Gerencia de Mantenimiento a Instalaciones de Suministro y Distribución de Energía'),(14,'Gerencia de Mantenimiento de Tren Ligero'),(6,'Gerencia de Mantenimiento de Trolebuses'),(42,'Gerencia de Movilidad'),(28,'Gerencia de Recursos Materiales y Abastecimientos'),(25,'Gerencia de Servicios Generales'),(49,'Gerencia de Tecnologías de la Información y Comunicaciones'),(36,'Gerencia de Transportación de Tren Ligero'),(38,'Gerencia de Transportación de Trolebuses'),(46,'Jefe de Unidad Departamental de Auditoría Operativa, Administrativa y Control Interno'),(47,'Jefe de Unidad Departamental de Investigación'),(45,'Órgano Interno de Control'),(30,'Subgerencia de Almacenes e Inventarios'),(24,'Subgerencia de Caja General'),(29,'Subgerencia de Compras y Control de Materiales'),(4,'Subgerencia de Consultoría Legal'),(22,'Subgerencia de Contabilidad y Registro'),(33,'Subgerencia de Control de Personal, Reclutamiento y Capacitación'),(23,'Subgerencia de Control Presupuestal'),(19,'Subgerencia de Enlace y Seguimiento Interinstitucional'),(52,'Subgerencia de Gestión y Supervisión de Tecnologías de Peaje'),(50,'Subgerencia de Infraestructura Informática y de Comunicaciones'),(55,'Subgerencia de Ingeniería'),(44,'Subgerencia de Ingeniería de Transporte'),(54,'Subgerencia de Investigación y Modernización Tecnológica'),(34,'Subgerencia de la Unidad de Transparencia'),(3,'Subgerencia de lo Contencioso'),(27,'Subgerencia de Mantenimiento a Instalaciones e Inmuebles'),(12,'Subgerencia de Mantenimiento a Instalaciones Eléctricas'),(13,'Subgerencia de Mantenimiento a Subestaciones y Despacho de Carga'),(17,'Subgerencia de Mantenimiento a Vías de Tren Ligero'),(10,'Subgerencia de Mantenimiento Aragón'),(15,'Subgerencia de Mantenimiento Eléctrico y Electrónico de Tren Ligero'),(9,'Subgerencia de Mantenimiento Eléctrico y Electrónico de Trolebuses'),(16,'Subgerencia de Mantenimiento Mecánico'),(8,'Subgerencia de Mantenimiento Metropolitano de Trolebuses'),(7,'Subgerencia de Mantenimiento Tetepilco'),(18,'Subgerencia de Monitoreo de Infraestructura para el Transporte'),(32,'Subgerencia de Nómina'),(43,'Subgerencia de Regulación Operativa'),(26,'Subgerencia de Servicios'),(51,'Subgerencia de Sistemas de Información'),(40,'Subgerencia de Transportación Aragón'),(37,'Subgerencia de Transportación Huipulco'),(41,'Subgerencia de Transportación Metropolitana'),(39,'Subgerencia de Transportación Tetepilco');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_consumibles`
--

LOCK TABLES `catalogo_consumibles` WRITE;
/*!40000 ALTER TABLE `catalogo_consumibles` DISABLE KEYS */;
INSERT INTO `catalogo_consumibles` VALUES (1,'Mouse'),(2,'Teclado'),(3,'Conectores RJ45'),(4,'Conectores RJ11'),(5,'Conectores RJ9'),(6,'Jack RJ45'),(7,'Placa de pared RJ45'),(8,'Cable Displaypor'),(9,'Disco duro'),(10,'Unidad de estalo sólido');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas`
--

LOCK TABLES `marcas` WRITE;
/*!40000 ALTER TABLE `marcas` DISABLE KEYS */;
INSERT INTO `marcas` VALUES (1,'HP',1),(2,'DELL',1),(3,'HP',2),(4,'ACER',2),(5,'Lexmark',3),(6,'HP',3),(7,'Evolis',3),(8,'OKI',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modelos`
--

LOCK TABLES `modelos` WRITE;
/*!40000 ALTER TABLE `modelos` DISABLE KEYS */;
INSERT INTO `modelos` VALUES (1,'MS610dn',5),(2,'MS811dn',5),(3,'MX611dhe',5),(4,'C792de',5),(5,'Laserjet 600 M602',6),(6,'MX711dhe',5),(8,'MX611',5),(9,'MS711dn',5),(11,'MX811',5),(12,'Primacy',7),(13,'Compaq Pro 6305',1),(14,'EliteDesk 800',1),(15,'EliteDesk 705',1),(16,'OptiPlex 980',2),(17,'Latitude E5430',3),(18,'MPS5501B',8);
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
  `tipo_id` int DEFAULT NULL,
  PRIMARY KEY (`refaccion_id`),
  KEY `fk_refacciones_tipo` (`tipo_id`),
  CONSTRAINT `fk_refacciones_tipo` FOREIGN KEY (`tipo_id`) REFERENCES `tipos_equipos` (`tipo_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refacciones`
--

LOCK TABLES `refacciones` WRITE;
/*!40000 ALTER TABLE `refacciones` DISABLE KEYS */;
INSERT INTO `refacciones` VALUES (1,'Tarjeta madre',1),(2,'Procesador',1),(3,'Tarjeta de video',1),(4,'Disco duro',1),(5,'Memoria RAM',1),(6,'Fuente de poder',1),(7,'Ventilador',1),(8,'Adaptador de red',1),(9,'Batería CMOS',1),(10,'Memoria RAM',1),(11,'Unidad de estado sólido',1),(12,'Tarjeta madre',2),(13,'Procesador',2),(14,'Tarjeta de video',2),(15,'Disco duro',2),(16,'Memoria RAM',2),(17,'Fuente de poder',2),(18,'Ventilador',2),(19,'Adaptador de red',2),(20,'Batería CMOS',2),(21,'Memoria RAM',2),(22,'Unidad de estado sólido',2),(23,'Tarjeta lógica',3),(24,'Fusor de impresora',3),(25,'Cinta de impresión',3),(26,'Kit de mantenimiento',3),(27,'Cartucho de tóner',3),(28,'Rodillos',3),(29,'Bandeja de papel',3),(30,'Unidad de imágen',3),(31,'Sensor de hojas',3);
/*!40000 ALTER TABLE `refacciones` ENABLE KEYS */;
UNLOCK TABLES;

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
  CONSTRAINT `registro_consumible_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`),
  CONSTRAINT `registro_consumible_ibfk_3` FOREIGN KEY (`area_id`) REFERENCES `areas` (`area_id`) ON DELETE RESTRICT ON UPDATE CASCADE
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
  `hora` time DEFAULT NULL,
  `usuario_id` int NOT NULL,
  `modelo_id` int NOT NULL,
  `refaccion_inventario` varchar(50) DEFAULT NULL,
  `tipo_ref_id` int DEFAULT NULL,
  PRIMARY KEY (`reparacion_id`),
  KEY `refaccion_id` (`refaccion_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `fk_reparacion_modelo` (`modelo_id`),
  KEY `fk_reparacion_tipo_ref` (`tipo_ref_id`),
  CONSTRAINT `fk_reparacion_modelo` FOREIGN KEY (`modelo_id`) REFERENCES `modelos` (`modelo_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_reparacion_tipo_ref` FOREIGN KEY (`tipo_ref_id`) REFERENCES `tipo_refaccion` (`tipo_ref_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `reparacion_ibfk_1` FOREIGN KEY (`refaccion_id`) REFERENCES `refacciones` (`refaccion_id`),
  CONSTRAINT `reparacion_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reparacion`
--

LOCK TABLES `reparacion` WRITE;
/*!40000 ALTER TABLE `reparacion` DISABLE KEYS */;
INSERT INTO `reparacion` VALUES (1,'5151000060-0008',24,'Se rescató un fusor de la bodega y se fabricó la pieza correspondiente al sensor de bandera, debido a que la impresora no contaba con dicha pieza.','2023-02-10 00:00:00','12:01:41',1,3,'',1),(2,'5151000096-0105',24,'Se sustituye fusor por uno nuevo.','2023-02-03 00:00:00','12:07:17',2,2,'40X7743',1),(3,'5151000096-0079',31,'Se fabricó un sensor de salida utilizando material de papelería, con el fin de simular el paso de hojas en la impresora.','2023-02-10 00:00:00','12:09:55',3,1,'',1),(4,'0',25,'Se prueba y se cambia cinta de impresión con chip. (vacaciones)','2023-02-16 00:00:00','12:13:42',4,12,'',1),(5,'515100096-00102',24,'Se remplaza fusor y rodillo.','2023-02-23 00:00:00','12:16:17',5,2,'40X7743/40X7582',1),(6,'5151000060-0009',28,'Se remplazan rodillos.','2023-02-28 00:00:00','12:28:12',6,9,'40X8736/41X0917',1),(7,'5151000096-0095',27,'Se realizó el préstamo del tóner color amarillo de la impresora Lexmark, con número de inventario I180000162-0096, perteneciente al área de Transportación.','2023-04-04 00:00:00','12:35:58',9,4,'',1),(8,'5151000096-0100',24,'Se sustituyó el fusor original por el proveniente del área de Jurídico, al cual previamente se le reemplazó la tarjeta con la del equipo de Huipulco.','2023-04-05 00:00:00','12:39:03',10,2,'',1),(9,'5151000096-0105',28,'Se sustituyó el rodillo de goma de arrastre de hojas, debido a que la pieza original se encontraba rota.','2023-04-17 00:00:00','12:42:13',11,2,'40X7593',1),(10,'5151000096-0095',26,'Se hace cambio del Kit de Mantenimiento (fusor/unidad de imagen)','2023-04-17 00:00:00','12:44:20',12,4,'40X7103/NEC-3485 3173 (933-70150 8395)',1),(11,'180000162-0096',27,'Se remplaza el tóner color Cyan','2023-04-25 00:00:00','12:46:44',13,4,'24B4230-003-6018916/ C792X1CG',1),(12,'515100100-0019',26,'Se remplaza el kit de mantenimiento. (fusor, unidad de imágen)','2023-05-09 00:00:00','12:54:19',14,5,'CF064-67902',1),(13,'5151000096-0093',30,'Se remplaza la unidad de imagen. (Casa Blanca)','2023-05-12 00:00:00','13:05:29',15,18,'2204007363C2 KA',1),(14,'5151000096-0079',24,'Se remplaza fusor y rodillos. (Capital Humano)','2023-05-12 00:00:00','13:11:47',16,1,'40X8023',1),(15,'5151000096-0078',24,'Se remplaza fusor y rodillos.','2023-05-17 00:00:00','13:14:29',17,1,'40X8433',1),(16,'5151000096-0078',26,'Se realiza el cambio del kit de mantenimiento/parte trasera/rodillos bandeja.','2023-05-18 00:00:00','13:17:15',18,1,'40X8023/40X8437/41X0958',1),(17,'5151000060-0005',26,'Se sustituye el kit de mantenimiento ADF.','2023-09-12 00:00:00','13:27:07',19,6,'40X7749',1),(18,'5151000096-0077',26,'Se remplaza el kit de mantenimiento. (Laboratorio Electrónico)','2024-02-16 00:00:00','13:43:26',20,1,'40X8433',1),(19,'0',28,'Se remplaza el rodillo del escáner.','2023-08-21 00:00:00','13:49:00',21,9,'',1),(20,'5151000096-0077',26,'Se realiza cambio del kit de mantenimiento. (Laboratorio Electrónico)','2024-09-04 00:00:00','13:58:10',22,1,'40X8393/40X8444/41X0958/40x8023',1),(21,'5151000060-0009',24,'Se remplaza el fusor.','2024-10-10 00:00:00','14:01:30',23,3,'40X8023',1),(22,'5151000060-0005',26,'Se remplaza el kit de mantenimiento ADF','2024-10-17 00:00:00','14:03:44',24,6,'40X8431',1),(23,'5151000060-0005',26,'Se remplazo el kit de mantenimiento.','2024-10-17 00:00:00','14:17:37',25,6,'40X8420',1),(24,'5151000096-0079',24,'Se cambia el fusor, los rodillos de la charola y los rodillos de impresora.','2024-11-11 00:00:00','14:24:55',26,1,'40X8023',1);
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
INSERT INTO `tipo_refaccion` VALUES (1,'Interno'),(2,'Externo');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'','',33),(2,'','',2),(3,'','',33),(4,'','',33),(5,'','',14),(6,'','',29),(7,'','',50),(8,'','',50),(9,'','',50),(10,'','',26),(11,'','',2),(12,'','',50),(13,'','',38),(14,'','',45),(15,'','',33),(16,'','',33),(17,'','',45),(18,'','',45),(19,'','',23),(20,'','',9),(21,'','',43),(22,'','',9),(23,'','',10),(24,'','',23),(25,'','',23),(26,'','Jaime Hernandez Manzanero',31);
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

-- Dump completed on 2025-09-05 14:40:04
