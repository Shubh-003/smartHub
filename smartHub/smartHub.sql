-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: smarthub
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  `mrp` decimal(10,2) NOT NULL,
  `discount_price` decimal(10,2) NOT NULL,
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `registration` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`prodId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (8,35,3,1,200000.00,160000.00,'2025-10-13 05:12:55'),(16,37,28,1,3500.00,3500.00,'2025-10-22 13:08:01');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `discount_name` varchar(100) NOT NULL,
  `product_category` varchar(50) NOT NULL,
  `discount_percent` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
INSERT INTO `discounts` VALUES (7,'Winter Sale','Smartphones',20,'2025-10-02','2025-10-14','Active'),(8,'Monsson Sale','Smartphones',20,'2025-08-12','2025-09-18','Expired'),(10,'Diwali Sale','Smartphones',30,'2025-10-14','2025-10-30','Active'),(11,'HDFC bank','Smartphones',10,'2025-11-01','2026-12-30','Upcoming'),(12,'HDFC bank','Smartwatch',10,'2025-11-01','2026-12-26','Upcoming');
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offers` (
  `offer_id` int NOT NULL AUTO_INCREMENT,
  `offer_name` varchar(100) NOT NULL,
  `prod_category` varchar(45) DEFAULT NULL,
  `discount_percent` decimal(10,0) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`offer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  `mrp` decimal(10,2) NOT NULL,
  `discount_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`prodId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,3,1,200000.00,160000.00,160000.00),(2,1,23,2,3000.00,3000.00,6000.00),(3,2,19,2,129999.00,103999.20,207998.40),(4,2,23,2,3000.00,3000.00,6000.00),(5,3,23,1,3000.00,3000.00,3000.00),(6,4,19,1,129999.00,103999.20,103999.20),(7,5,23,1,3000.00,3000.00,3000.00),(8,6,19,1,129999.00,103999.20,103999.20),(9,7,19,2,129999.00,90999.30,181998.60),(10,8,32,1,15000.00,15000.00,15000.00),(11,8,21,1,60999.00,42699.30,42699.30);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `discount_amount` decimal(10,2) DEFAULT '0.00',
  `final_amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `payment_status` enum('Pending','Paid','Failed') DEFAULT 'Pending',
  `order_status` enum('Processing','Shipped','Delivered','Cancelled') DEFAULT 'Processing',
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('Pending','Processing','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `registration` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,34,40000.00,166000.00,'card','Pending','Delivered','2025-10-12 12:00:14',206000.00,'Pending'),(2,33,51999.60,213998.40,'Cash On Delivery','Paid','Delivered','2025-10-12 12:14:16',265998.00,'Pending'),(3,35,0.00,3000.00,'Cash On Delivery','Pending','Processing','2025-10-13 05:04:22',3000.00,'Pending'),(4,35,25999.80,103999.20,'Cash On Delivery','Pending','Cancelled','2025-10-13 05:06:44',129999.00,'Pending'),(5,33,0.00,3000.00,'Cash On Delivery','Pending','Processing','2025-10-13 10:02:05',3000.00,'Pending'),(6,33,25999.80,103999.20,'Credit Card','Paid','Processing','2025-10-14 09:11:27',129999.00,'Pending'),(7,36,77999.40,181998.60,'Cash On Delivery','Paid','Delivered','2025-10-15 04:12:36',259998.00,'Pending'),(8,37,18299.70,57699.30,'Cash On Delivery','Pending','Shipped','2025-10-22 13:07:40',75999.00,'Pending');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `prodId` int NOT NULL AUTO_INCREMENT,
  `prod_category` varchar(100) DEFAULT NULL,
  `prod_name` varchar(100) NOT NULL,
  `prod_img` varchar(400) DEFAULT NULL,
  `prod_desc` varchar(300) DEFAULT NULL,
  `prod_mrp` decimal(10,0) DEFAULT NULL,
  `prod_stock` int DEFAULT '0',
  `prod_storage` json DEFAULT NULL,
  `prod_colour` json DEFAULT NULL,
  PRIMARY KEY (`prodId`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (3,'Smartphones','Samsung galaxy fold 2','uploads/Samsung_Galaxy_Z_Fold7.png','Snapdragon 865+ | 6.2-inch display',200000,200,'[\"500 GB | 12 GB\", \"512 GB | 12 GB\"]','[\"black\", \"blue\"]'),(19,'Smartphones','iPhone 15 Pro','uploads/iphone14.png','256GB | A17 Pro | 6.1\"',129999,30,'[\"515\", \"256\"]','[\"Gold\", \"silver\"]'),(21,'Smartphones','OnePlus 9','uploads/13R-Trail.png',' Snapdragon 7 | 256GB | 6.1\"',60999,20,'[\"256\", \"120\"]','[\"Black\", \"silver\"]'),(23,'Accessories','Flash charger','uploads/charger (1).png','28W fast charger | Black',3000,10,'[]','[\"Balck\"]'),(27,'Smartphones','One plus 11','uploads/onepuls11.png','SnapdragonÂ® 8 Gen 2 | 100W Fast Charging | AMOLED display',40000,50,'[\"128\", \"256\"]','[\"Black\"]'),(28,'Audio Device','Sony WH-1000 XM5 ','uploads/sony.png','Noise-cancellion | Up to 30h battery',3500,10,'[]','[\"black\"]'),(29,'Audio Device','AirPods Max','uploads/airpods pro.png','2x Apple H1 | 40 mm dynamic driver | USB-C |  20 hours of playback',59900,10,'[]','[\"black\"]'),(30,'Accessories','Samsung 30w Fast Charger','uploads/61x9NX5w4ML.png','30w fast charger | C Type',3000,20,'[]','[\"black\"]'),(32,'Smartwatch','Apple Watch S8','uploads/Apple-Watch-S8-stainless-steel-graphite-220907_inline.jpg.large_2x.png','Crash Detection | GPS | Metallic body',15000,20,'[]','[\"black\"]');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(45) DEFAULT NULL,
  `userEmail` varchar(45) NOT NULL,
  `userPassword` varchar(100) NOT NULL,
  `userPhone` varchar(15) DEFAULT NULL,
  `userAddress` text,
  `userCity` varchar(50) DEFAULT NULL,
  `userState` varchar(50) DEFAULT NULL,
  `userPincode` varchar(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` VALUES (33,'Shivani Jadhav','shivani2@gmail.com','123','90214 51447','Lane no. 1, Tapodham, Ganapati mandir','Pune','Maharashtra','411058','2025-10-09 16:58:38'),(34,'Tony Stark','tony@gmail.com','123','90214 51447','Lane no. 1, Tapodham, Ganapati mandir','Pune','Maharashtra','411058','2025-10-12 11:16:10'),(35,'Pawan Landge','shivani2@gmail.com','123','90214 51447','Lane no. 1, Tapodham, Ganapati mandir','Pune','Maharashtra','411058','2025-10-13 05:02:11'),(36,'xyz aa','shivani2@gmail.com','123','90214 51447','Lane no. 1, Tapodham, Ganapati mandir','Pune','Maharashtra','411058','2025-10-15 04:11:35'),(37,'Encrypt  Singh','encrypt1@gmail.com','$2a$12$aOjvvDNFnHxF60QhfXjAmue7oICwjohY3vbcUffeasXG1Z6kHsK66','90214 51447','Lane no. 1, RK, Ganapati mandir','Nashik','Maharashtra','421018','2025-10-22 08:24:51');
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` text,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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

-- Dump completed on 2025-10-22 22:17:12
