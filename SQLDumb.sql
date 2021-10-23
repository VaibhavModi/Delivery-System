CREATE DATABASE  IF NOT EXISTS `delivery` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `delivery`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: delivery
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `botlogin`
--

DROP TABLE IF EXISTS `botlogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `botlogin` (
  `botID` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`botID`,`username`,`password`),
  CONSTRAINT `botID` FOREIGN KEY (`botID`) REFERENCES `deliverybot` (`botID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `botlogin`
--

LOCK TABLES `botlogin` WRITE;
/*!40000 ALTER TABLE `botlogin` DISABLE KEYS */;
INSERT INTO `botlogin` VALUES ('B-901','roger','that'),('B-902','walter','white'),('B-903','mrx','123'),('B-904','wat','son');
/*!40000 ALTER TABLE `botlogin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courier`
--

DROP TABLE IF EXISTS `courier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courier` (
  `customerID` varchar(45) NOT NULL,
  `deliveryID` varchar(45) NOT NULL,
  `targetID` varchar(45) NOT NULL,
  PRIMARY KEY (`customerID`,`deliveryID`,`targetID`),
  KEY `deliverycourier_idx` (`deliveryID`),
  KEY `targetcustomercourier_idx` (`targetID`),
  CONSTRAINT `customercourier` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `deliverycourier` FOREIGN KEY (`deliveryID`) REFERENCES `delivery` (`deliveryID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `targetcustomercourier` FOREIGN KEY (`targetID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courier`
--

LOCK TABLES `courier` WRITE;
/*!40000 ALTER TABLE `courier` DISABLE KEYS */;
INSERT INTO `courier` VALUES ('C-101','D-205','C-102');
/*!40000 ALTER TABLE `courier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custlogin`
--

DROP TABLE IF EXISTS `custlogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custlogin` (
  `customerID` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`customerID`,`username`,`password`),
  CONSTRAINT `custlogin` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custlogin`
--

LOCK TABLES `custlogin` WRITE;
/*!40000 ALTER TABLE `custlogin` DISABLE KEYS */;
INSERT INTO `custlogin` VALUES ('C-101','user1','root'),('C-102','john1','welcome'),('C-103','juhi','hello'),('C-104','smith','james');
/*!40000 ALTER TABLE `custlogin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customerID` varchar(45) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Street` varchar(45) NOT NULL,
  `City` varchar(45) NOT NULL,
  `Zip` int NOT NULL,
  PRIMARY KEY (`customerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('C-101','Vaibhav','Blvd','Houston',77057),('C-102','Juhi','Woodville','Houston',77077),('C-103','John','Eldridge','Austin',77023),('C-104','Smith','Willcrest','Houston',77067);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `deliveryID` varchar(45) NOT NULL,
  `time` time NOT NULL,
  `deliverytype` varchar(45) NOT NULL,
  `source` varchar(45) NOT NULL,
  `destination` varchar(45) NOT NULL,
  PRIMARY KEY (`deliveryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES ('D-201','12:34:00','mail','Houston','Destin'),('D-202','10:22:00','mail','Austin','Panama'),('D-203','10:44:00','Shop','Destin','Houston'),('D-204','12:34:00','Shop','Houston','Austin'),('D-205','12:34:00','shop','Houston','Clear Lake'),('D-207','20:06:03','shop','C-101','Houston'),('D-208','20:06:33','shop','C-101','Houston'),('D-210','20:07:57','shop','C-101','Houston'),('D-212','20:08:33','shop','C-101','Houston'),('D-213','00:15:45','shop','C-101','Houston');
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_schedule`
--

DROP TABLE IF EXISTS `delivery_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_schedule` (
  `deliveryID` varchar(45) NOT NULL,
  `trackingID` varchar(45) NOT NULL,
  `botID` varchar(45) NOT NULL,
  PRIMARY KEY (`deliveryID`,`trackingID`,`botID`),
  KEY `deliverschedule_idx` (`deliveryID`),
  KEY `deliverytracking_idx` (`trackingID`),
  KEY `deliverybot_idx` (`botID`),
  CONSTRAINT `deliverschedule` FOREIGN KEY (`deliveryID`) REFERENCES `delivery` (`deliveryID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `deliverybot` FOREIGN KEY (`botID`) REFERENCES `deliverybot` (`botID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `deliverytracking` FOREIGN KEY (`trackingID`) REFERENCES `tracking` (`trackingID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_schedule`
--

LOCK TABLES `delivery_schedule` WRITE;
/*!40000 ALTER TABLE `delivery_schedule` DISABLE KEYS */;
INSERT INTO `delivery_schedule` VALUES ('D-201','T-501','B-902'),('D-202','T-501','B-901'),('D-203','T-502','B-903'),('D-204','T-503','B-904');
/*!40000 ALTER TABLE `delivery_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliverybot`
--

DROP TABLE IF EXISTS `deliverybot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deliverybot` (
  `botID` varchar(45) NOT NULL,
  `availability` varchar(45) NOT NULL,
  `location` varchar(45) NOT NULL,
  PRIMARY KEY (`botID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliverybot`
--

LOCK TABLES `deliverybot` WRITE;
/*!40000 ALTER TABLE `deliverybot` DISABLE KEYS */;
INSERT INTO `deliverybot` VALUES ('B-901','Yes','Houston'),('B-902','Yes','Houston'),('B-903','No','Austin'),('B-904','No','Austin');
/*!40000 ALTER TABLE `deliverybot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `FID` varchar(45) NOT NULL,
  `OID` varchar(45) NOT NULL,
  `comment` varchar(45) NOT NULL,
  PRIMARY KEY (`FID`,`OID`),
  KEY `feedback_idx` (`OID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES ('F-331','D-203','Good'),('F-332','D-201','Excellent'),('F-333','D-204','Average'),('F-334','D-202','Poor');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitems` (
  `OID` varchar(45) NOT NULL,
  `customerID` varchar(45) NOT NULL,
  `productID` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `quantity` varchar(45) NOT NULL,
  `datetime` datetime NOT NULL,
  `paymentstatus` varchar(45) NOT NULL,
  PRIMARY KEY (`OID`,`customerID`,`productID`),
  KEY `customerorder_idx` (`customerID`),
  KEY `productorder_idx` (`productID`),
  CONSTRAINT `customerorder` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `productorder` FOREIGN KEY (`productID`) REFERENCES `products` (`productid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
INSERT INTO `orderitems` VALUES ('O-801','C-102','P-302','keyboard','4','2020-07-06 12:20:00','complete'),('O-802','C-102','P-305','mobile','2','2018-03-02 10:50:19','complete'),('O-803','C-103','P-301','mouse','2','2019-05-04 11:34:22','complete'),('O-804','C-101','P-303','printer','3','2018-03-02 10:45:09','Complete'),('O-806','C-104','P-304','monitor','1','2020-07-06 12:20:00','Complete'),('O-807','C-101','P-303','printer','1','2021-07-26 19:19:17','completed'),('O-808','C-101','P-303','printer','1','2021-07-26 23:54:35','completed'),('O-809','C-101','P-301','mouse','1','2021-07-27 00:15:15','completed');
/*!40000 ALTER TABLE `orderitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitems_delivery`
--

DROP TABLE IF EXISTS `orderitems_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitems_delivery` (
  `OID` varchar(45) NOT NULL,
  `deliveryID` varchar(45) NOT NULL,
  PRIMARY KEY (`OID`,`deliveryID`),
  KEY `orderdelivery_idx` (`deliveryID`),
  CONSTRAINT `OID` FOREIGN KEY (`OID`) REFERENCES `orderitems` (`OID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orderdelivery` FOREIGN KEY (`deliveryID`) REFERENCES `delivery` (`deliveryID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems_delivery`
--

LOCK TABLES `orderitems_delivery` WRITE;
/*!40000 ALTER TABLE `orderitems_delivery` DISABLE KEYS */;
INSERT INTO `orderitems_delivery` VALUES ('O-801','D-201'),('O-802','D-202'),('O-803','D-203'),('O-804','D-204');
/*!40000 ALTER TABLE `orderitems_delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `paymentID` varchar(45) NOT NULL,
  `customerID` varchar(45) NOT NULL,
  `Amount` int NOT NULL,
  `Cardno` int DEFAULT NULL,
  PRIMARY KEY (`paymentID`,`customerID`),
  KEY `paymentcustomer_idx` (`customerID`),
  CONSTRAINT `paymentcustomer` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES ('P-601','C-102',100,123234),('P-602','C-101',50,214214),('P-603','C-104',10,123424),('P-604','C-103',200,421321),('P-605','C-101',200,9999),('P-608','C-101',200,2),('P-609','C-101',100,2),('P-610','C-101',200,2),('P-611','C-101',100,5),('P-612','C-101',100,4),('P-614','C-101',106,45),('P-616','C-101',100,2),('P-617','C-101',0,2),('P-618','C-101',200,2),('P-620','C-101',100,2),('P-622','C-101',200,2),('P-623','C-101',106,2134);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_customer`
--

DROP TABLE IF EXISTS `phone_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phone_customer` (
  `phone` bigint NOT NULL,
  `customerID` varchar(45) NOT NULL,
  PRIMARY KEY (`phone`,`customerID`),
  KEY `custphone_idx` (`customerID`),
  CONSTRAINT `custphone` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_customer`
--

LOCK TABLES `phone_customer` WRITE;
/*!40000 ALTER TABLE `phone_customer` DISABLE KEYS */;
INSERT INTO `phone_customer` VALUES (8326785566,'C-101'),(8328896754,'C-102'),(6782289878,'C-103'),(2026673456,'C-104');
/*!40000 ALTER TABLE `phone_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_shops`
--

DROP TABLE IF EXISTS `product_shops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_shops` (
  `shopID` varchar(45) NOT NULL,
  `productID` varchar(45) NOT NULL,
  PRIMARY KEY (`shopID`,`productID`),
  KEY `shops_product_idx` (`shopID`),
  KEY `product_shops_idx` (`productID`),
  CONSTRAINT `product_shops` FOREIGN KEY (`productID`) REFERENCES `products` (`productid`),
  CONSTRAINT `shops_product` FOREIGN KEY (`shopID`) REFERENCES `shops` (`shopID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_shops`
--

LOCK TABLES `product_shops` WRITE;
/*!40000 ALTER TABLE `product_shops` DISABLE KEYS */;
INSERT INTO `product_shops` VALUES ('S-401','P-303'),('S-401','P-304'),('S-401','P-305'),('S-402','P-303'),('S-402','P-305'),('S-403','P-301'),('S-404','P-302');
/*!40000 ALTER TABLE `product_shops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `productid` varchar(45) NOT NULL,
  `pname` varchar(45) NOT NULL,
  `quantity` int NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`productid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('P-301','mouse',10,6),('P-302','keyboard',10,10),('P-303','printer',24,100),('P-304','monitor',12,200),('P-305','mobile',10,500),('P-306','Washing Machine',15,24);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shops`
--

DROP TABLE IF EXISTS `shops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shops` (
  `shopID` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `street` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `zip` varchar(45) NOT NULL,
  PRIMARY KEY (`shopID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shops`
--

LOCK TABLES `shops` WRITE;
/*!40000 ALTER TABLE `shops` DISABLE KEYS */;
INSERT INTO `shops` VALUES ('S-401','Gadget zone','Eldridge','Houston','77077'),('S-402','Techie spot','Kirkwood','Austin','77051'),('S-403','Every Gadget','Willcrest','Houston','77045'),('S-404','Pro tech gear','Fondren','Destin','77031');
/*!40000 ALTER TABLE `shops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopslogin`
--

DROP TABLE IF EXISTS `shopslogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopslogin` (
  `ShopID` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`ShopID`,`username`,`password`),
  CONSTRAINT `shopslogin` FOREIGN KEY (`ShopID`) REFERENCES `shops` (`shopID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopslogin`
--

LOCK TABLES `shopslogin` WRITE;
/*!40000 ALTER TABLE `shopslogin` DISABLE KEYS */;
INSERT INTO `shopslogin` VALUES ('S-401','electro','hello'),('S-402','techie','welcome'),('S-403','gadget','dnd'),('S-404','techgear','gear123');
/*!40000 ALTER TABLE `shopslogin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracking`
--

DROP TABLE IF EXISTS `tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tracking` (
  `trackingID` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL,
  `location` varchar(45) NOT NULL,
  PRIMARY KEY (`trackingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracking`
--

LOCK TABLES `tracking` WRITE;
/*!40000 ALTER TABLE `tracking` DISABLE KEYS */;
INSERT INTO `tracking` VALUES ('T-501','Delivered','Houston'),('T-502','Pending','Austin'),('T-503','Dispatched','California'),('T-504','Delivered','Houston');
/*!40000 ALTER TABLE `tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'delivery'
--

--
-- Dumping routines for database 'delivery'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-27  1:16:30
