-- MySQL dump 10.13  Distrib 8.4.2, for macos14 (arm64)
--
-- Host: localhost    Database: ecommerce_db
-- ------------------------------------------------------
-- Server version	8.4.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `articolo_carrello`
--

DROP TABLE IF EXISTS `articolo_carrello`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articolo_carrello` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_carrello` int DEFAULT NULL,
  `id_prodotto` int DEFAULT NULL,
  `quantita` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_carrello` (`id_carrello`),
  KEY `id_prodotto` (`id_prodotto`),
  CONSTRAINT `articolo_carrello_ibfk_1` FOREIGN KEY (`id_carrello`) REFERENCES `carrello` (`id`),
  CONSTRAINT `articolo_carrello_ibfk_2` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articolo_carrello`
--

LOCK TABLES `articolo_carrello` WRITE;
/*!40000 ALTER TABLE `articolo_carrello` DISABLE KEYS */;
INSERT INTO `articolo_carrello` VALUES (45,14,6,3);
/*!40000 ALTER TABLE `articolo_carrello` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articolo_ordine`
--

DROP TABLE IF EXISTS `articolo_ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articolo_ordine` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordine` int DEFAULT NULL,
  `id_prodotto` int DEFAULT NULL,
  `quantita` int NOT NULL,
  `prezzo` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_ordine` (`id_ordine`),
  KEY `id_prodotto` (`id_prodotto`),
  CONSTRAINT `articolo_ordine_ibfk_1` FOREIGN KEY (`id_ordine`) REFERENCES `ordine` (`id`),
  CONSTRAINT `articolo_ordine_ibfk_2` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articolo_ordine`
--

LOCK TABLES `articolo_ordine` WRITE;
/*!40000 ALTER TABLE `articolo_ordine` DISABLE KEYS */;
INSERT INTO `articolo_ordine` VALUES (1,9,5,10,499.99),(2,10,5,1,499.99),(3,11,7,1,649.99),(4,12,15,2,499.99),(5,13,11,3,799.99),(6,13,9,1,49.99);
/*!40000 ALTER TABLE `articolo_ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrello`
--

DROP TABLE IF EXISTS `carrello`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrello` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email_utente` varchar(100) DEFAULT NULL,
  `data_creazione` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `email_utente` (`email_utente`),
  CONSTRAINT `carrello_ibfk_1` FOREIGN KEY (`email_utente`) REFERENCES `utente` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrello`
--

LOCK TABLES `carrello` WRITE;
/*!40000 ALTER TABLE `carrello` DISABLE KEYS */;
INSERT INTO `carrello` VALUES (14,'1@gmail.com','2024-10-02 11:02:50'),(22,'abdessamad@gmail.com','2024-10-03 10:28:06');
/*!40000 ALTER TABLE `carrello` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon`
--

DROP TABLE IF EXISTS `coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codice` varchar(20) NOT NULL,
  `percentuale_sconto` decimal(5,2) NOT NULL,
  `valido_fino_a` date DEFAULT NULL,
  `attivo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon`
--

LOCK TABLES `coupon` WRITE;
/*!40000 ALTER TABLE `coupon` DISABLE KEYS */;
INSERT INTO `coupon` VALUES (1,'provacoupon',50.00,'2024-10-10',1),(2,'provacoupon2',90.00,'2024-10-10',1);
/*!40000 ALTER TABLE `coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon_ordine`
--

DROP TABLE IF EXISTS `coupon_ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_ordine` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordine` int DEFAULT NULL,
  `id_coupon` int DEFAULT NULL,
  `carrello_id` int DEFAULT NULL,
  `id_carrello` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_ordine` (`id_ordine`),
  KEY `id_coupon` (`id_coupon`),
  KEY `fk_carrello_id` (`carrello_id`),
  CONSTRAINT `coupon_ordine_ibfk_1` FOREIGN KEY (`id_ordine`) REFERENCES `ordine` (`id`),
  CONSTRAINT `coupon_ordine_ibfk_2` FOREIGN KEY (`id_coupon`) REFERENCES `coupon` (`id`),
  CONSTRAINT `fk_carrello_id` FOREIGN KEY (`carrello_id`) REFERENCES `carrello` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon_ordine`
--

LOCK TABLES `coupon_ordine` WRITE;
/*!40000 ALTER TABLE `coupon_ordine` DISABLE KEYS */;
INSERT INTO `coupon_ordine` VALUES (5,NULL,1,NULL,2),(8,NULL,1,NULL,6),(9,NULL,1,NULL,9),(10,NULL,1,NULL,12),(13,NULL,1,NULL,16),(14,NULL,1,NULL,17),(21,NULL,2,NULL,19),(22,NULL,2,NULL,20),(27,NULL,2,NULL,21);
/*!40000 ALTER TABLE `coupon_ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista_desideri`
--

DROP TABLE IF EXISTS `lista_desideri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lista_desideri` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email_utente` varchar(100) DEFAULT NULL,
  `id_prodotto` int DEFAULT NULL,
  `data_creazione` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `email_utente` (`email_utente`),
  KEY `id_prodotto` (`id_prodotto`),
  CONSTRAINT `lista_desideri_ibfk_1` FOREIGN KEY (`email_utente`) REFERENCES `utente` (`email`),
  CONSTRAINT `lista_desideri_ibfk_2` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista_desideri`
--

LOCK TABLES `lista_desideri` WRITE;
/*!40000 ALTER TABLE `lista_desideri` DISABLE KEYS */;
/*!40000 ALTER TABLE `lista_desideri` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordine` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email_utente` varchar(100) DEFAULT NULL,
  `totale` decimal(10,2) DEFAULT NULL,
  `stato_ordine` varchar(50) NOT NULL,
  `indirizzo_spedizione` text NOT NULL,
  `data_creazione` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `email_utente` (`email_utente`),
  CONSTRAINT `ordine_ibfk_1` FOREIGN KEY (`email_utente`) REFERENCES `utente` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordine`
--

LOCK TABLES `ordine` WRITE;
/*!40000 ALTER TABLE `ordine` DISABLE KEYS */;
INSERT INTO `ordine` VALUES (2,'1@gmail.com',1749.97,'In elaborazione','via fiesso 29','2024-10-02 10:37:45'),(3,'1@gmail.com',8999.70,'In elaborazione','via fiesso 29/2','2024-10-02 10:53:05'),(6,'1@gmail.com',974.99,'In elaborazione','prova spedizione','2024-10-02 11:00:40'),(7,'1@gmail.com',774.98,'In elaborazione','prova','2024-10-02 11:01:55'),(8,'abdessamad@gmail.com',6949.94,'In elaborazione','via fiesso 29/222222','2024-10-02 12:18:53'),(9,'abdessamad@gmail.com',2499.95,'In elaborazione','provaaaaaaa','2024-10-02 12:34:57'),(10,'abdessamad@gmail.com',499.99,'In elaborazione','prova','2024-10-02 13:05:12'),(11,'abdessamad@gmail.com',584.99,'In elaborazione','prova','2024-10-03 10:13:55'),(12,'abdessamad@gmail.com',899.98,'In elaborazione','prova','2024-10-03 10:15:37'),(13,'abdessamad@gmail.com',245.00,'In elaborazione','via fiesso 29/2','2024-10-03 10:26:20');
/*!40000 ALTER TABLE `ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descrizione` text,
  `prezzo` decimal(10,2) NOT NULL,
  `marchio` varchar(50) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `quantita_magazzino` int NOT NULL,
  `in_promozione` tinyint(1) DEFAULT '0',
  `image_url` varchar(2048) DEFAULT NULL,
  `bloccato` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES (5,'PlayStation 5','Console next-gen Sony, prova.',499.99,'Sony','console',1000,1,'',0),(6,'Nintendo Switch','Console portatile Nintendo',299.99,'Nintendo','console',38,1,NULL,0),(7,'Samsung TV 55\" 4K','Smart TV Samsung con risoluzione 4K',649.99,'Samsung','tv',24,1,NULL,0),(8,'HP Spectre x360','Laptop convertibile con schermo touch',1299.99,'HP','laptop',9,0,NULL,0),(9,'Amazon Echo Dot','Assistente vocale intelligente',49.99,'Amazon','smart home',59,1,NULL,0),(10,'Apple Watch Series 7','Smartwatch con funzionalità avanzate',399.99,'Apple','smartwatch',34,0,NULL,0),(11,'Smartphone Galaxy S21','Ultimo modello Samsung con tecnologia avanzata',799.99,'Samsung','smartphone',50,0,'https://images.samsung.com/is/image/samsung/p6pim/it/2202/gallery/it-galaxy-s21-5g-g991-sm-g991bzadeue-530448290?$650_519_PNG$',0),(12,'iPhone 13','Il nuovo iPhone con chip A15 Bionic',999.99,'Apple','smartphone',29,0,'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-13-mini-pink-select-2021?wid=940&hei=1112&fmt=png-alpha&.v=1629842709000',0),(13,'MacBook Pro 16\"','Potente laptop con chip M1 Pro',2399.99,'Apple','laptop',20,0,'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp16-spacegray-select-202110?wid=1808&hei=1686&fmt=jpeg&qlt=80&.v=1632788574000',0),(14,'Xiaomi Mi Band 6','Smartband con schermo AMOLED e durata batteria di 14 giorni',49.99,'Xiaomi','smartwatch',100,1,'https://i01.appmifile.com/webfile/globalimg/products/pc/mi-band-6/specs01.png',0),(15,'PlayStation 5','Console di nuova generazione con grafica 4K',499.99,'Sony','console',15,0,'https://m.media-amazon.com/images/I/619BkvKW35L._AC_SL1500_.jpg',0),(16,'Nintendo Switch','Console ibrida per giocare in movimento',299.99,'Nintendo','console',40,1,'https://m.media-amazon.com/images/I/61-PblYntsL._AC_SL1500_.jpg',0),(17,'Samsung TV 55\" 4K','Smart TV Samsung con risoluzione 4K e HDR',649.99,'Samsung','tv',25,1,'https://images.samsung.com/is/image/samsung/uk-uhd-tu7020-ue55tu7020kxxu-frontblack-228652693?$684_547_PNG$',0),(18,'HP Spectre x360','Laptop convertibile con schermo touch e design elegante',1299.99,'HP','laptop',10,0,'https://ssl-product-images.www8-hp.com/digmedialib/prodimg/lowres/c06630845.png',0),(19,'Amazon Echo Dot','Assistente vocale intelligente con Alexa',49.99,'Amazon','smart home',60,1,'https://m.media-amazon.com/images/I/61+q4LZLLxL._AC_SL1000_.jpg',0),(20,'Apple Watch Series 7','Smartwatch con funzioni di salute avanzate',399.99,'Apple','smartwatch',35,0,'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/ML7J3_VW_34FR+watch-45-alum-green-cell-7s_VW_34FR_WF_CO?wid=1000&hei=1000&fmt=jpeg&qlt=95&.v=1632171069000',0),(21,'prova','111',1000.00,'abdessamad','abdessamad',1,0,'',0);
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracciamento_ordine`
--

DROP TABLE IF EXISTS `tracciamento_ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tracciamento_ordine` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordine` int DEFAULT NULL,
  `stato` varchar(50) NOT NULL,
  `data_aggiornamento` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_ordine` (`id_ordine`),
  CONSTRAINT `tracciamento_ordine_ibfk_1` FOREIGN KEY (`id_ordine`) REFERENCES `ordine` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracciamento_ordine`
--

LOCK TABLES `tracciamento_ordine` WRITE;
/*!40000 ALTER TABLE `tracciamento_ordine` DISABLE KEYS */;
INSERT INTO `tracciamento_ordine` VALUES (2,2,'Ordine Confermato','2024-10-02 10:37:45'),(3,3,'Ordine Confermato','2024-10-02 10:53:05'),(6,6,'Ordine Confermato','2024-10-02 11:00:40'),(7,7,'Ordine Confermato','2024-10-02 11:01:55'),(8,8,'Ordine Confermato','2024-10-02 12:18:53'),(9,9,'Ordine Confermato','2024-10-02 12:34:57'),(10,10,'Ordine Confermato','2024-10-02 13:05:12'),(11,11,'Ordine Confermato','2024-10-03 10:13:55'),(12,12,'Ordine Confermato','2024-10-03 10:15:37'),(13,13,'Ordine Confermato','2024-10-03 10:26:20');
/*!40000 ALTER TABLE `tracciamento_ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utente` (
  `email` varchar(100) NOT NULL,
  `nome_utente` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `ruolo` varchar(20) NOT NULL,
  `data_creazione` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `bloccato` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente`
--

LOCK TABLES `utente` WRITE;
/*!40000 ALTER TABLE `utente` DISABLE KEYS */;
INSERT INTO `utente` VALUES ('1@gmail.com','1','$2a$10$tzq0.DWI49yv/5ZWAd5mWeRQ6gE2TtCxY86JQ5n8vRTkSjBJ0wpxO','ADMIN','2024-09-29 10:56:24',0),('abdessamad@gmail.com','abdessamad','$2a$10$W1Yomm/P.ojkZLORqGwJqObOVJj/Sicrkv9gLXjk2iI/IAJ4y.0AK','ADMIN','2024-10-02 07:56:26',0);
/*!40000 ALTER TABLE `utente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-03 18:04:48
