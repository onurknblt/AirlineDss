CREATE DATABASE  IF NOT EXISTS `thy_kds` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `thy_kds`;
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft_factors`
--

LOCK TABLES `aircraft_factors` WRITE;
/*!40000 ALTER TABLE `aircraft_factors` DISABLE KEYS */;
INSERT INTO `aircraft_factors` VALUES (1,'Boeing 737-800',1.00,1.00),(2,'Airbus A320',0.90,0.95),(3,'Boeing 777-300ER',1.50,1.30),(4,'Airbus A350-900',1.30,1.20),(5,'Boeing 787-9',1.40,1.25),(6,'Airbus A380',1.80,1.50),(7,'Embraer E195-E2',0.80,0.90),(8,'Bombardier CS300',0.85,0.95),(9,'Comac C919',1.00,1.05);
/*!40000 ALTER TABLE `aircraft_factors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aircraft_investments`
--

DROP TABLE IF EXISTS `aircraft_investments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft_investments` (
  `investment_id` int NOT NULL AUTO_INCREMENT,
  `aircraft_model` varchar(50) NOT NULL,
  `tail_number` varchar(10) NOT NULL,
  `purchase_price` decimal(15,2) DEFAULT NULL,
  `leasing_monthly` decimal(15,2) DEFAULT NULL,
  `estimated_fuel_cost_monthly` decimal(15,2) NOT NULL,
  `estimated_maintenance_monthly` decimal(15,2) NOT NULL,
  `estimated_staff_cost_monthly` decimal(15,2) NOT NULL,
  `average_ticket_revenue_monthly` decimal(15,2) NOT NULL,
  `expected_load_factor` decimal(5,2) NOT NULL,
  `start_date` date NOT NULL,
  PRIMARY KEY (`investment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft_investments`
--

LOCK TABLES `aircraft_investments` WRITE;
/*!40000 ALTER TABLE `aircraft_investments` DISABLE KEYS */;
INSERT INTO `aircraft_investments` VALUES (6,'Boeing 777-300ER','TC-JJJ',220000000.00,NULL,120000.00,40000.00,70000.00,500000.00,0.85,'2025-09-01'),(7,'Airbus A350-900','TC-AAB',200000000.00,NULL,100000.00,35000.00,65000.00,480000.00,0.82,'2025-09-01'),(8,'Boeing 737-800','TC-BBB',NULL,120000.00,30000.00,15000.00,25000.00,180000.00,0.78,'2025-09-01'),(9,'Airbus A320','TC-CCC',NULL,110000.00,28000.00,14000.00,22000.00,175000.00,0.80,'2025-09-01'),(10,'Boeing 787-9','TC-DDD',250000000.00,NULL,130000.00,45000.00,75000.00,550000.00,0.88,'2025-09-01');
/*!40000 ALTER TABLE `aircraft_investments` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `airports`
--

LOCK TABLES `airports` WRITE;
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
INSERT INTO `airports` VALUES ('AMS','Amsterdam Schhol Airport','Amsterdam','Netherlands',52.31055600,4.76833300),('BER','Berlin Brandenburg Airport','Berlin','Germany',52.36666700,13.50333300),('CAI','Cairo International Airport','Cairo','Egypt',30.12194400,31.40555600),('CDG','Charles de Gaulle Airport','Paris','France',49.00972200,2.54777800),('DXB','Dubai International Airport','Dubai','UAE',25.25317500,55.36567300),('ESB','Esenboga Airport','Ankara','Turkey',40.12805600,32.99500000),('IST','Istanbul Airport','Istanbul','Turkey',41.27527800,28.75194400),('JFK','John F. Kennedy Intl Airport','New York','USA',40.64131100,-73.77813900),('LAX','Los Angeles International Airport','Los Angeles','USA',33.94250000,-118.40805600),('LHR','Heathrow Airport','London','United Kingdom',51.47002500,-0.45429500),('SAW','Sabiha Gokcen Airport','Istanbul','Turkey',40.89861100,29.30916700);
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competitor_prices`
--

