/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.10-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: DreamsAndPrints
-- ------------------------------------------------------
-- Server version	10.11.10-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Item`
--

DROP TABLE IF EXISTS `Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Item` (
  `item_id` varchar(15) NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `item_prize` float NOT NULL,
  `item_description` varchar(100) DEFAULT NULL,
  `model_id` varchar(15) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `unq_item_name_user` (`item_name`,`user_id`),
  KEY `model_id` (`model_id`),
  KEY `user_id` (`user_id`),
  KEY `idx_item_name` (`item_name`),
  KEY `idx_item_price` (`item_prize`),
  CONSTRAINT `Item_ibfk_1` FOREIGN KEY (`model_id`) REFERENCES `Model` (`model_id`) ON DELETE CASCADE,
  CONSTRAINT `Item_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
  CONSTRAINT `chk_item_prize` CHECK (`item_prize` > 0),
  CONSTRAINT `chk_item_name` CHECK (octet_length(`item_name`) between 3 and 50),
  CONSTRAINT `chk_item_description` CHECK (octet_length(`item_description`) <= 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Item`
--

LOCK TABLES `Item` WRITE;
/*!40000 ALTER TABLE `Item` DISABLE KEYS */;
INSERT INTO `Item` VALUES
('ITM001','Goku SSJ Premium Figure',49.99,'High-quality Dragon Ball figure with premium finish','MDL001','USR001'),
('ITM002','Vegeta Battle Stance',45.99,'Detailed Vegeta figure in combat position','MDL002','USR002'),
('ITM003','Naruto Sage Mode Deluxe',55.99,'Collector edition Naruto figure','MDL003','USR003'),
('ITM004','Luffy Ultimate Form',59.99,'One Piece premium collection figure','MDL004','USR004'),
('ITM005','Ichigo Soul Reaper',52.99,'Limited edition Bleach figure','MDL005','USR005');
/*!40000 ALTER TABLE `Item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Model`
--

DROP TABLE IF EXISTS `Model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Model` (
  `model_id` varchar(15) NOT NULL,
  `model_size` float NOT NULL,
  `model_format` int(11) NOT NULL,
  `model_name` varchar(50) NOT NULL,
  PRIMARY KEY (`model_id`),
  KEY `idx_model_name` (`model_name`),
  KEY `idx_model_format` (`model_format`),
  CONSTRAINT `Model_ibfk_1` FOREIGN KEY (`model_format`) REFERENCES `model_formats` (`format_id`),
  CONSTRAINT `chk_model_name` CHECK (octet_length(`model_name`) between 3 and 50),
  CONSTRAINT `chk_model_format` CHECK (`model_format` in (1,2,3,4,5)),
  CONSTRAINT `chk_model_size` CHECK (`model_size` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Model`
--

LOCK TABLES `Model` WRITE;
/*!40000 ALTER TABLE `Model` DISABLE KEYS */;
INSERT INTO `Model` VALUES
('MDL001',15.5,1,'Goku Super Saiyan'),
('MDL002',12.8,1,'Vegeta Final Flash'),
('MDL003',18.2,2,'Naruto Modo Sabio'),
('MDL004',20,2,'Luffy Gear 5'),
('MDL005',16.7,1,'Ichigo Bankai Form');
/*!40000 ALTER TABLE `Model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Model_Detail`
--

DROP TABLE IF EXISTS `Model_Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Model_Detail` (
  `model_detail_id` varchar(15) NOT NULL,
  `model_id` varchar(15) NOT NULL,
  `model_detail_color` int(11) NOT NULL DEFAULT 0,
  `model_detail_filament` int(11) DEFAULT 0,
  `model_detail_type_3dprint` int(11) DEFAULT 0,
  `model_detail_fill` int(11) DEFAULT 0,
  `model_detail_pattern` int(11) DEFAULT 0,
  `model_detail_finishing` int(11) DEFAULT 0,
  `model_detail_scale` float DEFAULT 1,
  PRIMARY KEY (`model_detail_id`),
  KEY `model_id` (`model_id`),
  KEY `model_detail_color` (`model_detail_color`),
  KEY `model_detail_filament` (`model_detail_filament`),
  KEY `model_detail_type_3dprint` (`model_detail_type_3dprint`),
  KEY `model_detail_finishing` (`model_detail_finishing`),
  KEY `model_detail_fill` (`model_detail_fill`),
  KEY `model_detail_pattern` (`model_detail_pattern`),
  CONSTRAINT `Model_Detail_ibfk_1` FOREIGN KEY (`model_id`) REFERENCES `Model` (`model_id`) ON DELETE CASCADE,
  CONSTRAINT `Model_Detail_ibfk_2` FOREIGN KEY (`model_detail_color`) REFERENCES `print_colors` (`color_id`),
  CONSTRAINT `Model_Detail_ibfk_3` FOREIGN KEY (`model_detail_filament`) REFERENCES `filament_types` (`type_id`),
  CONSTRAINT `Model_Detail_ibfk_4` FOREIGN KEY (`model_detail_type_3dprint`) REFERENCES `print_types` (`type_id`),
  CONSTRAINT `Model_Detail_ibfk_5` FOREIGN KEY (`model_detail_finishing`) REFERENCES `finishing_types` (`type_id`),
  CONSTRAINT `Model_Detail_ibfk_6` FOREIGN KEY (`model_detail_fill`) REFERENCES `fill_types` (`type_id`),
  CONSTRAINT `Model_Detail_ibfk_7` FOREIGN KEY (`model_detail_pattern`) REFERENCES `fill_patterns` (`pattern_id`),
  CONSTRAINT `chk_scale_max` CHECK (`model_detail_scale` <= 25.0),
  CONSTRAINT `chk_model_detail_scale` CHECK (`model_detail_scale` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Model_Detail`
--

LOCK TABLES `Model_Detail` WRITE;
/*!40000 ALTER TABLE `Model_Detail` DISABLE KEYS */;
INSERT INTO `Model_Detail` VALUES
('MD001','MDL001',1,0,1,3,2,2,1.5),
('MD002','MDL002',2,0,2,4,3,2,2),
('MD003','MDL003',3,1,1,3,4,3,1.8),
('MD004','MDL004',4,2,2,5,5,4,2.5),
('MD005','MDL005',5,0,1,4,6,2,1.2);
/*!40000 ALTER TABLE `Model_Detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order`
--

DROP TABLE IF EXISTS `Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Order` (
  `order_id` varchar(100) NOT NULL,
  `order_date` date NOT NULL,
  `order_state` int(11) NOT NULL DEFAULT 0,
  `order_total` float NOT NULL,
  `order_address` varchar(100) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `idx_order_date` (`order_date`),
  KEY `idx_order_state` (`order_state`),
  CONSTRAINT `Order_ibfk_1` FOREIGN KEY (`order_state`) REFERENCES `order_states` (`state_id`),
  CONSTRAINT `chk_order_total` CHECK (`order_total` >= 0),
  CONSTRAINT `chk_order_address` CHECK (octet_length(`order_address`) between 5 and 100),
  CONSTRAINT `chk_order_state` CHECK (`order_state` between 0 and 5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order`
--

LOCK TABLES `Order` WRITE;
/*!40000 ALTER TABLE `Order` DISABLE KEYS */;
INSERT INTO `Order` VALUES
('ORD001','2024-11-28',2,49.99,'Calle Principal 123, Ciudad México, CP 12345'),
('ORD002','2024-11-28',2,45.99,'Avenida Central 456, Guadalajara, CP 23456'),
('ORD003','2024-11-28',1,55.99,'Boulevard Norte 789, Monterrey, CP 34567'),
('ORD004','2024-11-28',3,59.99,'Calle Sur 101, Puebla, CP 45678'),
('ORD005','2024-11-28',2,52.99,'Avenida Este 202, Querétaro, CP 56789');
/*!40000 ALTER TABLE `Order` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER set_order_date 
BEFORE INSERT ON `Order`
FOR EACH ROW
BEGIN
    SET NEW.order_date = CURRENT_DATE();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Order_Detail`
--

DROP TABLE IF EXISTS `Order_Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Order_Detail` (
  `order_detail_id` varchar(100) NOT NULL,
  `order_id` varchar(100) NOT NULL,
  `item_id` varchar(15) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `model_detail_id` varchar(15) NOT NULL,
  `payment_id` varchar(50) NOT NULL,
  `order_detail_unitary_cost` float NOT NULL,
  `order_detail_n_items` int(11) NOT NULL,
  `order_detail_subtotal` double NOT NULL,
  PRIMARY KEY (`order_detail_id`),
  KEY `order_id` (`order_id`),
  KEY `item_id` (`item_id`),
  KEY `model_detail_id` (`model_detail_id`),
  KEY `payment_id` (`payment_id`),
  KEY `idx_order_user` (`user_id`),
  CONSTRAINT `Order_Detail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Order` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `Order_Detail_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `Item` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `Order_Detail_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
  CONSTRAINT `Order_Detail_ibfk_4` FOREIGN KEY (`model_detail_id`) REFERENCES `Model_Detail` (`model_detail_id`) ON DELETE CASCADE,
  CONSTRAINT `Order_Detail_ibfk_5` FOREIGN KEY (`payment_id`) REFERENCES `Payment` (`payment_id`),
  CONSTRAINT `chk_order_items` CHECK (`order_detail_n_items` > 0),
  CONSTRAINT `chk_order_subtotal` CHECK (`order_detail_subtotal` > 0),
  CONSTRAINT `chk_detail_unitary_cost` CHECK (`order_detail_unitary_cost` > 0),
  CONSTRAINT `chk_detail_items` CHECK (`order_detail_n_items` between 1 and 10),
  CONSTRAINT `chk_detail_subtotal` CHECK (`order_detail_subtotal` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_Detail`
--

LOCK TABLES `Order_Detail` WRITE;
/*!40000 ALTER TABLE `Order_Detail` DISABLE KEYS */;
INSERT INTO `Order_Detail` VALUES
('OD001','ORD001','ITM001','USR001','MD001','PAY001',49.99,1,49.99),
('OD002','ORD002','ITM002','USR002','MD002','PAY002',45.99,1,45.99),
('OD003','ORD003','ITM003','USR003','MD003','PAY003',55.99,1,55.99),
('OD004','ORD004','ITM004','USR004','MD004','PAY004',59.99,1,59.99),
('OD005','ORD005','ITM005','USR005','MD005','PAY005',52.99,1,52.99);
/*!40000 ALTER TABLE `Order_Detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Payment` (
  `payment_id` varchar(50) NOT NULL,
  `payment_date` date NOT NULL,
  `payment_method` int(11) NOT NULL,
  `payment_mount` double NOT NULL,
  `payment_state` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`payment_id`),
  KEY `idx_payment_date` (`payment_date`),
  KEY `idx_payment_status` (`payment_state`),
  KEY `idx_payment_method` (`payment_method`),
  CONSTRAINT `Payment_ibfk_1` FOREIGN KEY (`payment_method`) REFERENCES `payment_methods` (`method_id`),
  CONSTRAINT `Payment_ibfk_2` FOREIGN KEY (`payment_state`) REFERENCES `payment_states` (`state_id`),
  CONSTRAINT `chk_payment_mount` CHECK (`payment_mount` > 0),
  CONSTRAINT `chk_payment_state` CHECK (`payment_state` between 0 and 3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payment`
--

LOCK TABLES `Payment` WRITE;
/*!40000 ALTER TABLE `Payment` DISABLE KEYS */;
INSERT INTO `Payment` VALUES
('PAY001','2024-11-28',1,49.99,2),
('PAY002','2024-11-28',2,45.99,2),
('PAY003','2024-11-28',3,55.99,2),
('PAY004','2024-11-28',1,59.99,2),
('PAY005','2024-11-28',2,52.99,2);
/*!40000 ALTER TABLE `Payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER set_payment_date 
BEFORE INSERT ON Payment
FOR EACH ROW
BEGIN
    SET NEW.payment_date = CURRENT_DATE();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Review`
--

DROP TABLE IF EXISTS `Review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Review` (
  `review_id` varchar(50) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `item_id` varchar(15) NOT NULL,
  `order_detail_id` varchar(100) NOT NULL,
  `review_rate` int(11) NOT NULL,
  `review_comment` varchar(100) DEFAULT NULL,
  `review_date` date NOT NULL,
  PRIMARY KEY (`review_id`),
  UNIQUE KEY `unq_order_detail_review` (`order_detail_id`),
  KEY `user_id` (`user_id`),
  KEY `item_id` (`item_id`),
  KEY `idx_review_rate` (`review_rate`),
  KEY `idx_review_date` (`review_date`),
  CONSTRAINT `Review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
  CONSTRAINT `Review_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `Item` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `Review_ibfk_3` FOREIGN KEY (`order_detail_id`) REFERENCES `Order_Detail` (`order_detail_id`),
  CONSTRAINT `chk_review_rate` CHECK (`review_rate` between 1 and 5),
  CONSTRAINT `chk_review_length` CHECK (octet_length(`review_comment`) between 3 and 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Review`
--

LOCK TABLES `Review` WRITE;
/*!40000 ALTER TABLE `Review` DISABLE KEYS */;
INSERT INTO `Review` VALUES
('REV001','USR001','ITM001','OD001',5,'Excelente calidad y acabados perfectos','2024-11-28'),
('REV002','USR002','ITM002','OD002',4,'Muy buen producto, los detalles son increíbles','2024-11-28'),
('REV003','USR003','ITM003','OD003',5,'Supera las expectativas, envío rápido','2024-11-28'),
('REV004','USR004','ITM004','OD004',5,'Figura perfecta, material de primera','2024-11-28'),
('REV005','USR005','ITM005','OD005',4,'Gran calidad de impresión, muy satisfecho','2024-11-28');
/*!40000 ALTER TABLE `Review` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER set_review_date 
BEFORE INSERT ON Review
FOR EACH ROW
BEGIN
    SET NEW.review_date = CURRENT_DATE();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Shipment`
--

DROP TABLE IF EXISTS `Shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Shipment` (
  `shipment_id` varchar(50) NOT NULL,
  `order_detail_id` varchar(100) NOT NULL,
  `shipment_method` int(11) NOT NULL DEFAULT 0,
  `shipment_date` date DEFAULT NULL,
  `shipment_date_estimated` date DEFAULT NULL,
  `shipment_state` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`shipment_id`),
  KEY `order_detail_id` (`order_detail_id`),
  KEY `shipment_method` (`shipment_method`),
  KEY `idx_shipment_state` (`shipment_state`),
  KEY `idx_shipment_dates` (`shipment_date`,`shipment_date_estimated`),
  CONSTRAINT `Shipment_ibfk_1` FOREIGN KEY (`order_detail_id`) REFERENCES `Order_Detail` (`order_detail_id`) ON DELETE CASCADE,
  CONSTRAINT `Shipment_ibfk_2` FOREIGN KEY (`shipment_method`) REFERENCES `shipping_methods` (`method_id`),
  CONSTRAINT `Shipment_ibfk_3` FOREIGN KEY (`shipment_state`) REFERENCES `shipment_states` (`state_id`),
  CONSTRAINT `chk_shipment_state` CHECK (`shipment_state` between 0 and 4)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Shipment`
--

LOCK TABLES `Shipment` WRITE;
/*!40000 ALTER TABLE `Shipment` DISABLE KEYS */;
INSERT INTO `Shipment` VALUES
('SHP001','OD001',1,'2024-11-28','2024-01-15',2),
('SHP002','OD002',2,'2024-11-28','2024-12-01',2),
('SHP003','OD003',1,'2024-11-28','2024-12-03',1),
('SHP004','OD004',3,'2024-11-28','2024-11-30',2),
('SHP005','OD005',2,'2024-11-28','2024-12-01',1);
/*!40000 ALTER TABLE `Shipment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER set_shipment_date 
BEFORE INSERT ON Shipment
FOR EACH ROW
BEGIN
    SET NEW.shipment_date = CURRENT_DATE();
    -- Fecha estimada: 3 días después
    SET NEW.shipment_date_estimated = DATE_ADD(CURRENT_DATE(), INTERVAL 3 DAY);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `user_id` varchar(10) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_pwd` varchar(64) NOT NULL,
  `user_address` varchar(100) DEFAULT NULL,
  `user_phone` varchar(20) DEFAULT NULL,
  `user_type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `unq_user_email` (`user_email`),
  KEY `idx_user_email` (`user_email`),
  KEY `idx_user_name` (`user_name`),
  KEY `idx_user_type` (`user_type`),
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`user_type`) REFERENCES `user_types` (`type_id`),
  CONSTRAINT `chk_user_email` CHECK (`user_email` regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$'),
  CONSTRAINT `chk_user_name` CHECK (octet_length(`user_name`) between 3 and 50),
  CONSTRAINT `chk_user_pwd` CHECK (octet_length(`user_pwd`) >= 8),
  CONSTRAINT `chk_user_phone` CHECK (`user_phone` regexp '^[+0-9-s().]{8,20}$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES
('USR001','Juan Pérez González','juan.perez@email.com','6faba6e4ed724c5b54fad19eca98923e2198cdbba78db5e74672c83217fb33a6','Calle Principal 123, Ciudad','+52-555-123-4567',0),
('USR002','María Rodríguez López','maria.rdz@email.com','9f540732a390bb8abf1e255d688d26de256676f95c5ab563f73f649c02a6b82d','Av. Central 456, Ciudad','+52-555-234-5678',0),
('USR003','Carlos Sánchez Martínez','carlos.san@email.com','33bab1f120930ed535552537cfcfd4efa5c77be191ce34bc4b887c7a3a488649','Plaza Mayor 789, Ciudad','+52-555-345-6789',0),
('USR004','Ana López Torres','ana.lopez@email.com','dc35bc0ea3373ba02f79b3a71b1a9d606ceb96f39206f729c3663fecc8ce2c73','Calle Norte 101, Ciudad','+52-555-456-7890',0),
('USR005','Roberto Martínez Silva','roberto.mtz@email.com','93ee18caf2d3ce05ca0b8de6d2e8accdf1a8d8dec8ae0781a318cb2816d05ea1','Av. Sur 202, Ciudad','+52-555-567-8901',0),
('USR006','El Fisher','fisher_k2@hotmail.com','e462ee392180b56f80ead6523b0b1c43ecdd05e96e3110a2542cce244ec566a2','Blvd. Hilario Medina 3105','+52-551-1865380',1);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filament_types`
--

DROP TABLE IF EXISTS `filament_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filament_types` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filament_types`
--

LOCK TABLES `filament_types` WRITE;
/*!40000 ALTER TABLE `filament_types` DISABLE KEYS */;
INSERT INTO `filament_types` VALUES
(0,'PLA'),
(1,'ABS'),
(2,'PETG'),
(3,'TPU'),
(4,'Nylon');
/*!40000 ALTER TABLE `filament_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fill_patterns`
--

DROP TABLE IF EXISTS `fill_patterns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fill_patterns` (
  `pattern_id` int(11) NOT NULL,
  `pattern_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`pattern_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fill_patterns`
--

LOCK TABLES `fill_patterns` WRITE;
/*!40000 ALTER TABLE `fill_patterns` DISABLE KEYS */;
INSERT INTO `fill_patterns` VALUES
(0,'Rectilíneo'),
(1,'Grid'),
(2,'Triangular'),
(3,'Hexagonal'),
(4,'Cúbico'),
(5,'Gyroid'),
(6,'Honeycomb'),
(7,'Concéntrico');
/*!40000 ALTER TABLE `fill_patterns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fill_types`
--

DROP TABLE IF EXISTS `fill_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fill_types` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fill_types`
--

LOCK TABLES `fill_types` WRITE;
/*!40000 ALTER TABLE `fill_types` DISABLE KEYS */;
INSERT INTO `fill_types` VALUES
(0,'Hueco'),
(1,'10%'),
(2,'25%'),
(3,'50%'),
(4,'75%'),
(5,'100%');
/*!40000 ALTER TABLE `fill_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `finishing_types`
--

DROP TABLE IF EXISTS `finishing_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `finishing_types` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `finishing_types`
--

LOCK TABLES `finishing_types` WRITE;
/*!40000 ALTER TABLE `finishing_types` DISABLE KEYS */;
INSERT INTO `finishing_types` VALUES
(0,'Estándar'),
(1,'Lijado'),
(2,'Pintado'),
(3,'Barnizado'),
(4,'Premium');
/*!40000 ALTER TABLE `finishing_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_formats`
--

DROP TABLE IF EXISTS `model_formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_formats` (
  `format_id` int(11) NOT NULL,
  `format_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`format_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_formats`
--

LOCK TABLES `model_formats` WRITE;
/*!40000 ALTER TABLE `model_formats` DISABLE KEYS */;
INSERT INTO `model_formats` VALUES
(1,'STL'),
(2,'OBJ'),
(3,'FBX'),
(4,'3DS'),
(5,'GCODE');
/*!40000 ALTER TABLE `model_formats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_states`
--

DROP TABLE IF EXISTS `order_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_states` (
  `state_id` int(11) NOT NULL,
  `state_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_states`
--

LOCK TABLES `order_states` WRITE;
/*!40000 ALTER TABLE `order_states` DISABLE KEYS */;
INSERT INTO `order_states` VALUES
(0,'Pendiente'),
(1,'Confirmado'),
(2,'En proceso'),
(3,'Enviado'),
(4,'Entregado'),
(5,'Cancelado');
/*!40000 ALTER TABLE `order_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_methods` (
  `method_id` int(11) NOT NULL,
  `method_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_methods`
--

LOCK TABLES `payment_methods` WRITE;
/*!40000 ALTER TABLE `payment_methods` DISABLE KEYS */;
INSERT INTO `payment_methods` VALUES
(1,'Tarjeta de Crédito'),
(2,'Tarjeta de Débito'),
(3,'PayPal'),
(4,'Transferencia Bancaria');
/*!40000 ALTER TABLE `payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_states`
--

DROP TABLE IF EXISTS `payment_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_states` (
  `state_id` int(11) NOT NULL,
  `state_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_states`
--

LOCK TABLES `payment_states` WRITE;
/*!40000 ALTER TABLE `payment_states` DISABLE KEYS */;
INSERT INTO `payment_states` VALUES
(0,'Pendiente'),
(1,'Procesando'),
(2,'Completado'),
(3,'Rechazado');
/*!40000 ALTER TABLE `payment_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `print_colors`
--

DROP TABLE IF EXISTS `print_colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `print_colors` (
  `color_id` int(11) NOT NULL,
  `color_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`color_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `print_colors`
--

LOCK TABLES `print_colors` WRITE;
/*!40000 ALTER TABLE `print_colors` DISABLE KEYS */;
INSERT INTO `print_colors` VALUES
(0,'Custom'),
(1,'Blanco'),
(2,'Negro'),
(3,'Rojo'),
(4,'Azul'),
(5,'Verde'),
(6,'Amarillo'),
(7,'Gris');
/*!40000 ALTER TABLE `print_colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `print_types`
--

DROP TABLE IF EXISTS `print_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `print_types` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `print_types`
--

LOCK TABLES `print_types` WRITE;
/*!40000 ALTER TABLE `print_types` DISABLE KEYS */;
INSERT INTO `print_types` VALUES
(0,'Normal'),
(1,'Alta Calidad'),
(2,'Ultra Detalle'),
(3,'Rápido');
/*!40000 ALTER TABLE `print_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipment_states`
--

DROP TABLE IF EXISTS `shipment_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipment_states` (
  `state_id` int(11) NOT NULL,
  `state_name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment_states`
--

LOCK TABLES `shipment_states` WRITE;
/*!40000 ALTER TABLE `shipment_states` DISABLE KEYS */;
INSERT INTO `shipment_states` VALUES
(0,'Preparando'),
(1,'En Tránsito'),
(2,'En Reparto'),
(3,'Entregado'),
(4,'Retrasado');
/*!40000 ALTER TABLE `shipment_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_methods`
--

DROP TABLE IF EXISTS `shipping_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipping_methods` (
  `method_id` int(11) NOT NULL,
  `method_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_methods`
--

LOCK TABLES `shipping_methods` WRITE;
/*!40000 ALTER TABLE `shipping_methods` DISABLE KEYS */;
INSERT INTO `shipping_methods` VALUES
(1,'Estándar'),
(2,'Express'),
(3,'Premium');
/*!40000 ALTER TABLE `shipping_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_types`
--

DROP TABLE IF EXISTS `user_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_types` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_types`
--

LOCK TABLES `user_types` WRITE;
/*!40000 ALTER TABLE `user_types` DISABLE KEYS */;
INSERT INTO `user_types` VALUES
(0,'Cliente'),
(1,'Administrador');
/*!40000 ALTER TABLE `user_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v_active_orders`
--

DROP TABLE IF EXISTS `v_active_orders`;
/*!50001 DROP VIEW IF EXISTS `v_active_orders`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_active_orders` AS SELECT
 1 AS `order_id`,
  1 AS `user_name`,
  1 AS `item_name`,
  1 AS `order_detail_n_items`,
  1 AS `order_total`,
  1 AS `order_status` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_api_customer_orders`
--

DROP TABLE IF EXISTS `v_api_customer_orders`;
/*!50001 DROP VIEW IF EXISTS `v_api_customer_orders`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_api_customer_orders` AS SELECT
 1 AS `user_id`,
  1 AS `order_id`,
  1 AS `order_date`,
  1 AS `item_name`,
  1 AS `order_detail_n_items`,
  1 AS `order_detail_subtotal`,
  1 AS `order_status`,
  1 AS `shipping_status`,
  1 AS `payment_status` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_api_product_details`
--

DROP TABLE IF EXISTS `v_api_product_details`;
/*!50001 DROP VIEW IF EXISTS `v_api_product_details`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_api_product_details` AS SELECT
 1 AS `item_id`,
  1 AS `item_name`,
  1 AS `item_description`,
  1 AS `item_prize`,
  1 AS `model_name`,
  1 AS `model_format`,
  1 AS `model_detail_scale`,
  1 AS `filament_type`,
  1 AS `print_type`,
  1 AS `finishing_type`,
  1 AS `color` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_api_products`
--

DROP TABLE IF EXISTS `v_api_products`;
/*!50001 DROP VIEW IF EXISTS `v_api_products`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_api_products` AS SELECT
 1 AS `item_id`,
  1 AS `item_name`,
  1 AS `item_description`,
  1 AS `item_prize`,
  1 AS `model_name`,
  1 AS `model_format`,
  1 AS `rating`,
  1 AS `review_count` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_api_reviews`
--

DROP TABLE IF EXISTS `v_api_reviews`;
/*!50001 DROP VIEW IF EXISTS `v_api_reviews`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_api_reviews` AS SELECT
 1 AS `item_id`,
  1 AS `item_name`,
  1 AS `review_rate`,
  1 AS `review_comment`,
  1 AS `review_date`,
  1 AS `user_name` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_api_user_info`
--

DROP TABLE IF EXISTS `v_api_user_info`;
/*!50001 DROP VIEW IF EXISTS `v_api_user_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_api_user_info` AS SELECT
 1 AS `user_id`,
  1 AS `user_name`,
  1 AS `user_email`,
  1 AS `user_address`,
  1 AS `total_orders`,
  1 AS `total_reviews`,
  1 AS `last_order_date`,
  1 AS `total_spent` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_customer_satisfaction`
--

DROP TABLE IF EXISTS `v_customer_satisfaction`;
/*!50001 DROP VIEW IF EXISTS `v_customer_satisfaction`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_customer_satisfaction` AS SELECT
 1 AS `item_name`,
  1 AS `total_reviews`,
  1 AS `average_rating`,
  1 AS `positive_reviews` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_database_status`
--

DROP TABLE IF EXISTS `v_database_status`;
/*!50001 DROP VIEW IF EXISTS `v_database_status`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_database_status` AS SELECT
 1 AS `table_name`,
  1 AS `table_rows`,
  1 AS `data_length`,
  1 AS `index_length` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_delivered_shipments`
--

DROP TABLE IF EXISTS `v_delivered_shipments`;
/*!50001 DROP VIEW IF EXISTS `v_delivered_shipments`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_delivered_shipments` AS SELECT
 1 AS `shipment_id`,
  1 AS `order_id`,
  1 AS `user_name`,
  1 AS `user_address`,
  1 AS `item_name`,
  1 AS `order_detail_n_items`,
  1 AS `shipment_date`,
  1 AS `shipment_date_estimated`,
  1 AS `delivery_difference` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_inventory_status`
--

DROP TABLE IF EXISTS `v_inventory_status`;
/*!50001 DROP VIEW IF EXISTS `v_inventory_status`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_inventory_status` AS SELECT
 1 AS `item_name`,
  1 AS `times_ordered`,
  1 AS `average_rating`,
  1 AS `item_prize` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_payment_tracking`
--

DROP TABLE IF EXISTS `v_payment_tracking`;
/*!50001 DROP VIEW IF EXISTS `v_payment_tracking`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_payment_tracking` AS SELECT
 1 AS `payment_id`,
  1 AS `order_id`,
  1 AS `payment_mount`,
  1 AS `method_name`,
  1 AS `state_name`,
  1 AS `payment_date` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_pending_shipments`
--

DROP TABLE IF EXISTS `v_pending_shipments`;
/*!50001 DROP VIEW IF EXISTS `v_pending_shipments`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_pending_shipments` AS SELECT
 1 AS `shipment_id`,
  1 AS `user_name`,
  1 AS `user_address`,
  1 AS `user_phone`,
  1 AS `item_name`,
  1 AS `order_detail_n_items`,
  1 AS `shipment_date_estimated`,
  1 AS `shipment_status` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_popular_models`
--

DROP TABLE IF EXISTS `v_popular_models`;
/*!50001 DROP VIEW IF EXISTS `v_popular_models`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_popular_models` AS SELECT
 1 AS `model_name`,
  1 AS `model_format`,
  1 AS `times_used`,
  1 AS `times_ordered` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_product_performance`
--

DROP TABLE IF EXISTS `v_product_performance`;
/*!50001 DROP VIEW IF EXISTS `v_product_performance`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_product_performance` AS SELECT
 1 AS `item_name`,
  1 AS `times_ordered`,
  1 AS `units_sold`,
  1 AS `average_rating`,
  1 AS `review_count` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_sales_analytics`
--

DROP TABLE IF EXISTS `v_sales_analytics`;
/*!50001 DROP VIEW IF EXISTS `v_sales_analytics`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_sales_analytics` AS SELECT
 1 AS `month`,
  1 AS `total_orders`,
  1 AS `unique_customers`,
  1 AS `total_revenue`,
  1 AS `average_order_value` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_sales_orders`
--

DROP TABLE IF EXISTS `v_sales_orders`;
/*!50001 DROP VIEW IF EXISTS `v_sales_orders`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_sales_orders` AS SELECT
 1 AS `order_id`,
  1 AS `user_name`,
  1 AS `user_email`,
  1 AS `item_name`,
  1 AS `order_detail_n_items`,
  1 AS `order_detail_subtotal`,
  1 AS `payment_state`,
  1 AS `order_date` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_sales_summary`
--

DROP TABLE IF EXISTS `v_sales_summary`;
/*!50001 DROP VIEW IF EXISTS `v_sales_summary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_sales_summary` AS SELECT
 1 AS `sale_date`,
  1 AS `total_orders`,
  1 AS `daily_revenue`,
  1 AS `average_order` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_shipping_status`
--

DROP TABLE IF EXISTS `v_shipping_status`;
/*!50001 DROP VIEW IF EXISTS `v_shipping_status`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_shipping_status` AS SELECT
 1 AS `shipment_id`,
  1 AS `order_id`,
  1 AS `user_name`,
  1 AS `user_address`,
  1 AS `user_phone`,
  1 AS `item_name`,
  1 AS `order_detail_n_items`,
  1 AS `shipment_date`,
  1 AS `shipment_date_estimated`,
  1 AS `shipment_status` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_table_relationships`
--

DROP TABLE IF EXISTS `v_table_relationships`;
/*!50001 DROP VIEW IF EXISTS `v_table_relationships`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_table_relationships` AS SELECT
 1 AS `TABLE_NAME`,
  1 AS `COLUMN_NAME`,
  1 AS `REFERENCED_TABLE_NAME`,
  1 AS `REFERENCED_COLUMN_NAME` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_user_activity`
--

DROP TABLE IF EXISTS `v_user_activity`;
/*!50001 DROP VIEW IF EXISTS `v_user_activity`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_user_activity` AS SELECT
 1 AS `user_name`,
  1 AS `total_orders`,
  1 AS `total_reviews`,
  1 AS `last_activity` */;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'DreamsAndPrints'
--

--
-- Dumping routines for database 'DreamsAndPrints'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_calculate_order_total` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_calculate_order_total`(IN p_order_id VARCHAR(100))
BEGIN
    UPDATE `Order` o
    SET order_total = (
        SELECT SUM(order_detail_subtotal)
        FROM Order_Detail
        WHERE order_id = p_order_id
    )
    WHERE o.order_id = p_order_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_check_payment_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_check_payment_status`(IN p_order_id VARCHAR(100))
BEGIN
    SELECT * FROM v_payment_tracking
    WHERE order_id = p_order_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_review`(
    IN p_user_id VARCHAR(10),
    IN p_item_id VARCHAR(15),
    IN p_order_detail_id VARCHAR(100),
    IN p_rate INT,
    IN p_comment VARCHAR(100)
)
BEGIN
    INSERT INTO Review (user_id, item_id, order_detail_id, review_rate, review_comment, review_date)
    VALUES (p_user_id, p_item_id, p_order_detail_id, p_rate, p_comment, CURRENT_DATE());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_user`(
    IN p_user_id VARCHAR(10),
    IN p_user_name VARCHAR(50),
    IN p_user_email VARCHAR(50),
    IN p_user_pwd VARCHAR(50),
    IN p_user_address VARCHAR(100),
    IN p_user_phone VARCHAR(15),
    IN p_user_type INT
)
BEGIN
    INSERT INTO User (user_id, user_name, user_email, user_pwd, user_address, user_phone, user_type)
    VALUES (p_user_id, p_user_name, p_user_email, SHA2(p_user_pwd, 256), p_user_address, p_user_phone, p_user_type);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_customer_satisfaction_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_customer_satisfaction_report`()
BEGIN
    SELECT * FROM v_customer_satisfaction
    ORDER BY average_rating DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_delivered_period` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_delivered_period`(
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT * FROM v_delivered_shipments
    WHERE shipment_date BETWEEN p_start_date AND p_end_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_item_reviews` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_item_reviews`(IN p_item_id VARCHAR(15))
BEGIN
    SELECT * FROM v_api_reviews
    WHERE item_id = p_item_id
    ORDER BY review_date DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_order_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_order_details`(IN p_order_id VARCHAR(100))
BEGIN
    SELECT * FROM v_sales_orders 
    WHERE order_id = p_order_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_pending_by_address` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_pending_by_address`(IN p_address VARCHAR(100))
BEGIN
    SELECT * FROM v_pending_shipments
    WHERE user_address LIKE CONCAT('%', p_address, '%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_popular_products` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_popular_products`(IN p_limit INT)
BEGIN
    SELECT * FROM v_api_products
    ORDER BY rating DESC, review_count DESC
    LIMIT p_limit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_product_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_product_details`(IN p_item_id VARCHAR(15))
BEGIN
    SELECT * FROM v_api_product_details
    WHERE item_id = p_item_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_sales_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_sales_report`(
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT * FROM v_sales_analytics
    WHERE month BETWEEN p_start_date AND p_end_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_user_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_user_orders`(IN p_user_id VARCHAR(10))
BEGIN
    SELECT * FROM v_api_customer_orders
    WHERE user_id = p_user_id
    ORDER BY order_date DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_user_profile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_user_profile`(IN p_user_id VARCHAR(10))
BEGIN
    SELECT * FROM v_api_user_info
    WHERE user_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_payment_methods_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_payment_methods_report`(
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT 
        method_name,
        COUNT(*) as times_used,
        SUM(payment_mount) as total_amount
    FROM v_payment_tracking
    WHERE payment_date BETWEEN p_start_date AND p_end_date
    GROUP BY method_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_popular_models_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_popular_models_report`(
    IN p_min_uses INT
)
BEGIN
    SELECT * FROM v_popular_models
    WHERE times_used >= p_min_uses
    ORDER BY times_ordered DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_product_performance_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_product_performance_report`(
    IN p_min_orders INT
)
BEGIN
    SELECT * FROM v_product_performance
    WHERE times_ordered >= p_min_orders
    ORDER BY units_sold DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_sales_period_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_sales_period_report`(
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT * FROM v_sales_summary
    WHERE sale_date BETWEEN p_start_date AND p_end_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_search_customer_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_customer_orders`(IN p_user_email VARCHAR(50))
BEGIN
    SELECT * FROM v_sales_orders 
    WHERE user_email LIKE CONCAT('%', p_user_email, '%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_search_items` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_items`(IN p_search_term VARCHAR(50))
BEGIN
    SELECT * FROM v_api_products
    WHERE item_name LIKE CONCAT('%', p_search_term, '%')
    OR item_description LIKE CONCAT('%', p_search_term, '%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_shipping_metrics` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_shipping_metrics`(
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT 
        shipment_status,
        COUNT(*) as total_shipments,
        AVG(DATEDIFF(shipment_date, shipment_date_estimated)) as avg_delivery_time
    FROM v_shipping_status
    WHERE shipment_date BETWEEN p_start_date AND p_end_date
    GROUP BY shipment_status;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_shipping_status_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_shipping_status_report`()
BEGIN
    SELECT 
        shipment_status,
        COUNT(*) as total_shipments
    FROM v_shipping_status
    GROUP BY shipment_status;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_test_user_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_test_user_create`(
    IN p_user_id VARCHAR(10),
    IN p_user_name VARCHAR(50),
    IN p_user_email VARCHAR(50),
    IN p_user_pwd VARCHAR(50),
    IN p_user_address VARCHAR(100),
    IN p_user_phone VARCHAR(15),
    IN p_user_type INT
)
BEGIN
    INSERT INTO User (user_id, user_name, user_email, user_pwd, user_address, user_phone, user_type)
    VALUES (p_user_id, p_user_name, p_user_email, SHA2(p_user_pwd, 256), p_user_address, p_user_phone, p_user_type);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_test_user_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_test_user_delete`(
IN p_user_id VARCHAR(10)
)
BEGIN
	DELETE FROM `User` 
	WHERE user_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_test_user_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_test_user_read`()
BEGIN
	SELECT * FROM User;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_test_user_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_test_user_update`(
IN p_user_id VARCHAR(10),
IN p_user_type INT
)
BEGIN
	UPDATE `User` 
	SET user_type = p_user_type
	WHERE user_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_top_selling_items` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_top_selling_items`(IN p_limit INT)
BEGIN
    SELECT * FROM v_inventory_status
    ORDER BY times_ordered DESC
    LIMIT p_limit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_estimated_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_estimated_date`(
    IN p_shipment_id VARCHAR(50),
    IN p_new_date DATE
)
BEGIN
    UPDATE Shipment 
    SET shipment_date_estimated = p_new_date 
    WHERE shipment_id = p_shipment_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_item_price` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_item_price`(
    IN p_item_id VARCHAR(15),
    IN p_new_price FLOAT
)
BEGIN
    UPDATE Item 
    SET item_prize = p_new_price 
    WHERE item_id = p_item_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_order_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_order_status`(
    IN p_order_id VARCHAR(100),
    IN p_status INT
)
BEGIN
    UPDATE `Order` 
    SET order_state = p_status 
    WHERE order_id = p_order_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_shipment_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_shipment_status`(
    IN p_shipment_id VARCHAR(50),
    IN p_status INT
)
BEGIN
    UPDATE Shipment 
    SET shipment_state = p_status 
    WHERE shipment_id = p_shipment_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_user_password` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_user_password`(
    IN p_user_id VARCHAR(10),
    IN p_new_password VARCHAR(50)
)
BEGIN
    UPDATE User 
    SET user_pwd = SHA2(p_new_password, 256)
    WHERE user_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_user_profile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_user_profile`(
    IN p_user_id VARCHAR(10),
    IN p_user_name VARCHAR(50),
    IN p_user_email VARCHAR(50),
    IN p_user_address VARCHAR(100),
    IN p_user_phone VARCHAR(15)
)
BEGIN
    UPDATE User 
    SET user_name = p_user_name,
        user_email = p_user_email,
        user_address = p_user_address,
        user_phone = p_user_phone
    WHERE user_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_verify_user_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_verify_user_login`(
    IN p_user_email VARCHAR(50),
    IN p_password VARCHAR(50)
)
BEGIN
    SELECT user_id, user_name, user_type 
    FROM User 
    WHERE user_email = p_user_email 
    AND user_pwd = SHA2(p_password, 256);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_active_orders`
--

/*!50001 DROP VIEW IF EXISTS `v_active_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_active_orders` AS select `o`.`order_id` AS `order_id`,`u`.`user_name` AS `user_name`,`i`.`item_name` AS `item_name`,`od`.`order_detail_n_items` AS `order_detail_n_items`,`o`.`order_total` AS `order_total`,`os`.`state_name` AS `order_status` from ((((`Order` `o` join `Order_Detail` `od` on(`o`.`order_id` = `od`.`order_id`)) join `User` `u` on(`od`.`user_id` = `u`.`user_id`)) join `Item` `i` on(`od`.`item_id` = `i`.`item_id`)) join `order_states` `os` on(`o`.`order_state` = `os`.`state_id`)) where `o`.`order_state` < 4 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_api_customer_orders`
--

/*!50001 DROP VIEW IF EXISTS `v_api_customer_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_api_customer_orders` AS select `u`.`user_id` AS `user_id`,`o`.`order_id` AS `order_id`,`o`.`order_date` AS `order_date`,`i`.`item_name` AS `item_name`,`od`.`order_detail_n_items` AS `order_detail_n_items`,`od`.`order_detail_subtotal` AS `order_detail_subtotal`,`os`.`state_name` AS `order_status`,`ss`.`state_name` AS `shipping_status`,`ps`.`state_name` AS `payment_status` from ((((((((`User` `u` join `Order_Detail` `od` on(`u`.`user_id` = `od`.`user_id`)) join `Order` `o` on(`od`.`order_id` = `o`.`order_id`)) join `Item` `i` on(`od`.`item_id` = `i`.`item_id`)) join `order_states` `os` on(`o`.`order_state` = `os`.`state_id`)) join `Shipment` `s` on(`od`.`order_detail_id` = `s`.`order_detail_id`)) join `shipment_states` `ss` on(`s`.`shipment_state` = `ss`.`state_id`)) join `Payment` `p` on(`od`.`payment_id` = `p`.`payment_id`)) join `payment_states` `ps` on(`p`.`payment_state` = `ps`.`state_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_api_product_details`
--

/*!50001 DROP VIEW IF EXISTS `v_api_product_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_api_product_details` AS select `i`.`item_id` AS `item_id`,`i`.`item_name` AS `item_name`,`i`.`item_description` AS `item_description`,`i`.`item_prize` AS `item_prize`,`m`.`model_name` AS `model_name`,`m`.`model_format` AS `model_format`,`md`.`model_detail_scale` AS `model_detail_scale`,`ft`.`type_name` AS `filament_type`,`pt`.`type_name` AS `print_type`,`fnt`.`type_name` AS `finishing_type`,`pc`.`color_name` AS `color` from ((((((`Item` `i` join `Model` `m` on(`i`.`model_id` = `m`.`model_id`)) join `Model_Detail` `md` on(`m`.`model_id` = `md`.`model_id`)) join `filament_types` `ft` on(`md`.`model_detail_filament` = `ft`.`type_id`)) join `print_types` `pt` on(`md`.`model_detail_type_3dprint` = `pt`.`type_id`)) join `finishing_types` `fnt` on(`md`.`model_detail_finishing` = `fnt`.`type_id`)) join `print_colors` `pc` on(`md`.`model_detail_color` = `pc`.`color_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_api_products`
--

/*!50001 DROP VIEW IF EXISTS `v_api_products`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_api_products` AS select `i`.`item_id` AS `item_id`,`i`.`item_name` AS `item_name`,`i`.`item_description` AS `item_description`,`i`.`item_prize` AS `item_prize`,`m`.`model_name` AS `model_name`,`m`.`model_format` AS `model_format`,avg(`r`.`review_rate`) AS `rating`,count(`r`.`review_id`) AS `review_count` from ((`Item` `i` join `Model` `m` on(`i`.`model_id` = `m`.`model_id`)) left join `Review` `r` on(`i`.`item_id` = `r`.`item_id`)) group by `i`.`item_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_api_reviews`
--

/*!50001 DROP VIEW IF EXISTS `v_api_reviews`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_api_reviews` AS select `i`.`item_id` AS `item_id`,`i`.`item_name` AS `item_name`,`r`.`review_rate` AS `review_rate`,`r`.`review_comment` AS `review_comment`,`r`.`review_date` AS `review_date`,`u`.`user_name` AS `user_name` from ((`Item` `i` join `Review` `r` on(`i`.`item_id` = `r`.`item_id`)) join `User` `u` on(`r`.`user_id` = `u`.`user_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_api_user_info`
--

/*!50001 DROP VIEW IF EXISTS `v_api_user_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_api_user_info` AS select `u`.`user_id` AS `user_id`,`u`.`user_name` AS `user_name`,`u`.`user_email` AS `user_email`,`u`.`user_address` AS `user_address`,count(distinct `o`.`order_id`) AS `total_orders`,count(distinct `r`.`review_id`) AS `total_reviews`,max(`o`.`order_date`) AS `last_order_date`,sum(`o`.`order_total`) AS `total_spent` from (((`User` `u` left join `Order_Detail` `od` on(`u`.`user_id` = `od`.`user_id`)) left join `Order` `o` on(`od`.`order_id` = `o`.`order_id`)) left join `Review` `r` on(`u`.`user_id` = `r`.`user_id`)) group by `u`.`user_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_customer_satisfaction`
--

/*!50001 DROP VIEW IF EXISTS `v_customer_satisfaction`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_customer_satisfaction` AS select `i`.`item_name` AS `item_name`,count(`r`.`review_id`) AS `total_reviews`,round(avg(`r`.`review_rate`),2) AS `average_rating`,count(case when `r`.`review_rate` >= 4 then 1 end) AS `positive_reviews` from (`Item` `i` left join `Review` `r` on(`i`.`item_id` = `r`.`item_id`)) group by `i`.`item_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_database_status`
--

/*!50001 DROP VIEW IF EXISTS `v_database_status`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_database_status` AS select `information_schema`.`tables`.`TABLE_NAME` AS `table_name`,`information_schema`.`tables`.`TABLE_ROWS` AS `table_rows`,`information_schema`.`tables`.`DATA_LENGTH` AS `data_length`,`information_schema`.`tables`.`INDEX_LENGTH` AS `index_length` from `information_schema`.`tables` where `information_schema`.`tables`.`TABLE_SCHEMA` = 'DreamsAndPrints' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_delivered_shipments`
--

/*!50001 DROP VIEW IF EXISTS `v_delivered_shipments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_delivered_shipments` AS select `s`.`shipment_id` AS `shipment_id`,`o`.`order_id` AS `order_id`,`u`.`user_name` AS `user_name`,`u`.`user_address` AS `user_address`,`i`.`item_name` AS `item_name`,`od`.`order_detail_n_items` AS `order_detail_n_items`,`s`.`shipment_date` AS `shipment_date`,`s`.`shipment_date_estimated` AS `shipment_date_estimated`,to_days(`s`.`shipment_date`) - to_days(`s`.`shipment_date_estimated`) AS `delivery_difference` from ((((`Shipment` `s` join `Order_Detail` `od` on(`s`.`order_detail_id` = `od`.`order_detail_id`)) join `Order` `o` on(`od`.`order_id` = `o`.`order_id`)) join `User` `u` on(`od`.`user_id` = `u`.`user_id`)) join `Item` `i` on(`od`.`item_id` = `i`.`item_id`)) where `s`.`shipment_state` = 3 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_inventory_status`
--

/*!50001 DROP VIEW IF EXISTS `v_inventory_status`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_inventory_status` AS select `i`.`item_name` AS `item_name`,count(`od`.`item_id`) AS `times_ordered`,avg(`r`.`review_rate`) AS `average_rating`,`i`.`item_prize` AS `item_prize` from ((`Item` `i` left join `Order_Detail` `od` on(`i`.`item_id` = `od`.`item_id`)) left join `Review` `r` on(`i`.`item_id` = `r`.`item_id`)) group by `i`.`item_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_payment_tracking`
--

/*!50001 DROP VIEW IF EXISTS `v_payment_tracking`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_payment_tracking` AS select `p`.`payment_id` AS `payment_id`,`o`.`order_id` AS `order_id`,`p`.`payment_mount` AS `payment_mount`,`pm`.`method_name` AS `method_name`,`ps`.`state_name` AS `state_name`,`p`.`payment_date` AS `payment_date` from ((((`Payment` `p` join `Order_Detail` `od` on(`p`.`payment_id` = `od`.`payment_id`)) join `Order` `o` on(`od`.`order_id` = `o`.`order_id`)) join `payment_methods` `pm` on(`p`.`payment_method` = `pm`.`method_id`)) join `payment_states` `ps` on(`p`.`payment_state` = `ps`.`state_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_pending_shipments`
--

/*!50001 DROP VIEW IF EXISTS `v_pending_shipments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_pending_shipments` AS select `s`.`shipment_id` AS `shipment_id`,`u`.`user_name` AS `user_name`,`u`.`user_address` AS `user_address`,`u`.`user_phone` AS `user_phone`,`i`.`item_name` AS `item_name`,`od`.`order_detail_n_items` AS `order_detail_n_items`,`s`.`shipment_date_estimated` AS `shipment_date_estimated`,`ss`.`state_name` AS `shipment_status` from ((((`Shipment` `s` join `Order_Detail` `od` on(`s`.`order_detail_id` = `od`.`order_detail_id`)) join `User` `u` on(`od`.`user_id` = `u`.`user_id`)) join `Item` `i` on(`od`.`item_id` = `i`.`item_id`)) join `shipment_states` `ss` on(`s`.`shipment_state` = `ss`.`state_id`)) where `s`.`shipment_state` in (0,1,2,4) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_popular_models`
--

/*!50001 DROP VIEW IF EXISTS `v_popular_models`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_popular_models` AS select `m`.`model_name` AS `model_name`,`m`.`model_format` AS `model_format`,count(`i`.`item_id`) AS `times_used`,count(distinct `od`.`order_id`) AS `times_ordered` from ((`Model` `m` left join `Item` `i` on(`m`.`model_id` = `i`.`model_id`)) left join `Order_Detail` `od` on(`i`.`item_id` = `od`.`item_id`)) group by `m`.`model_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_product_performance`
--

/*!50001 DROP VIEW IF EXISTS `v_product_performance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_product_performance` AS select `i`.`item_name` AS `item_name`,count(`od`.`item_id`) AS `times_ordered`,sum(`od`.`order_detail_n_items`) AS `units_sold`,avg(`r`.`review_rate`) AS `average_rating`,count(`r`.`review_id`) AS `review_count` from ((`Item` `i` left join `Order_Detail` `od` on(`i`.`item_id` = `od`.`item_id`)) left join `Review` `r` on(`i`.`item_id` = `r`.`item_id`)) group by `i`.`item_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_sales_analytics`
--

/*!50001 DROP VIEW IF EXISTS `v_sales_analytics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_sales_analytics` AS select date_format(`o`.`order_date`,'%Y-%m') AS `month`,count(distinct `o`.`order_id`) AS `total_orders`,count(distinct `od`.`user_id`) AS `unique_customers`,sum(`o`.`order_total`) AS `total_revenue`,avg(`o`.`order_total`) AS `average_order_value` from (`Order` `o` join `Order_Detail` `od` on(`o`.`order_id` = `od`.`order_id`)) group by date_format(`o`.`order_date`,'%Y-%m') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_sales_orders`
--

/*!50001 DROP VIEW IF EXISTS `v_sales_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_sales_orders` AS select `o`.`order_id` AS `order_id`,`u`.`user_name` AS `user_name`,`u`.`user_email` AS `user_email`,`i`.`item_name` AS `item_name`,`od`.`order_detail_n_items` AS `order_detail_n_items`,`od`.`order_detail_subtotal` AS `order_detail_subtotal`,`p`.`payment_state` AS `payment_state`,`o`.`order_date` AS `order_date` from ((((`Order` `o` join `Order_Detail` `od` on(`o`.`order_id` = `od`.`order_id`)) join `User` `u` on(`od`.`user_id` = `u`.`user_id`)) join `Item` `i` on(`od`.`item_id` = `i`.`item_id`)) join `Payment` `p` on(`od`.`payment_id` = `p`.`payment_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_sales_summary`
--

/*!50001 DROP VIEW IF EXISTS `v_sales_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_sales_summary` AS select cast(`o`.`order_date` as date) AS `sale_date`,count(0) AS `total_orders`,sum(`o`.`order_total`) AS `daily_revenue`,avg(`o`.`order_total`) AS `average_order` from `Order` `o` group by cast(`o`.`order_date` as date) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_shipping_status`
--

/*!50001 DROP VIEW IF EXISTS `v_shipping_status`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_shipping_status` AS select `s`.`shipment_id` AS `shipment_id`,`o`.`order_id` AS `order_id`,`u`.`user_name` AS `user_name`,`u`.`user_address` AS `user_address`,`u`.`user_phone` AS `user_phone`,`i`.`item_name` AS `item_name`,`od`.`order_detail_n_items` AS `order_detail_n_items`,`s`.`shipment_date` AS `shipment_date`,`s`.`shipment_date_estimated` AS `shipment_date_estimated`,`ss`.`state_name` AS `shipment_status` from (((((`Shipment` `s` join `Order_Detail` `od` on(`s`.`order_detail_id` = `od`.`order_detail_id`)) join `Order` `o` on(`od`.`order_id` = `o`.`order_id`)) join `User` `u` on(`od`.`user_id` = `u`.`user_id`)) join `Item` `i` on(`od`.`item_id` = `i`.`item_id`)) join `shipment_states` `ss` on(`s`.`shipment_state` = `ss`.`state_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_table_relationships`
--

/*!50001 DROP VIEW IF EXISTS `v_table_relationships`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_table_relationships` AS select `information_schema`.`KEY_COLUMN_USAGE`.`TABLE_NAME` AS `TABLE_NAME`,`information_schema`.`KEY_COLUMN_USAGE`.`COLUMN_NAME` AS `COLUMN_NAME`,`information_schema`.`KEY_COLUMN_USAGE`.`REFERENCED_TABLE_NAME` AS `REFERENCED_TABLE_NAME`,`information_schema`.`KEY_COLUMN_USAGE`.`REFERENCED_COLUMN_NAME` AS `REFERENCED_COLUMN_NAME` from `information_schema`.`KEY_COLUMN_USAGE` where `information_schema`.`KEY_COLUMN_USAGE`.`REFERENCED_TABLE_SCHEMA` = 'DreamsAndPrints' and `information_schema`.`KEY_COLUMN_USAGE`.`REFERENCED_TABLE_NAME` is not null */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_user_activity`
--

/*!50001 DROP VIEW IF EXISTS `v_user_activity`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_activity` AS select `u`.`user_name` AS `user_name`,count(`o`.`order_id`) AS `total_orders`,count(`r`.`review_id`) AS `total_reviews`,max(`o`.`order_date`) AS `last_activity` from (((`User` `u` left join `Order_Detail` `od` on(`u`.`user_id` = `od`.`user_id`)) left join `Order` `o` on(`od`.`order_id` = `o`.`order_id`)) left join `Review` `r` on(`u`.`user_id` = `r`.`user_id`)) group by `u`.`user_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-30 17:46:14
