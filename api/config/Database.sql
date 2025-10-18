-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: thy_kds
-- ------------------------------------------------------
-- Server version	8.4.3

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
-- Table structure for table `aircraft_factors`
--

DROP TABLE IF EXISTS `aircraft_factors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft_factors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `aircraft_model` varchar(100) NOT NULL,
  `fuel_multiplier` decimal(5,2) NOT NULL DEFAULT '1.00',
  `maintenance_multiplier` decimal(5,2) NOT NULL DEFAULT '1.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `airports`
--

DROP TABLE IF EXISTS `airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airports` (
  `iata_code` varchar(3) NOT NULL,
  `name` varchar(100) NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  PRIMARY KEY (`iata_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `competitor_prices`
--

DROP TABLE IF EXISTS `competitor_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competitor_prices` (
  `competitor_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int DEFAULT NULL,
  `competitor_name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `price_date` datetime NOT NULL,
  PRIMARY KEY (`competitor_id`),
  KEY `flight_id` (`flight_id`),
  CONSTRAINT `competitor_prices_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `loyalty_score` decimal(5,2) DEFAULT '0.00',
  `membership_type` varchar(20) DEFAULT NULL,
  `travel_purpose` enum('İş','Tatil','Aile Ziyareti','Diğer') DEFAULT 'Diğer',
  `age_group` enum('18-25','26-35','36-50','50+') DEFAULT '26-35',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange_rates`
--

DROP TABLE IF EXISTS `exchange_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange_rates` (
  `exchange_id` int NOT NULL AUTO_INCREMENT,
  `currency` varchar(10) NOT NULL COMMENT 'Para birimi kodu (örn: USD, EUR)',
  `rate` decimal(10,4) NOT NULL COMMENT '1 birim yabancı paranın TL karşılığı',
  `rate_date` datetime NOT NULL COMMENT 'Kurun kaydedildiği tarih',
  PRIMARY KEY (`exchange_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flight_costs`
--

DROP TABLE IF EXISTS `flight_costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_costs` (
  `cost_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fuel_cost` decimal(10,2) DEFAULT NULL,
  `staff_cost` decimal(10,2) DEFAULT NULL,
  `maintenance_cost` decimal(10,2) DEFAULT NULL,
  `other_costs` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`cost_id`),
  KEY `flight_id` (`flight_id`),
  CONSTRAINT `flight_costs_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flight_operations`
--

DROP TABLE IF EXISTS `flight_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_operations` (
  `operation_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int NOT NULL,
  `scheduled_departure` datetime NOT NULL,
  `actual_departure` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`operation_id`),
  KEY `idx_flight_id` (`flight_id`),
  CONSTRAINT `fk_operations_flights` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
  `flight_id` int NOT NULL AUTO_INCREMENT,
  `flight_number` varchar(50) NOT NULL,
  `departure_city` varchar(100) NOT NULL,
  `arrival_city` varchar(100) NOT NULL,
  `departure_date` datetime NOT NULL,
  `arrival_date` datetime NOT NULL,
  `capacity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`flight_id`),
  KEY `idx_flight_number` (`flight_number`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fuel_prices`
--

DROP TABLE IF EXISTS `fuel_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fuel_prices` (
  `fuel_id` int NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL COMMENT 'Brent petrolün varil başına USD fiyatı',
  `price_date` datetime NOT NULL COMMENT 'Fiyatın kaydedildiği tarih',
  PRIMARY KEY (`fuel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `internal_strategy_actions`
--

DROP TABLE IF EXISTS `internal_strategy_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internal_strategy_actions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `aircraft_model` varchar(50) NOT NULL,
  `tail_number` varchar(20) NOT NULL,
  `action_date` date NOT NULL,
  `priority` enum('Low','Medium','High') DEFAULT 'Medium',
  `notes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `revenue`
--

DROP TABLE IF EXISTS `revenue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `revenue` (
  `revenue_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ticket_sales` decimal(10,2) DEFAULT NULL,
  `cargo_revenue` decimal(10,2) DEFAULT NULL,
  `other_revenue` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`revenue_id`),
  KEY `flight_id` (`flight_id`),
  CONSTRAINT `revenue_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`)
) ENGINE=InnoDB AUTO_INCREMENT=331 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `route_details`
--

DROP TABLE IF EXISTS `route_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int NOT NULL,
  `distance_km` int NOT NULL,
  `origin_iata_code` varchar(3) DEFAULT NULL,
  `destination_iata_code` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_flight_id` (`flight_id`),
  KEY `fk_route_origin_airport` (`origin_iata_code`),
  KEY `fk_route_destination_airport` (`destination_iata_code`),
  CONSTRAINT `fk_route_destination_airport` FOREIGN KEY (`destination_iata_code`) REFERENCES `airports` (`iata_code`),
  CONSTRAINT `fk_route_details_flight` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`),
  CONSTRAINT `fk_route_origin_airport` FOREIGN KEY (`origin_iata_code`) REFERENCES `airports` (`iata_code`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int DEFAULT NULL,
  `sale_date` datetime NOT NULL,
  `number_of_tickets` int NOT NULL,
  `total_revenue` decimal(10,2) NOT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `idx_flight_id_sales` (`flight_id`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `sale_id` int NOT NULL,
  `flight_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `booking_date` datetime NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `seat_number` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `fk_ticket_sale` (`sale_id`),
  KEY `fk_ticket_flight` (`flight_id`),
  KEY `fk_ticket_customer` (`customer_id`),
  CONSTRAINT `fk_ticket_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `fk_ticket_flight` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`),
  CONSTRAINT `fk_ticket_sale` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`sale_id`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-19  1:17:48