LOCK TABLES `competitor_prices` WRITE;
/*!40000 ALTER TABLE `competitor_prices` DISABLE KEYS */;
INSERT INTO `competitor_prices` VALUES (1,1,'Pegasus',120.50,'2025-03-01 10:00:00'),(2,2,'Lufthansa',200.75,'2025-03-02 12:00:00'),(3,3,'Emirates',350.00,'2025-03-03 14:00:00'),(4,4,'Qatar Airways',300.25,'2025-03-04 16:00:00'),(5,1,'British Airways',220.90,'2025-03-05 18:00:00'),(7,3,'KLM',310.40,'2025-03-07 22:00:00'),(8,4,'Air France',290.80,'2025-03-08 23:00:00'),(9,1,'American Airlines',275.30,'2025-03-09 09:00:00'),(10,2,'Delta',260.10,'2025-03-10 11:00:00'),(11,1,'Pegasus',145.75,'2025-03-01 09:30:00'),(12,1,'OnurAir',210.50,'2025-03-02 13:20:00'),(13,1,'SunExpress',180.20,'2025-03-03 08:10:00'),(14,1,'British Airways',240.80,'2025-03-04 17:00:00'),(15,1,'Emirates',320.60,'2025-03-05 22:15:00'),(16,1,'Lufthansa',275.10,'2025-03-06 11:45:00'),(17,1,'Qatar Airways',295.90,'2025-03-07 15:25:00'),(18,1,'KLM',260.30,'2025-03-08 19:40:00'),(19,1,'Air France',285.70,'2025-03-09 10:55:00'),(20,1,'Delta',270.25,'2025-03-10 14:35:00'),(21,2,'Lufthansa',210.40,'2025-03-01 09:10:00'),(22,2,'OnurAir',225.60,'2025-03-02 12:30:00'),(23,2,'Pegasus',160.75,'2025-03-03 15:45:00'),(24,2,'Qatar Airways',305.20,'2025-03-04 18:05:00'),(25,2,'Delta',265.10,'2025-03-05 20:30:00'),(26,2,'British Airways',255.90,'2025-03-06 09:00:00'),(27,2,'KLM',275.80,'2025-03-07 11:25:00'),(28,2,'Air France',290.60,'2025-03-08 13:50:00'),(29,2,'Emirates',340.40,'2025-03-09 16:15:00'),(30,2,'American Airlines',280.75,'2025-03-10 19:40:00'),(31,3,'Emirates',355.50,'2025-03-01 10:20:00'),(32,3,'Qatar Airways',325.30,'2025-03-02 12:45:00'),(33,3,'OnurAir',295.10,'2025-03-03 15:10:00'),(34,3,'Lufthansa',310.25,'2025-03-04 17:35:00'),(35,3,'KLM',330.40,'2025-03-05 20:00:00'),(36,3,'Air France',345.80,'2025-03-06 09:20:00'),(37,3,'British Airways',300.50,'2025-03-07 11:45:00'),(38,3,'Delta',315.70,'2025-03-08 14:10:00'),(39,3,'American Airlines',335.25,'2025-03-09 16:35:00'),(40,3,'Etihad Airways',340.60,'2025-03-10 19:00:00'),(41,4,'Qatar Airways',310.40,'2025-03-01 08:50:00'),(42,4,'Emirates',360.20,'2025-03-02 11:15:00'),(43,4,'OnurAir',285.30,'2025-03-03 13:40:00'),(44,4,'Lufthansa',305.75,'2025-03-04 16:05:00'),(45,4,'Air France',295.10,'2025-03-05 18:30:00'),(46,4,'KLM',320.80,'2025-03-06 20:55:00'),(47,4,'British Airways',310.50,'2025-03-07 09:15:00'),(48,4,'Delta',330.25,'2025-03-08 11:40:00'),(49,4,'American Airlines',340.70,'2025-03-09 14:05:00'),(50,4,'Etihad Airways',355.90,'2025-03-10 16:30:00');
/*!40000 ALTER TABLE `competitor_prices` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Ali Yılmaz','ali.yilmaz@thy.com',75.00,'Economy','Diğer','26-35'),(2,'Ayşe Demir','ayse.demir@thy.com',85.00,'Economy','Diğer','26-35'),(3,'Mehmet Kara','mehmet.kara@thy.com',92.00,'Economy','Diğer','26-35'),(4,'Zeynep Öz','zeynep.oz@thy.com',80.00,'Economy','Diğer','26-35'),(5,'Ahmet Yılmaz','ahmet.yilmaz@example.com',85.50,'Business','İş','36-50'),(6,'Ayşe Kaya','ayse.kaya@example.com',45.75,'Premium','Tatil','26-35'),(7,'Mehmet Demir','mehmet.demir@example.com',95.00,'First','Aile Ziyareti','50+'),(8,'Zeynep Şahin','zeynep.sahin@example.com',30.25,'Economy','Diğer','18-25'),(9,'Ali Can','ali.can@example.com',60.00,'Business','İş','26-35'),(10,'Fatma Arslan','fatma.arslan@example.com',70.00,'Premium','Tatil','36-50'),(11,'Mustafa Öztürk','mustafa.ozturk@example.com',50.00,'Economy','Aile Ziyareti','50+'),(12,'Elif Yıldız','elif.yildiz@example.com',80.00,'Business','Diğer','18-25'),(13,'Hüseyin Korkmaz','huseyin.korkmaz@example.com',90.00,'First','İş','36-50'),(14,'Seda Aydın','seda.aydin@example.com',40.00,'Premium','Tatil','26-35'),(15,'Ahmet Yılmaz','ahmet.yilmaz@example.com',85.50,'Business','İş','36-50'),(16,'Ayşe Kaya','ayse.kaya@example.com',45.75,'Premium','Tatil','26-35'),(17,'Mehmet Demir','mehmet.demir@example.com',95.00,'First','Aile Ziyareti','50+'),(18,'Zeynep Şahin','zeynep.sahin@example.com',30.25,'Economy','Diğer','18-25'),(19,'Ali Can','ali.can@example.com',60.00,'Business','İş','26-35'),(20,'Fatma Arslan','fatma.arslan@example.com',70.00,'Premium','Tatil','36-50'),(21,'Mustafa Öztürk','mustafa.ozturk@example.com',50.00,'Economy','Aile Ziyareti','50+'),(22,'Elif Yıldız','elif.yildiz@example.com',80.00,'Business','Diğer','18-25'),(23,'Hüseyin Korkmaz','huseyin.korkmaz@example.com',90.00,'First','İş','36-50'),(24,'Seda Aydın','seda.aydin@example.com',40.00,'Premium','Tatil','26-35');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_rates`
--

DROP TABLE IF EXISTS `exchange_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange_rates` (
  `exchange_id` int NOT NULL AUTO_INCREMENT,
  `currency` varchar(10) NOT NULL,
  `rate` decimal(10,4) NOT NULL,
  `rate_date` datetime NOT NULL,
  PRIMARY KEY (`exchange_id`)
) ENGINE=InnoDB AUTO_INCREMENT=362 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_rates`
--

LOCK TABLES `exchange_rates` WRITE;
/*!40000 ALTER TABLE `exchange_rates` DISABLE KEYS */;
INSERT INTO `exchange_rates` VALUES (317,'USD',18.5000,'2022-01-01 00:00:00'),(318,'USD',18.8000,'2022-02-01 00:00:00'),(319,'USD',19.2000,'2022-03-01 00:00:00'),(320,'USD',19.9000,'2022-04-01 00:00:00'),(321,'USD',20.5000,'2022-05-01 00:00:00'),(322,'USD',21.8000,'2022-06-01 00:00:00'),(323,'USD',22.5000,'2022-07-01 00:00:00'),(324,'USD',23.1000,'2022-08-01 00:00:00'),(325,'USD',24.8000,'2022-09-01 00:00:00'),(326,'USD',25.6000,'2022-10-01 00:00:00'),(327,'USD',26.9000,'2022-11-01 00:00:00'),(328,'USD',27.4000,'2022-12-01 00:00:00'),(329,'USD',28.2000,'2023-01-01 00:00:00'),(330,'USD',28.8000,'2023-02-01 00:00:00'),(331,'USD',29.5000,'2023-03-01 00:00:00'),(332,'USD',30.1000,'2023-04-01 00:00:00'),(333,'USD',30.8000,'2023-05-01 00:00:00'),(334,'USD',31.5000,'2023-06-01 00:00:00'),(335,'USD',32.2000,'2023-07-01 00:00:00'),(336,'USD',32.9000,'2023-08-01 00:00:00'),(337,'USD',33.8000,'2023-09-01 00:00:00'),(338,'USD',34.6000,'2023-10-01 00:00:00'),(339,'USD',35.9000,'2023-11-01 00:00:00'),(340,'USD',36.4000,'2023-12-01 00:00:00'),(341,'USD',37.0000,'2024-01-01 00:00:00'),(342,'USD',37.8000,'2024-02-01 00:00:00'),(343,'USD',38.5000,'2024-03-01 00:00:00'),(344,'USD',39.2000,'2024-04-01 00:00:00'),(345,'USD',39.9000,'2024-05-01 00:00:00'),(346,'USD',40.5000,'2024-06-01 00:00:00'),(347,'USD',41.1000,'2024-07-01 00:00:00'),(348,'USD',41.8000,'2024-08-01 00:00:00'),(349,'USD',42.5000,'2024-09-01 00:00:00'),(350,'USD',43.2000,'2024-10-01 00:00:00'),(351,'USD',43.9000,'2024-11-01 00:00:00'),(352,'USD',44.5000,'2024-12-01 00:00:00'),(353,'USD',45.0000,'2025-01-01 00:00:00'),(354,'USD',45.8000,'2025-02-01 00:00:00'),(355,'USD',46.5000,'2025-03-01 00:00:00'),(356,'USD',47.1000,'2025-04-01 00:00:00'),(357,'USD',47.8000,'2025-05-01 00:00:00'),(358,'USD',48.5000,'2025-06-01 00:00:00'),(359,'USD',49.0000,'2025-07-01 00:00:00'),(360,'USD',49.8000,'2025-08-01 00:00:00'),(361,'USD',50.5000,'2025-09-01 00:00:00');
/*!40000 ALTER TABLE `exchange_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_factors`
--

DROP TABLE IF EXISTS `external_factors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_factors` (
  `factor_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int DEFAULT NULL,
  `factor_type` varchar(100) NOT NULL,
  `factor_value` decimal(10,2) NOT NULL,
  PRIMARY KEY (`factor_id`),
  KEY `flight_id` (`flight_id`),
  CONSTRAINT `external_factors_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`),
  CONSTRAINT `check_factor_value` CHECK ((`factor_value` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_factors`
--

LOCK TABLES `external_factors` WRITE;
/*!40000 ALTER TABLE `external_factors` DISABLE KEYS */;
INSERT INTO `external_factors` VALUES (1,1,'Weather',0.80),(2,2,'Competition Price',0.85),(3,3,'Fuel Price',1.10),(4,4,'Economic Growth Rate',0.95),(5,1,'weather',0.80),(6,1,'economy',0.90),(7,1,'competition',0.70);
/*!40000 ALTER TABLE `external_factors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `flight_id` int DEFAULT NULL,
  `feedback_text` text NOT NULL,
  `feedback_date` datetime NOT NULL,
  `sentiment_score` decimal(3,2) NOT NULL,
  `rating` int DEFAULT NULL,
  PRIMARY KEY (`feedback_id`),
  KEY `idx_customer_feedback` (`customer_id`),
  KEY `idx_flight_feedback` (`flight_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`),
  CONSTRAINT `feedback_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,1,1,'Good service, but the seats were too tight.','2025-03-10 09:00:00',0.65,4),(2,2,2,'Excellent flight, everything was perfect!','2025-03-11 15:00:00',0.95,5),(3,3,3,'Food was not good, but the staff was friendly.','2025-03-12 12:30:00',0.55,3),(4,4,4,'Everything was fine but a bit late.','2025-03-15 14:00:00',0.60,4),(5,1,1,'Uçuş deneyimim çok güzeldi, personel çok ilgiliydi.','2025-03-01 10:00:00',0.95,5),(6,2,1,'Yemekler biraz soğuktu, ama genel olarak memnun kaldım.','2025-03-02 11:00:00',0.75,4),(7,3,1,'Koltuklar rahat değildi, ama personel çok yardımcı oldu.','2025-03-03 12:00:00',0.65,3),(8,4,1,'Uçuş gecikti, ama bu durum iyi yönetildi.','2025-03-04 13:00:00',0.70,4),(9,5,1,'Harika bir deneyimdi, kesinlikle tekrar uçarım.','2025-03-05 14:00:00',0.98,5),(10,6,1,'Uçuş çok pürüzsüzdü, hiçbir sorun yaşamadım.','2025-03-06 15:00:00',0.90,5),(11,7,1,'Bagaj teslimi biraz yavaştı, ama uçuş iyiydi.','2025-03-07 16:00:00',0.80,4),(12,8,1,'Personel çok kibar ve yardımseverdi.','2025-03-08 17:00:00',0.85,5),(13,9,1,'Uçuş biraz gürültülüydü, ama genel olarak iyiydi.','2025-03-09 18:00:00',0.70,4),(14,10,1,'Yemek seçenekleri çok iyiydi, memnun kaldım.','2025-03-10 19:00:00',0.88,5),(15,1,1,'Uçuş deneyimim çok güzeldi, personel çok ilgiliydi.','2025-03-01 10:00:00',0.95,5),(16,2,1,'Yemekler biraz soğuktu, ama genel olarak memnun kaldım.','2025-03-02 11:00:00',0.75,4),(17,3,1,'Koltuklar rahat değildi, ama personel çok yardımcı oldu.','2025-03-03 12:00:00',0.65,3),(18,4,1,'Uçuş gecikti, ama bu durum iyi yönetildi.','2025-03-04 13:00:00',0.70,4),(19,5,1,'Harika bir deneyimdi, kesinlikle tekrar uçarım.','2025-03-05 14:00:00',0.98,5),(20,6,1,'Uçuş çok pürüzsüzdü, hiçbir sorun yaşamadım.','2025-03-06 15:00:00',0.90,5),(21,7,1,'Bagaj teslimi biraz yavaştı, ama uçuş iyiydi.','2025-03-07 16:00:00',0.80,4),(22,8,1,'Personel çok kibar ve yardımseverdi.','2025-03-08 17:00:00',0.85,5),(23,9,1,'Uçuş biraz gürültülüydü, ama genel olarak iyiydi.','2025-03-09 18:00:00',0.70,4),(24,10,1,'Yemek seçenekleri çok iyiydi, memnun kaldım.','2025-03-10 19:00:00',0.88,5);
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_costs`
--

LOCK TABLES `flight_costs` WRITE;
/*!40000 ALTER TABLE `flight_costs` DISABLE KEYS */;
INSERT INTO `flight_costs` VALUES (1,1,'2025-10-04 16:45:37',120000.00,40000.00,15000.00,NULL),(2,2,'2025-09-29 16:45:37',380000.00,90000.00,30000.00,NULL),(3,4,'2025-10-07 16:45:37',60000.00,25000.00,8000.00,NULL),(4,3,'2025-09-24 16:45:37',180000.00,50000.00,20000.00,NULL),(5,5,'2025-10-06 16:45:37',550000.00,150000.00,50000.00,NULL);
/*!40000 ALTER TABLE `flight_costs` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_operations`
--

LOCK TABLES `flight_operations` WRITE;
/*!40000 ALTER TABLE `flight_operations` DISABLE KEYS */;
INSERT INTO `flight_operations` VALUES (1,1,'2025-10-09 14:45:37','2025-10-09 15:45:37','Delayed','2025-10-09 16:45:37'),(2,3,'2025-10-09 15:45:37','2025-10-09 16:15:37','Delayed','2025-10-09 16:45:37');
/*!40000 ALTER TABLE `flight_operations` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (1,'TK1979','Istanbul','London','2025-10-10 08:00:00','2025-10-10 10:30:00',210,150.00),(2,'TK0003','Istanbul','New York','2025-10-10 14:00:00','2025-10-10 18:00:00',300,200.00),(3,'TK0762','Istanbul','Dubai','2025-10-10 06:00:00','2025-10-10 10:30:00',180,180.00),(4,'TK1721','Istanbul','Berlin','2025-10-10 12:30:00','2025-10-10 14:50:00',160,130.00),(5,'TK0009','Istanbul','Los Angeles','2025-10-11 13:00:00','2025-10-11 17:00:00',320,250.00),(6,'TK1951','Istanbul','Amsterdam','2025-10-11 10:00:00','2025-10-11 12:45:00',170,140.00),(7,'TK0692','Istanbul','Cairo','2025-10-11 21:00:00','2025-10-11 23:15:00',150,160.00);
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fuel_prices`
--

DROP TABLE IF EXISTS `fuel_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fuel_prices` (
  `fuel_id` int NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL,
  `price_date` datetime NOT NULL,
  PRIMARY KEY (`fuel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fuel_prices`
--

LOCK TABLES `fuel_prices` WRITE;
/*!40000 ALTER TABLE `fuel_prices` DISABLE KEYS */;
INSERT INTO `fuel_prices` VALUES (164,78.50,'2022-01-01 00:00:00'),(165,82.10,'2022-02-01 00:00:00'),(166,85.00,'2022-03-01 00:00:00'),(167,88.50,'2022-04-01 00:00:00'),(168,86.75,'2022-05-01 00:00:00'),(169,90.20,'2022-06-01 00:00:00'),(170,94.10,'2022-07-01 00:00:00'),(171,97.50,'2022-08-01 00:00:00'),(172,93.80,'2022-09-01 00:00:00'),(173,90.60,'2022-10-01 00:00:00'),(174,89.90,'2022-11-01 00:00:00'),(175,87.40,'2022-12-01 00:00:00'),(176,86.20,'2023-01-01 00:00:00'),(177,88.80,'2023-02-01 00:00:00'),(178,89.50,'2023-03-01 00:00:00'),(179,91.50,'2023-04-01 00:00:00'),(180,90.10,'2023-05-01 00:00:00'),(181,92.20,'2023-06-01 00:00:00'),(182,96.00,'2023-07-01 00:00:00'),(183,99.30,'2023-08-01 00:00:00'),(184,97.80,'2023-09-01 00:00:00'),(185,94.10,'2023-10-01 00:00:00'),(186,93.50,'2023-11-01 00:00:00'),(187,92.80,'2023-12-01 00:00:00'),(188,91.50,'2024-01-01 00:00:00'),(189,92.80,'2024-02-01 00:00:00'),(190,94.20,'2024-03-01 00:00:00'),(191,96.90,'2024-04-01 00:00:00'),(192,98.70,'2024-05-01 00:00:00'),(193,101.50,'2024-06-01 00:00:00'),(194,105.20,'2024-07-01 00:00:00'),(195,108.00,'2024-08-01 00:00:00'),(196,106.30,'2024-09-01 00:00:00'),(197,102.80,'2024-10-01 00:00:00'),(198,101.90,'2024-11-01 00:00:00'),(199,100.50,'2024-12-01 00:00:00'),(200,98.60,'2025-01-01 00:00:00'),(201,100.20,'2025-02-01 00:00:00'),(202,101.80,'2025-03-01 00:00:00'),(203,103.50,'2025-04-01 00:00:00'),(204,105.00,'2025-05-01 00:00:00'),(205,107.80,'2025-06-01 00:00:00'),(206,110.00,'2025-07-01 00:00:00'),(207,112.30,'2025-08-01 00:00:00'),(208,111.50,'2025-09-01 00:00:00');
/*!40000 ALTER TABLE `fuel_prices` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internal_strategy_actions`
--

LOCK TABLES `internal_strategy_actions` WRITE;
/*!40000 ALTER TABLE `internal_strategy_actions` DISABLE KEYS */;
INSERT INTO `internal_strategy_actions` VALUES (1,'Yakıt Hedge Güncellemesi','Brent petrol fiyatlarında son 7 günlük volatilite %8,5 olarak gözlemlendi. Dolayısıyla hedge portföyünde kontrat vadesi 3 ay uzatıldı ve nominal %15 artırıldı. Risk komitesi onayı alındı; beklenen tasarruf $420,000.','Boeing 777-300ER','TC-JJJ','2025-08-31','High','Finans departmanı bilgilendirildi.'),(2,'Bakım Planı Güncellemesi','A350-900 kuyruk TC-AAB için A check bakım zamanı öne alındı. Yakıt pompası ve hidrolik sistem revizyonları tamamlandı; parçalar OEM tarafından sağlandı. Operasyonel kesinti süresi: 6 saat.','Airbus A350-900','TC-AAB','2025-08-31','Medium','Bakım ekibi bilgilendirildi.'),(3,'Rezervasyon Promosyonu','B737-800 TC-BBB uçuşu için +%10 ek kapasite ile dinamik fiyatlama uygulanacak. Promosyon yalnızca hafta sonu için geçerli; müşteri segmenti iş seyahati odaklı. Etki analizi: tahmini ek gelir $25,000.','Boeing 737-800','TC-BBB','2025-08-31','Low','Pazarlama departmanı onayladı.'),(4,'Yakıt Verimliliği Optimizasyonu','Uçuş öncesi kalkış ağırlığı analizleri yapılarak optimum yakıt yüklemesi planlanacaktır. Bu işlem, motor performans eğrileri ve uçuş rotasındaki hava akımları göz önünde bulundurularak simülasyon yazılımı üzerinden hesaplanır. Hesaplamalarda NPV bazlı uzun vadeli yakıt tasarrufu senaryoları değerlendirilir.','A320','TC-JAA','2025-09-01','High','Yakıt tüketiminde %3 azalma hedefleniyor.'),(5,'Bakım Planı Revizyonu','Bakım takviminde motor kompresör kanadı aşınmalarının erken tespiti için NDT (Non-Destructive Testing) prosedürleri artırılacaktır. Bu kapsamda planlanan bakımların ROI hesapları yapılmış ve uzun vadeli break-even analizleri göz önünde bulundurulmuştur.','B737','TC-JBB','2025-09-01','Medium','Yeni bakım protokolü test aşamasında.'),(6,'MRO Tedarikçi Değerlendirmesi','Yedek parça tedariği için alternatif MRO (Maintenance, Repair, Overhaul) sağlayıcıları ile sözleşme opsiyonları incelendi. Stok maliyetleri ile tedarik süresi arasındaki trade-off analizi yapıldı. Net bugünkü değer (NPV) bazlı senaryolar test edildi.','A321','TC-JCC','2025-09-01','High','Uzun vadeli sözleşme avantajları değerlendiriliyor.'),(7,'Simülatör Eğitim Modülü Güncellemesi','Pilot eğitim simülatörlerine yeni acil durum senaryoları eklendi. Eğitim ROI hesaplamaları ve insan faktörleri risk analizi yapıldı. Kritik senaryoların tekrarlanma olasılığına göre önceliklendirme yapıldı.','A320','TC-JDD','2025-09-01','Low','Yeni senaryolar haftaya devreye alınacak.'),(8,'Operasyonel Rota Analizi','Yaklaşan kış sezonu için Avrupa rotalarında yakıt fiyatları, hava sahası kısıtlamaları ve bekleme süreleri simüle edilerek rota optimizasyonu yapıldı. Break-even point analizi sonucunda bazı rotalarda uçuş azaltımı planlandı.','A330','TC-JEE','2025-09-01','High','Kapasite planlama birimine rapor sunuldu.'),(9,'Dijital Bakım Defteri Entegrasyonu','Kağıt tabanlı bakım defteri yerine dijital sistem entegrasyonu başlatıldı. Bu sistemde her komponentin MTBF (Mean Time Between Failure) değeri anlık takip edilecek. ROI hesaplamaları dijitalleşmenin işçilik maliyetlerini %12 düşürdüğünü gösteriyor.','B777','TC-JFF','2025-09-02','High','Dijital bakım sistemi test ortamında çalışıyor.'),(10,'Kabin Konfigürasyonu Yenileme','Yolcu deneyimini artırmak için kabin içi konfigürasyon değişikliği planlandı. Yapılan maliyet-fayda analizlerinde koltuk yoğunluğunun artışıyla birlikte break-even yük faktörü %74’ten %71’e düşürüldü.','A320','TC-JGG','2025-09-02','Medium','Prototip kabin düzeni hazırlandı.'),(11,'Uçuş Veri Kaydedici Analizi','Son üç ayın uçuş verileri FDR (Flight Data Recorder) üzerinden analiz edildi. Motor aşırı ısınma olaylarının artış trendi tespit edildi. NPV analizi motor revizyonunun ertelenmesinin yüksek risk taşıdığını gösteriyor.','B737','TC-JHH','2025-09-02','High','Rapor mühendislik ekibine iletildi.'),(12,'Yer Operasyonları Süreç Optimizasyonu','Bagaj yükleme ve uçak dönüş sürelerini azaltmaya yönelik LEAN metodolojisi uygulandı. Simülasyon sonuçlarında ortalama turnaround süresi %8 kısaldı. ROI analizi operasyonel maliyetlerde yıllık 1.2M$ tasarruf öngörüyor.','A330','TC-JII','2025-09-02','High','Pilot uygulama İstanbul Havalimanı’nda başladı.'),(13,'Yedek Parça Envanter Yönetimi','Stok yönetim sistemi yeniden yapılandırıldı. ABC analizi ve güvenlik stoğu optimizasyonu yapıldı. Break-even noktası belirlenerek, fazla stokun yarattığı finansal yük azaltıldı.','A321','TC-JJJ','2025-09-02','Low','Yeni ERP modülü ile entegre edildi.'),(14,'Yeni Rota Talep Simülasyonu','Ortadoğu pazarına yeni rota eklenmesi için talep tahmin modeli çalıştırıldı. Monte Carlo simülasyonları ile olasılık dağılımları test edildi. NPV analizi rotanın ilk 3 yılda yatırım maliyetini karşılayacağını gösteriyor.','B787','TC-JKK','2025-09-03','High','Pazar araştırması tamamlandı.'),(15,'Hava Trafik Yönetimi İyileştirmesi','Yeni ADS-B tabanlı hava trafik izleme sistemi test edildi. Sistem, uçuş takibi doğruluğunu %25 artırıyor. ROI analizi, yıllık gecikme maliyetlerini 3M$ düşüreceğini öngörüyor.','A320','TC-JLL','2025-09-03','Medium','Test sonuçları bekleniyor.'),(16,'Kabin Ekibi Eğitim Programı','CRM (Crew Resource Management) eğitim programına stres yönetimi ve acil durum senaryoları eklendi. Break-even analizi, eğitim maliyetlerinin 2 yıl içinde operasyonel kazançlarla dengeleneceğini gösteriyor.','A330','TC-JMM','2025-09-03','Low','İlk eğitim grubu önümüzdeki hafta başlıyor.'),(17,'Motor Performans İzleme','Uçuş sonrası motor verileri EHM (Engine Health Monitoring) sistemi üzerinden analiz edildi. Parametrik modelleme ile aşırı titreşim olayları tespit edildi. NPV bazlı bakım senaryolarında revizyonun ertelenmesi ekonomik değil.','B737','TC-JNN','2025-09-03','High','Üreticiye teknik rapor gönderildi.'),(18,'İklimlendirme Sistemi Verimlilik Analizi','Kabin içi iklimlendirme sisteminde enerji tüketimini %7 azaltacak optimizasyon çalışmaları yapıldı. ROI analizi, tasarrufun 18 ayda kendini amorti edeceğini gösteriyor.','A321','TC-JOO','2025-09-03','Medium','Pilot uygulama yaz sezonunda denenecek.'),(19,'Acil Motor #2 Borescope İncelemesi','TK1821 uçuşu sonrası motordan gelen anormal EGT (Egzoz Gazı Sıcaklığı) verileri nedeniyle, motorun detaylı endoskopik muayenesi planlanmıştır.','Boeing 777-300ER','TC-JJM','2025-10-08','High','İnceleme sonuçlarına göre motorun servisten çekilme olasılığı bulunmaktadır. Operasyon kontrol merkezi bilgilendirildi.'),(20,'Avrupa Uçuşları için Yakıt Tankerleme Stratejisi Değerlendirmesi','MUC, FRA ve CDG meydanlarındaki güncel yakıt fiyatları göz önünde bulundurularak, bu hatlarda tankerleme (fazla yakıt taşıma) politikasının maliyet etkinliği analiz edilecek.','Airbus A321neo','TC-LSN','2025-10-08','Medium','Analiz, son 30 günün ortalama yakıt alım verilerine dayanacaktır.'),(21,'Kabin IFE Sistemi Periyodik Kontrolü','Uzun menzil JFK uçuşu öncesi, tüm Business ve Economy sınıfı koltuklardaki IFE (Uçuş İçi Eğlence) ekranlarının ve bağlantı noktalarının işlevselliği test edilecek.','Boeing 787-9 Dreamliner','TC-LLG','2025-10-08','Medium','Arızalı tespit edilen 3\'ten fazla ünite olursa, parça değişimi için bakım ekibine haber verilecek.'),(22,'MENA Hattı Catering Yükleme Optimizasyonu','DXB ve DOH uçuşlarındaki yolcu doluluk oranlarına göre standart catering yükleme sayılarının güncellenerek atık oranının düşürülmesi hedeflenmektedir.','Airbus A330-300','TC-JOG','2025-10-08','Low','Sadece ekonomi sınıfı ikramları için geçerlidir. Rapor ticari planlama departmanına sunulacak.'),(23,'Acil Ekip Planlama Değişikliği','TK716 (IST-DEL) uçuşunun kaptan pilotunun ani rahatsızlığı nedeniyle, yedek listeden yeni bir kaptan pilot atanması ve ekibin bilgilendirilmesi gerekmektedir.','Boeing 787-9 Dreamliner','TC-LLK','2025-10-08','High','Uçuşun rötarsız kalkması için işlem en geç 2 saat içinde tamamlanmalıdır.'),(24,'A-Check Öncesi Ön Hazırlık ve Malzeme Kontrolü','Hangar randevusu yaklaşan uçağın A-Check bakımı için gerekli olan sarf malzemeleri ve yedek parçaların stok durumu kontrol edilecek.','Airbus A350-900','TC-LGE','2025-10-08','Medium','Eksik malzemeler için acil sipariş oluşturulacak ve Lojistik departmanına bilgi verilecek.'),(25,'APU (Yardımcı Güç Ünitesi) Yağ Tüketim Analizi','Son bir aydır normalden fazla yağ tükettiği gözlemlenen APU ünitesinin teknik verileri incelenecek ve olası bir bakım ihtiyacı değerlendirilecektir.','Airbus A321neo','TC-LSM','2025-10-09','Medium','Trend analizi için motor mühendisliği departmanından destek alınacak.'),(26,'Uçuş Veri Kayıtlarının (FDR) Rutin Deşifresi','Rastgele seçilen beş farklı uçuştan alınan Uçuş Veri Kayıtları (Flight Data Recorder) deşifre edilerek, standart operasyon prosedürlerine uyum ve yakıt verimliliği parametreleri analiz edilecek.','Boeing 737-800','TC-JHL','2025-10-09','Low','Bulgular, Uçuş İşletme Kalite Güvence toplantısında gündeme getirilecektir.'),(27,'Kış Operasyonları için De-icing Prosedürlerinin Gözden Geçirilmesi','Yaklaşan kış sezonu öncesinde, özellikle kuzey ülkelerindeki (OSL, ARN, HEL) meydanlar için de-icing (buzlanmayı önleme) akışkan tipleri ve tedarikçi anlaşmaları gözden geçirilecek.','Airbus A330-300','TC-LNC','2025-10-09','Medium','Maliyet ve operasyonel verimlilik odaklı bir rapor hazırlanacak.'),(28,'Kaptan Pilot Simülatör Eğitimi Planlaması','Periyodik tazeleme eğitimi (recurrent training) zamanı gelen 12 kaptan pilot için simülatör seansları planlanacak ve kendilerine tebliğ edilecek.','Boeing 777-300ER','TC-LKA','2025-10-09','Medium','Planlama, pilotların aylık uçuş programlarını aksatmayacak şekilde yapılmalıdır.'),(29,'Lastik Basınç Sensörü Değişimi','Sağ ana iniş takımındaki 3 numaralı lastiğin basınç sensöründen (TPMS) aralıklı olarak yanlış veri alındığı rapor edilmiştir. Sensörün değişimi planlanmıştır.','Airbus A350-900','TC-LGF','2025-10-09','High','Uçağın bir sonraki seferi uzun menzil olduğu için değişim operasyon öncesi zorunludur.'),(30,'Kargo Ağırlık ve Denge (Weight & Balance) Optimizasyonu','Özellikle Uzak Doğu kargo hatlarında (ICN, HKG) daha verimli yükleme yapılması için kullanılan ağırlık ve denge yazılımındaki standart palet tanımlarının güncellenmesi.','Boeing 777F','TC-LJL','2025-10-09','Low','Kargo operasyonları ve yer işletme ile koordineli çalışılacak.'),(31,'Kabin Derin Temizlik ve Dezenfeksiyon','Uçak, periyodik planlı bakım kapsamında detaylı kabin temizliği (deep cleaning) ve dezenfeksiyon işlemleri için hangara alınacak.','Boeing 787-9 Dreamliner','TC-LLI','2025-10-10','Low','İşlem yaklaşık 6 saat sürecektir. Uçak gece konaklamasında olacak.'),(32,'Fren Ünitesi Değişimi Planlaması','Sol ana iniş takımındaki fren ünitesinin kullanım ömrü (life cycle) %90\'a ulaşmıştır. Önümüzdeki 7 gün içinde değiştirilmesi için planlama yapılacak.','Airbus A321neo','TC-LSP','2025-10-10','Medium','Gerekli parça ve ekipmanların hazır edilmesi için lojistik ve bakım planlama departmanları bilgilendirildi.'),(33,'Ek Gelir (Ancillary Revenue) Performans Analizi','Son çeyrekte, ekstra bagaj hakkı ve koltuk seçimi satışlarının en yüksek ve en düşük olduğu 10 rota belirlenerek, bu durumun nedenleri analiz edilecek.','Airbus A330-300','TC-JNS','2025-10-10','Medium','Ticari departman, gelir yönetimi ekibi tarafından hazırlanacak sunumu değerlendirecek.'),(34,'Uçak Değişikliği (Aircraft Swap) Değerlendirmesi','Yaklaşan bayram dönemi için artan yolcu talebi öngörülen TK2124 (IST-ESB) uçuşunda, A321neo yerine daha yüksek kapasiteli A330 uçağının kullanılması olasılığı değerlendirilecek.','Airbus A321neo','TC-LSR','2025-10-10','High','Karar, hem operasyonel maliyetler hem de potansiyel gelir artışı göz önünde bulundurularak verilecektir.'),(35,'FMS Navigasyon Veritabanı Güncellemesi','Uçağın Uçuş Yönetim Sistemi (FMS) için en son AIRAC döngüsüne ait navigasyon veritabanı yüklenecek.','Boeing 737 MAX 8','TC-LCI','2025-10-10','Medium','Yükleme sonrası yer testleri (ground tests) aviyonik teknisyenleri tarafından yapılacaktır.'),(36,'Yer Hizmetleri Süre (Turnaround Time) İyileştirme Toplantısı','İzmir (ADB) meydanında son dönemde artan yer hizmetleri sürelerini (turnaround time) azaltmak amacıyla, yer hizmetleri sağlayıcısı firma yetkilileri ile bir değerlendirme toplantısı yapılacak.','Boeing 737-800','TC-JFV','2025-10-10','Low','Toplantıda son 3 ayın operasyonel verileri ve gecikme nedenleri ele alınacak.');
/*!40000 ALTER TABLE `internal_strategy_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loyalty_programs`
--

DROP TABLE IF EXISTS `loyalty_programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_programs` (
  `program_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `points_earned` decimal(10,2) NOT NULL,
  `points_spent` decimal(10,2) NOT NULL,
  `total_points` decimal(10,2) NOT NULL,
  PRIMARY KEY (`program_id`),
  KEY `idx_customer_loyalty` (`customer_id`),
  CONSTRAINT `loyalty_programs_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loyalty_programs`
--

LOCK TABLES `loyalty_programs` WRITE;
/*!40000 ALTER TABLE `loyalty_programs` DISABLE KEYS */;
INSERT INTO `loyalty_programs` VALUES (1,1,1000.00,500.00,1500.00),(2,2,1500.00,700.00,2200.00),(3,3,1200.00,400.00,1800.00),(4,4,800.00,300.00,1100.00),(5,1,1000.00,500.00,500.00),(6,2,750.00,250.00,500.00),(7,3,1500.00,1000.00,500.00),(8,4,300.00,100.00,200.00),(9,5,1200.00,700.00,500.00),(10,6,900.00,400.00,500.00),(11,7,600.00,300.00,300.00),(12,8,1100.00,600.00,500.00),(13,9,1300.00,800.00,500.00),(14,10,800.00,300.00,500.00),(15,1,1000.00,500.00,500.00),(16,2,750.00,250.00,500.00),(17,3,1500.00,1000.00,500.00),(18,4,300.00,100.00,200.00),(19,5,1200.00,700.00,500.00),(20,6,900.00,400.00,500.00),(21,7,600.00,300.00,300.00),(22,8,1100.00,600.00,500.00),(23,9,1300.00,800.00,500.00),(24,10,800.00,300.00,500.00);
/*!40000 ALTER TABLE `loyalty_programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricing_models`
--

DROP TABLE IF EXISTS `pricing_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pricing_models` (
  `pricing_model_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int DEFAULT NULL,
  `base_price` decimal(10,2) DEFAULT NULL,
  `seasonal_factor` decimal(5,2) DEFAULT NULL,
  `demand_factor` decimal(5,2) DEFAULT NULL,
  `optimal_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`pricing_model_id`),
  KEY `flight_id` (`flight_id`),
  CONSTRAINT `pricing_models_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`),
  CONSTRAINT `check_factors` CHECK (((`seasonal_factor` between 0 and 1) and (`demand_factor` between 0 and 1)))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricing_models`
--

LOCK TABLES `pricing_models` WRITE;
/*!40000 ALTER TABLE `pricing_models` DISABLE KEYS */;
INSERT INTO `pricing_models` VALUES (9,1,150.00,0.95,0.90,135.00),(10,2,200.00,1.00,0.85,170.00),(11,3,180.00,0.98,0.95,190.00),(12,4,130.00,0.90,0.92,120.00);
/*!40000 ALTER TABLE `pricing_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profit_margins`
--

DROP TABLE IF EXISTS `profit_margins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profit_margins` (
  `profit_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int DEFAULT NULL,
  `total_revenue` decimal(10,2) DEFAULT NULL,
  `total_cost` decimal(10,2) DEFAULT NULL,
  `net_profit` decimal(10,2) DEFAULT NULL,
  `profit_margin` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`profit_id`),
  KEY `flight_id` (`flight_id`),
  CONSTRAINT `profit_margins_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profit_margins`
--

LOCK TABLES `profit_margins` WRITE;
/*!40000 ALTER TABLE `profit_margins` DISABLE KEYS */;
INSERT INTO `profit_margins` VALUES (1,1,15000.00,12000.00,3000.00,20.00),(2,2,18000.00,14500.00,3500.00,19.44),(3,3,21000.00,17000.00,4000.00,19.05),(4,4,25000.00,20000.00,5000.00,20.00),(5,1,16000.00,13000.00,3000.00,18.75),(6,2,19000.00,15500.00,3500.00,18.42),(7,3,22000.00,18000.00,4000.00,18.18),(8,4,26000.00,21000.00,5000.00,19.23),(9,1,17000.00,14000.00,3000.00,17.65),(10,2,20000.00,16500.00,3500.00,17.50);
/*!40000 ALTER TABLE `profit_margins` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revenue`
--

LOCK TABLES `revenue` WRITE;
/*!40000 ALTER TABLE `revenue` DISABLE KEYS */;
INSERT INTO `revenue` VALUES (1,1,'2025-10-04 16:45:37',250000.00,30000.00,NULL),(2,2,'2025-09-29 16:45:37',450000.00,50000.00,NULL),(3,4,'2025-10-07 16:45:37',90000.00,5000.00,NULL),(4,3,'2025-09-24 16:45:37',320000.00,45000.00,NULL),(5,5,'2025-10-06 16:45:37',600000.00,70000.00,NULL);
/*!40000 ALTER TABLE `revenue` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route_details`
--

LOCK TABLES `route_details` WRITE;
/*!40000 ALTER TABLE `route_details` DISABLE KEYS */;
INSERT INTO `route_details` VALUES (1,1,2495,'IST','LHR'),(2,2,8045,'IST','JFK'),(3,3,2980,'IST','DXB'),(4,4,1740,'IST','BER'),(5,5,9630,'IST','LAX'),(6,6,2220,'IST','AMS'),(7,7,1250,'IST','CAI');
/*!40000 ALTER TABLE `route_details` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=330 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,1,'2025-03-09 10:00:00',150,22500.00),(2,2,'2025-03-10 09:00:00',160,32000.00),(3,3,'2025-03-11 11:00:00',180,32400.00),(4,4,'2025-03-14 13:00:00',120,15600.00),(5,1,'2024-08-01 08:00:00',120,2400.00),(6,1,'2024-08-02 08:15:00',130,2600.00),(7,1,'2024-08-03 08:30:00',125,2500.00),(8,1,'2024-08-04 08:45:00',135,2700.00),(9,1,'2024-08-05 09:00:00',140,2800.00),(10,1,'2024-08-06 09:15:00',110,2200.00),(11,1,'2024-08-07 09:30:00',115,2300.00),(12,1,'2024-08-08 09:45:00',120,2400.00),(13,1,'2024-08-09 10:00:00',125,2500.00),(14,1,'2024-08-10 10:15:00',130,2600.00),(15,1,'2024-08-11 10:30:00',100,2000.00),(16,1,'2024-08-12 10:45:00',115,2300.00),(17,1,'2024-08-13 11:00:00',120,2400.00),(18,1,'2024-08-14 11:15:00',130,2600.00),(19,1,'2024-08-15 11:30:00',125,2500.00),(20,1,'2024-08-16 11:45:00',140,2800.00),(21,1,'2024-08-17 12:00:00',145,2900.00),(22,1,'2024-08-18 12:15:00',130,2600.00),(23,1,'2024-08-19 12:30:00',120,2400.00),(24,1,'2024-08-20 12:45:00',110,2200.00),(25,1,'2023-08-01 08:00:00',110,2200.00),(26,1,'2023-08-02 08:15:00',105,2100.00),(27,1,'2023-08-03 08:30:00',115,2300.00),(28,1,'2023-08-04 08:45:00',120,2400.00),(29,1,'2023-08-05 09:00:00',125,2500.00),(30,1,'2023-08-06 09:15:00',130,2600.00),(31,1,'2023-08-07 09:30:00',135,2700.00),(32,1,'2023-08-08 09:45:00',140,2800.00),(33,1,'2023-08-09 10:00:00',145,2900.00),(34,1,'2023-08-10 10:15:00',130,2600.00),(35,1,'2023-08-11 10:30:00',125,2500.00),(36,1,'2023-08-12 10:45:00',120,2400.00),(37,1,'2023-08-13 11:00:00',115,2300.00),(38,1,'2023-08-14 11:15:00',125,2500.00),(39,1,'2023-08-15 11:30:00',135,2700.00),(40,1,'2023-08-16 11:45:00',140,2800.00),(41,1,'2023-08-17 12:00:00',130,2600.00),(42,1,'2023-08-18 12:15:00',125,2500.00),(43,1,'2023-08-19 12:30:00',120,2400.00),(44,1,'2023-08-20 12:45:00',115,2300.00),(45,1,'2023-09-01 08:00:00',150,3000.00),(46,1,'2023-09-02 08:15:00',155,3100.00),(47,1,'2023-09-03 08:30:00',160,3200.00),(48,1,'2023-09-04 08:45:00',150,3000.00),(49,1,'2023-09-05 09:00:00',145,2900.00),(50,1,'2023-09-06 09:15:00',160,3200.00),(51,1,'2023-09-07 09:30:00',165,3300.00),(52,1,'2023-09-08 09:45:00',170,3400.00),(53,1,'2023-09-09 10:00:00',155,3100.00),(54,1,'2023-09-10 10:15:00',150,3000.00),(55,1,'2023-09-11 10:30:00',145,2900.00),(56,1,'2023-09-12 10:45:00',140,2800.00),(57,1,'2023-09-13 11:00:00',155,3100.00),(58,1,'2023-09-14 11:15:00',165,3300.00),(59,1,'2023-09-15 11:30:00',170,3400.00),(60,1,'2023-09-16 11:45:00',160,3200.00),(61,1,'2023-09-17 12:00:00',155,3100.00),(62,1,'2023-09-18 12:15:00',150,3000.00),(63,1,'2023-09-19 12:30:00',145,2900.00),(64,1,'2023-09-20 12:45:00',140,2800.00),(65,1,'2023-10-01 08:00:00',160,3200.00),(66,1,'2023-10-02 08:15:00',165,3300.00),(67,1,'2023-10-03 08:30:00',170,3400.00),(68,1,'2023-10-04 08:45:00',160,3200.00),(69,1,'2023-10-05 09:00:00',155,3100.00),(70,1,'2023-10-06 09:15:00',170,3400.00),(71,1,'2023-10-07 09:30:00',175,3500.00),(72,1,'2023-10-08 09:45:00',160,3200.00),(73,1,'2023-10-09 10:00:00',155,3100.00),(74,1,'2023-10-10 10:15:00',150,3000.00),(75,1,'2023-10-11 10:30:00',145,2900.00),(76,1,'2023-10-12 10:45:00',160,3200.00),(77,1,'2023-10-13 11:00:00',170,3400.00),(78,1,'2023-10-14 11:15:00',175,3500.00),(79,1,'2023-10-15 11:30:00',160,3200.00),(80,1,'2023-10-16 11:45:00',155,3100.00),(81,1,'2023-10-17 12:00:00',150,3000.00),(82,1,'2023-10-18 12:15:00',145,2900.00),(83,1,'2023-10-19 12:30:00',140,2800.00),(84,1,'2023-10-20 12:45:00',135,2700.00),(85,1,'2024-01-15 00:00:00',150,37500.00),(86,1,'2024-02-15 00:00:00',160,40000.00),(87,1,'2024-03-15 00:00:00',140,35000.00),(88,1,'2024-04-15 00:00:00',130,32500.00),(89,1,'2024-05-15 00:00:00',170,42500.00),(90,1,'2024-06-15 00:00:00',180,45000.00),(91,1,'2024-07-15 00:00:00',190,47500.00),(92,1,'2024-08-15 00:00:00',200,50000.00),(93,1,'2024-09-15 00:00:00',185,46250.00),(94,1,'2024-10-15 00:00:00',175,43750.00),(95,1,'2024-11-15 00:00:00',160,40000.00),(96,1,'2024-12-15 00:00:00',155,38750.00),(145,1,'2024-03-05 00:00:00',150,45000.00),(146,1,'2024-03-12 00:00:00',120,36000.00),(147,1,'2024-03-20 00:00:00',180,54000.00),(148,1,'2024-03-28 00:00:00',200,60000.00),(149,1,'2024-04-02 00:00:00',140,42000.00),(150,1,'2024-04-10 00:00:00',130,39000.00),(151,1,'2024-04-18 00:00:00',170,51000.00),(152,1,'2024-04-26 00:00:00',190,57000.00),(153,1,'2024-05-03 00:00:00',160,48000.00),(154,1,'2024-05-11 00:00:00',180,54000.00),(155,1,'2024-05-19 00:00:00',210,63000.00),(156,1,'2024-05-27 00:00:00',190,57000.00),(157,1,'2024-06-04 00:00:00',170,51000.00),(158,1,'2024-06-12 00:00:00',200,60000.00),(159,1,'2024-06-20 00:00:00',220,66000.00),(160,1,'2024-06-28 00:00:00',230,69000.00),(161,1,'2024-07-06 00:00:00',250,75000.00),(162,1,'2024-07-14 00:00:00',270,81000.00),(163,1,'2024-07-22 00:00:00',290,87000.00),(164,1,'2024-07-30 00:00:00',280,84000.00),(165,1,'2024-08-07 00:00:00',260,78000.00),(166,1,'2024-08-15 00:00:00',250,75000.00),(167,1,'2024-08-23 00:00:00',240,72000.00),(168,1,'2024-08-31 00:00:00',230,69000.00),(169,1,'2024-09-08 00:00:00',200,60000.00),(170,1,'2024-09-16 00:00:00',180,54000.00),(171,1,'2024-09-24 00:00:00',190,57000.00),(172,1,'2024-09-30 00:00:00',170,51000.00),(173,1,'2024-10-05 00:00:00',160,48000.00),(174,1,'2024-10-13 00:00:00',140,42000.00),(175,1,'2024-10-21 00:00:00',130,39000.00),(176,1,'2024-10-29 00:00:00',120,36000.00),(177,1,'2024-11-06 00:00:00',110,33000.00),(178,1,'2024-11-14 00:00:00',100,30000.00),(179,1,'2024-11-22 00:00:00',90,27000.00),(180,1,'2024-11-30 00:00:00',80,24000.00),(181,1,'2024-12-08 00:00:00',70,21000.00),(182,1,'2024-12-16 00:00:00',60,18000.00),(183,1,'2024-12-24 00:00:00',50,15000.00),(184,1,'2024-12-31 00:00:00',40,12000.00),(185,1,'2025-01-07 00:00:00',50,15000.00),(186,1,'2025-01-15 00:00:00',60,18000.00),(187,1,'2025-01-23 00:00:00',80,24000.00),(188,1,'2025-01-31 00:00:00',90,27000.00),(189,1,'2025-02-07 00:00:00',110,33000.00),(190,1,'2025-02-15 00:00:00',130,39000.00),(191,1,'2025-02-23 00:00:00',140,42000.00),(192,1,'2025-02-27 00:00:00',150,45000.00),(193,2,'2024-03-01 00:00:00',110,2200.00),(194,2,'2024-03-02 00:00:00',115,2300.00),(195,2,'2024-03-03 00:00:00',120,2400.00),(196,2,'2024-03-04 00:00:00',125,2500.00),(197,2,'2024-03-05 00:00:00',130,2600.00),(198,2,'2024-03-06 00:00:00',135,2700.00),(199,2,'2024-03-07 00:00:00',140,2800.00),(200,2,'2024-03-08 00:00:00',145,2900.00),(201,2,'2024-03-09 00:00:00',150,3000.00),(202,2,'2024-03-10 00:00:00',155,3100.00),(203,2,'2024-03-11 00:00:00',160,3200.00),(204,2,'2024-03-12 00:00:00',165,3300.00),(205,2,'2024-03-13 00:00:00',170,3400.00),(206,2,'2024-03-14 00:00:00',175,3500.00),(207,2,'2024-03-15 00:00:00',180,3600.00),(208,2,'2024-03-16 00:00:00',185,3700.00),(209,2,'2024-03-17 00:00:00',190,3800.00),(210,2,'2024-03-18 00:00:00',195,3900.00),(211,2,'2024-03-19 00:00:00',200,4000.00),(212,2,'2024-03-20 00:00:00',205,4100.00),(213,2,'2024-03-21 00:00:00',210,4200.00),(214,2,'2024-03-22 00:00:00',215,4300.00),(215,2,'2024-03-23 00:00:00',220,4400.00),(216,2,'2024-03-24 00:00:00',225,4500.00),(217,2,'2024-03-25 00:00:00',230,4600.00),(218,2,'2024-03-26 00:00:00',235,4700.00),(219,2,'2024-03-27 00:00:00',240,4800.00),(220,2,'2024-03-28 00:00:00',245,4900.00),(221,2,'2024-03-29 00:00:00',250,5000.00),(222,2,'2024-03-30 00:00:00',255,5100.00),(223,2,'2024-03-31 00:00:00',260,5200.00),(224,2,'2024-04-01 00:00:00',265,5300.00),(225,2,'2024-04-02 00:00:00',270,5400.00),(226,2,'2024-04-03 00:00:00',275,5500.00),(227,2,'2024-04-04 00:00:00',280,5600.00),(228,2,'2024-04-05 00:00:00',285,5700.00),(229,2,'2024-04-06 00:00:00',290,5800.00),(230,2,'2024-04-07 00:00:00',295,5900.00),(231,2,'2024-04-08 00:00:00',300,6000.00),(232,2,'2024-04-09 00:00:00',305,6100.00),(233,2,'2024-04-10 00:00:00',310,6200.00),(234,2,'2024-04-11 00:00:00',315,6300.00),(235,2,'2024-04-12 00:00:00',320,6400.00),(236,2,'2024-04-13 00:00:00',325,6500.00),(237,2,'2024-04-14 00:00:00',330,6600.00),(238,2,'2024-04-15 00:00:00',335,6700.00),(239,2,'2024-04-16 00:00:00',340,6800.00),(240,2,'2024-04-17 00:00:00',345,6900.00),(241,2,'2024-04-18 00:00:00',350,7000.00),(242,2,'2024-04-19 00:00:00',355,7100.00),(243,2,'2024-04-20 00:00:00',360,7200.00),(244,2,'2024-04-21 00:00:00',365,7300.00),(245,2,'2024-04-22 00:00:00',370,7400.00),(246,2,'2024-04-23 00:00:00',375,7500.00),(247,2,'2024-04-24 00:00:00',380,7600.00),(248,2,'2023-03-01 00:00:00',150,2250.00),(249,2,'2023-04-01 00:00:00',155,2325.00),(250,2,'2023-05-01 00:00:00',160,2400.00),(251,2,'2023-06-01 00:00:00',165,2475.00),(252,2,'2023-07-01 00:00:00',170,2550.00),(253,2,'2023-08-01 00:00:00',175,2625.00),(254,2,'2023-09-01 00:00:00',180,2700.00),(255,2,'2023-10-01 00:00:00',185,2775.00),(256,2,'2023-11-01 00:00:00',190,2850.00),(257,2,'2023-12-01 00:00:00',195,2925.00),(258,2,'2024-01-01 00:00:00',200,3000.00),(259,2,'2024-02-01 00:00:00',205,3075.00),(260,2,'2024-03-01 00:00:00',210,3150.00),(261,2,'2024-04-01 00:00:00',215,3225.00),(262,2,'2024-05-01 00:00:00',220,3300.00),(263,2,'2024-06-01 00:00:00',225,3375.00),(264,2,'2024-07-01 00:00:00',230,3450.00),(265,2,'2024-08-01 00:00:00',235,3525.00),(266,2,'2024-09-01 00:00:00',240,3600.00),(267,2,'2024-10-01 00:00:00',245,3675.00),(268,2,'2024-11-01 00:00:00',250,3750.00),(269,2,'2024-12-01 00:00:00',255,3825.00),(270,2,'2025-01-01 00:00:00',260,3900.00),(271,2,'2025-02-01 00:00:00',265,3975.00),(272,3,'2023-03-01 00:00:00',150,2250.00),(273,3,'2023-04-01 00:00:00',160,2400.00),(274,3,'2023-05-01 00:00:00',170,2550.00),(275,3,'2023-06-01 00:00:00',180,2700.00),(276,3,'2023-07-01 00:00:00',190,2850.00),(277,3,'2023-08-01 00:00:00',200,3000.00),(278,3,'2023-09-01 00:00:00',210,3150.00),(279,3,'2023-10-01 00:00:00',220,3300.00),(280,3,'2023-11-01 00:00:00',230,3450.00),(281,3,'2023-12-01 00:00:00',240,3600.00),(282,3,'2024-01-01 00:00:00',250,3750.00),(283,3,'2024-02-01 00:00:00',260,3900.00),(284,3,'2024-03-01 00:00:00',270,4050.00),(285,3,'2024-04-01 00:00:00',280,4200.00),(286,3,'2024-05-01 00:00:00',290,4350.00),(287,3,'2024-06-01 00:00:00',300,4500.00),(288,3,'2024-07-01 00:00:00',310,4650.00),(289,3,'2024-08-01 00:00:00',320,4800.00),(290,3,'2024-09-01 00:00:00',330,4950.00),(291,3,'2024-10-01 00:00:00',340,5100.00),(292,3,'2024-11-01 00:00:00',350,5250.00),(293,3,'2024-12-01 00:00:00',360,5400.00),(294,3,'2025-01-01 00:00:00',370,5550.00),(295,3,'2025-02-01 00:00:00',380,5700.00),(296,3,'2025-03-01 00:00:00',390,5850.00),(297,4,'2023-03-01 00:00:00',180,2700.00),(298,4,'2023-04-01 00:00:00',190,2850.00),(299,4,'2023-05-01 00:00:00',200,3000.00),(300,4,'2023-06-01 00:00:00',210,3150.00),(301,4,'2023-07-01 00:00:00',220,3300.00),(302,4,'2023-08-01 00:00:00',230,3450.00),(303,4,'2023-09-01 00:00:00',240,3600.00),(304,4,'2023-10-01 00:00:00',250,3750.00),(305,4,'2023-11-01 00:00:00',260,3900.00),(306,4,'2023-12-01 00:00:00',270,4050.00),(307,4,'2024-01-01 00:00:00',280,4200.00),(308,4,'2024-02-01 00:00:00',290,4350.00),(309,4,'2024-03-01 00:00:00',300,4500.00),(310,4,'2024-04-01 00:00:00',310,4650.00),(311,4,'2024-05-01 00:00:00',320,4800.00),(312,4,'2024-06-01 00:00:00',330,4950.00),(313,4,'2024-07-01 00:00:00',340,5100.00),(314,4,'2024-08-01 00:00:00',350,5250.00),(315,4,'2024-09-01 00:00:00',360,5400.00),(316,4,'2024-10-01 00:00:00',370,5550.00),(317,4,'2024-11-01 00:00:00',380,5700.00),(318,4,'2024-12-01 00:00:00',390,5850.00),(319,4,'2025-01-01 00:00:00',400,6000.00),(320,4,'2025-02-01 00:00:00',410,6150.00),(321,4,'2025-03-01 00:00:00',420,6300.00),(322,1,'2025-01-01 00:00:00',50,7500.00),(323,1,'2025-03-08 00:00:00',10,1500.00),(324,2,'2025-01-15 00:00:00',30,6000.00),(325,2,'2025-03-09 00:00:00',20,4000.00),(326,3,'2025-02-01 00:00:00',40,7200.00),(327,3,'2025-03-10 00:00:00',15,2700.00),(328,4,'2025-02-20 00:00:00',20,2600.00),(329,4,'2025-03-14 00:00:00',10,1300.00);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,1,1,1,'2025-02-28 08:00:00',180.00,'10A'),(2,1,1,2,'2025-02-28 08:00:00',180.00,'10B'),(3,2,1,3,'2025-02-28 08:00:00',190.00,'11A'),(4,2,1,4,'2025-02-28 08:00:00',200.00,'12C'),(5,2,1,5,'2025-02-28 08:00:00',220.00,'15D'),(6,3,2,6,'2025-03-01 14:00:00',420.00,'20A'),(7,3,2,7,'2025-03-01 14:00:00',430.00,'20B'),(8,3,2,8,'2025-03-01 14:00:00',440.00,'21A'),(9,4,2,9,'2025-03-01 14:00:00',460.00,'22C'),(10,4,2,10,'2025-03-01 14:00:00',500.00,'23D'),(11,5,3,11,'2025-03-02 06:00:00',270.00,'14A'),(12,5,3,12,'2025-03-02 06:00:00',280.00,'14B'),(13,6,3,13,'2025-03-02 06:00:00',290.00,'15A'),(14,6,3,14,'2025-03-02 06:00:00',310.00,'16C'),(15,6,3,15,'2025-03-02 06:00:00',330.00,'17D'),(16,7,4,16,'2025-03-05 12:30:00',150.00,'05A'),(17,7,4,17,'2025-03-05 12:30:00',160.00,'05B'),(18,8,4,18,'2025-03-05 12:30:00',170.00,'06A'),(19,8,4,19,'2025-03-05 12:30:00',175.00,'07C'),(20,8,4,20,'2025-03-05 12:30:00',190.00,'08D'),(21,9,1,21,'2025-02-28 08:00:00',185.00,'13A'),(22,9,2,22,'2025-03-01 14:00:00',435.00,'24B'),(23,10,3,23,'2025-03-02 06:00:00',295.00,'18A'),(24,10,4,24,'2025-03-05 12:30:00',180.00,'09C'),(25,1,1,1,'2025-01-01 00:00:00',150.00,'1A'),(26,1,1,2,'2025-01-02 00:00:00',150.00,'1B'),(27,1,1,3,'2025-01-05 00:00:00',150.00,'1C'),(28,2,1,4,'2025-03-08 00:00:00',150.00,'2A'),(29,2,1,5,'2025-03-09 00:00:00',150.00,'2B'),(30,3,2,6,'2025-01-15 00:00:00',200.00,'1A'),(31,3,2,7,'2025-01-20 00:00:00',200.00,'1B'),(32,4,2,8,'2025-03-09 00:00:00',200.00,'2A'),(33,4,2,9,'2025-03-10 00:00:00',200.00,'2B'),(34,5,3,10,'2025-02-01 00:00:00',180.00,'1A'),(35,5,3,11,'2025-02-05 00:00:00',180.00,'1B'),(36,6,3,12,'2025-03-10 00:00:00',180.00,'2A'),(37,7,4,13,'2025-02-20 00:00:00',130.00,'1A'),(38,8,4,14,'2025-03-14 00:00:00',130.00,'2A');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'test@example.com','$2b$10$7c1VTFhChASArsHhybFvFucYKv2Ku.L9Bb8FKBFKOdCdoW1jBOg1q'),(2,'onurknblt@gmail.com','$2b$10$z1iFQklA8bl1OfA4ZX8CRuK/Y7EFPyz8Bf1IHrRDTLbs3gWZoSRJm'),(3,'test','$2b$10$vI7p/I/2ytoi5dAVoocJKuv6W.1WQz3Epn5L8HfxDuvR21JLZDK/O'),(4,'tuborg@hotmail.com','$2b$10$TaDpJf8JdqCABzEyVhJ7cekxuORh//2n9mCup3BRkUAAiGrbZVF5m'),(5,'kutay@gmail.com','$2b$10$91pbzPcjVlBKC0E/RbnV..6rhwyYNCUiFWnKnixDZGhP1OBGXrDmy'),(6,'selma@gmail.com','$2b$10$RldqpMYDxsEM4tKexKDpkO7aJ6k6kcZQpw3//IZGzAGgERlLitQxO'),(7,'janset@gmail.com','$2b$10$9FJiKNrwZf2AF0IrvRdKIOZb2PAMVksXoG2auFo6721Ctv7ARee6C'),(8,'ramiz@gmail.com','$2b$10$R9KHNXca1HgLhLG7leKWJu2a0wNOYZ.5rxm/OWqfsM0MzI6EE7AH2');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-09 16:49:55
