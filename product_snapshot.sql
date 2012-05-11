-- MySQL dump 10.13  Distrib 5.1.49, for apple-darwin10.3.0 (i386)
--
-- Host: localhost    Database: faucetcentral
-- ------------------------------------------------------
-- Server version	5.1.49

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart_products`
--

DROP TABLE IF EXISTS `cart_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cart_products_on_cart_id` (`cart_id`)
) ENGINE=InnoDB AUTO_INCREMENT=431 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_products`
--

LOCK TABLES `cart_products` WRITE;
/*!40000 ALTER TABLE `cart_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `session_id` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `index_carts_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=312 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (311,325,'2012-05-11 23:26:41','2012-05-11 23:26:41','');
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_categories_on_name_and_parent_id` (`name`,`parent_id`),
  KEY `index_categories_on_parent_id_and_name` (`parent_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1500 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (125,'locks',517,'2010-09-05 00:19:46','2010-09-19 00:23:20'),(127,'hardware',125,'2010-09-05 00:20:22','2010-09-14 08:53:09'),(265,'electronics',517,'2010-09-05 23:32:40','2010-09-19 00:23:21'),(272,'notebooks',127,'2010-09-05 23:34:43','2010-09-14 08:53:10'),(274,'televisions',265,'2010-09-05 23:36:18','2010-09-14 08:53:10'),(517,'all',0,'2010-09-19 00:19:42','2010-09-19 00:24:13'),(531,'videogame-software',517,'2010-11-19 19:15:34','2010-11-21 07:14:24'),(564,'ps3-games',531,'2010-11-19 20:11:14','2010-11-19 20:11:14'),(567,'xbox-360-games',531,'2010-11-19 20:11:53','2010-11-19 20:11:53');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_cards`
--

DROP TABLE IF EXISTS `credit_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `verification_value` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT '5305148831',
  `address` varchar(255) DEFAULT '',
  `city` varchar(255) DEFAULT '',
  `state` varchar(255) DEFAULT '',
  `zip` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `index_credit_cards_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_cards`
--

LOCK TABLES `credit_cards` WRITE;
/*!40000 ALTER TABLE `credit_cards` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dandh_products`
--

DROP TABLE IF EXISTS `dandh_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dandh_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '',
  `marketing_description` text,
  `tech_description` text,
  `manufacturer_url` varchar(255) DEFAULT '',
  `warranty_length` varchar(255) DEFAULT '',
  `dandh_item_number` varchar(255) DEFAULT '',
  `vendor_part_number` varchar(255) DEFAULT '',
  `upc_code` varchar(255) DEFAULT '',
  `weight` float DEFAULT '0',
  `msrp` float DEFAULT '0',
  `reseller_price` float DEFAULT '0',
  `dandh_whs` varchar(255) DEFAULT '',
  `visalia_whs` varchar(255) DEFAULT '',
  `vendor_name` varchar(255) DEFAULT '',
  `category` varchar(255) DEFAULT '',
  `subcategory` varchar(255) DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8990 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dandh_products`
--

LOCK TABLES `dandh_products` WRITE;
/*!40000 ALTER TABLE `dandh_products` DISABLE KEYS */;
INSERT INTO `dandh_products` VALUES (1,'Verbatim Wireless Slim Keyboard and Mouse with Volume Wheel','Wireless Slim Keyboard features an integrated volume control wheel to allow easy volume control and 16 hot keys for Media Play, Internet browsing and PC functions. The Media Player functions include stop, play/pause, previous, next, volume mute. Internet browser functions are refresh, stop, back, forward, home, and My Favorites. PC functions include open mail client, hibernate/sleep, search, My Computer, My Documents and calculator. Ultra-slim keyboard includes a wireless mouse. System requirements include Windows XP, Windows 2000 or Windows Vista.','Wireless Keyboard/Mouse Blk<br>Keyboard - Wireless - English (US) - Mouse - Wireless','www.verbatim.com','Â 1 YEAR','VER96666','96666','023942966661',2.6,78,44.12,'YES','YES','Verbatim/Smartdisk','Input Devices-Wireless','Bundle- Keyboard & Mouse','2010-11-19 19:12:30','2010-11-19 19:12:30'),(2,'Seiko SmartLabel SLP-2RL Address Label','These White standard address Labels are general purpose labels for envelopes, packages, file folders and countless other uses.  Seiko Instruments SmartLabels are available in a variety of sizes, types and styles so you can label just about anything! There are labels for floppy disks, video cassettes, name tags, 35mm slides, and more.','Address Lables 130/Roll<br>1.12\" Width x 3.5\" Length - 130/Roll - 0.79\" Core - 2 / Roll - White','www.seikoinstruments.com','Â NONE','SLP2RL','SLP-2RL','020963210025',0.3,13.35,7.18,'YES','YES','Seiko Instruments','Paper','Labels','2010-11-19 19:15:10','2010-11-19 19:15:10'),(3,'Fedco ENERGY+ Lithium Ion Notebook Battery','This is a 6 cell Lithium Ion rechargeable intelligent battery pack for select models of Toshiba Satellite &amp; Tecra series notebooks. This battery ships fully charged, tested and ready to work. This ENERGY+ item is built with the highest quality standards and safety features.','Battery Toshiba<br>Lithium Ion (Li-Ion) - 4800mAh - 14.8V DC','www.fedcoelectronics.com','Â 1 YEAR','PA3420U1BRS1','PA3420U1BRS1','752570054050',1.25,149,114.91,'NO','NO','Fedco Electronics','Computers Notebooks','Batteries for Notebooks','2010-11-19 19:15:14','2010-11-19 19:15:14'),(4,'BTI Lithium Ion Notebook Battery','','Lenovo 3000 11.1V  4800m<br>Lithium Ion (Li-Ion) - 11.1V DC','www.batterytech.com','Â 18 Months','LNV100H','LN-V100H','745473117229',0.95,109.99,86.18,'YES','YES','BTI- Battery Tech.','Computers Notebooks','Batteries for Notebooks','2010-11-19 19:15:17','2010-11-19 19:15:17'),(5,'Brother HL-4570CDWT Laser Printer - Color - Plain Paper Print - Desktop','Large paper capacity, high-speed printing and long-lasting supplies: the HL-4570CDWT offers you professional performance and exceedingly low running costs. A combination that makes perfect business sense: the HL-4570CDWT offers exceedingly fast, efficient mono and colour print speeds of 28 pages per minute. Coupled with a very large paper supply of 800 sheets from three separate trays, this makes for low maintenance and helps you significantly increase productivity in your office.','Color Laser Printer<br>28 ppm Mono - 28 ppm Color - 2400 x 600 dpi - 128 MB - 800 sheets (Input Capacity) - USB, USB - Fast Ethernet, Wi-Fi - PC, Mac','www.brother-usa.com','Â 1 YEAR On-Site','HL4570CDWT','HL-4570CDWT','012502625339',59.5,949.99,568.4,'YES','YES','Brother International','Printers- Laser','Laser Printers- Color','2010-11-19 19:15:21','2010-11-19 19:15:21'),(6,'Canon 20 Black Toner Cartridge','     ','Toner Cart-PC300/400 COP<br>Laser - 2000 Page - Black','www.usa.canon.com','Â NONE','E20','1492A002AA','030275488098',2.3,115.99,86.18,'YES','YES','Canon USA','Printers- MFC/Copiers','Toner Cartridges','2010-11-19 19:15:25','2010-11-19 19:15:25'),(7,'Intel Core i7 i7-840QM 1.86 GHz Processor - Quad-core','With faster, intelligent, multi-core technology that applies processing power where it\'s needed most, Intel Core i7 processors deliver an incredible breakthrough in PC performance. They are the best desktop processor family on the planet.','Core I7-840QM 1.86 GHZ<br>1 MB L2 - 8 MB L3 - Socket PGA-988','www.intel.com','Â 3 YEARS','BX80607I7840QM','BX80607I7840QM','675901044769',0.15,666,588.92,'YES','YES','Intel Corp.','CPUs','Mobile CPUs','2010-11-19 19:15:28','2010-11-19 19:15:28'),(8,'Logitech M310 Mouse Wireless - Blue','The easy-to-use mouse that feels just right.<b>In good shape</b><br> Left-handed or right, you\'ll be comfortable with this contoured design with soft rubber side grips.<b>Plug and forget</b><br> The wireless, USB nano-receiver is always ready for use. Plug it in once and forget about it.<b>Power-packed</b><br> With 12 months of battery life, you don\'t have to deal with the hassle of frequent battery changes.','Wireless Mouse M310 PEACK BLUE<br>Radio Frequency - USB - Scroll Wheel','www.logitech.com','Â 1 YEAR','910001917','910-001917','097855067876',0.45,29.99,24.62,'YES','YES','Logitech Inc','Input Devices-Wireless','Mice- Wireless','2010-11-19 19:15:31','2010-11-19 19:15:31'),(9,'Take-Two Sid Meier\'s Pirates!','All hands on deck! Exclusively for Wii, Sid Meier\'s Pirates! is an exciting high-seas adventure that allows junior buccaneers to helm one of 27 fully customizable ships as they descend upon unsuspecting ports of call to amass a motley crew of seafaring bandits. As the fearless Pirate Captain, players will collect hidden treasure maps, undertake daring missions and courageous rescues, and swiftly hand out pirate-style justice to local braggarts at every port. The wild call of the ocean will lure them back to sea where they\'ll encounter enemy pirates and engage in mind-blowing open sea battles unlike any other game before on Wii.','Sid Meier\'s Pirates! Wii<br>Action/Adventure Game - Complete Product - Standard - 1 User - Retail - Wii','www.take2games.com','Â 30 DAYS','34869','34869','710425348693',0.15,39.99,34.88,'YES','YES','Take-Two','Videogame Software','Wii Games','2010-11-19 19:15:34','2010-11-19 19:15:34'),(10,'snom DECT repeater','','snom DECT repeater<br>Works in accordance with the DECT standard. Doubles the range of the snom m3 by two internal antennas Registering up to six snom DECT repeaters on one base station. plug-and-play installation','','Â 1 YEAR','00001713','00001713','811819010520',0.65,149,101.57,'YES','YES','SNOM Technology','VoIP','SIP IP Phones','2010-11-19 19:15:38','2010-11-19 19:15:38');
/*!40000 ALTER TABLE `dandh_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dsdi_products`
--

DROP TABLE IF EXISTS `dsdi_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dsdi_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) DEFAULT '',
  `model` varchar(255) DEFAULT '',
  `manufacturers_name` varchar(255) DEFAULT '',
  `vendor_product_id` int(11) DEFAULT '0',
  `name` varchar(255) DEFAULT '',
  `description` text,
  `quantity` float DEFAULT '0',
  `category` varchar(255) DEFAULT '',
  `master_category` varchar(255) DEFAULT '',
  `product_added` datetime DEFAULT NULL,
  `important_notes` varchar(255) DEFAULT '',
  `images_path` varchar(255) DEFAULT '',
  `reseller_price` float DEFAULT '0',
  `msrp` float DEFAULT '0',
  `ship_price` float DEFAULT '0',
  `ship_method` varchar(255) DEFAULT '',
  `weight` float DEFAULT '0',
  `map` varchar(255) DEFAULT '',
  `map_price` varchar(255) DEFAULT '',
  `product_specs` text,
  `product_image` varchar(255) DEFAULT '',
  `ship_eta` varchar(255) DEFAULT '',
  `ship_exception` varchar(255) DEFAULT '',
  `quick_ship` varchar(255) DEFAULT '',
  `product_warranty` varchar(255) DEFAULT '',
  `product_refunds` varchar(255) DEFAULT '',
  `zipcode` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_dsdi_products_on_name` (`name`),
  KEY `index_dsdi_products_on_dsdi_product_id` (`vendor_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52505 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dsdi_products`
--

LOCK TABLES `dsdi_products` WRITE;
/*!40000 ALTER TABLE `dsdi_products` DISABLE KEYS */;
INSERT INTO `dsdi_products` VALUES (1,'DSD103707','WPR-636W','BushRag',7802,'Predator Face Veil Woodland',NULL,5,'Camo/Ghillie','Outdoors','2004-08-24 02:40:16','','sports/outdoors/camo_ghillie/',12.36,18.97,0,'UPS RATES',3,'Yes','13.11','No additional specifications are available at this time.','27-171-244-103707.jpg','','','no','','yes','97367'),(2,'DSD420409','7215','Century',28366,'Combo Lantern & Case',NULL,49,'Lanterns','Camping','2006-05-23 17:00:20','','sports/outdoors/camping/lanterns/',27.97,44.99,0,'UPS RATES',4,'No','NA',' ','27-171-296-420409.jpg','','','no','','yes','97367'),(3,'DSD105173','WSW-221W','BushRag',8022,'Snipers Web - Hunters Blind and Cloak Woodland',NULL,2,'Hunting Blinds','Hunting','2004-10-13 04:20:44','','sports/hunting/hunting_blinds/',44.58,84.97,0,'UPS RATES',4,'Yes','58.212','No additional specifications are available at this time.','DSD105173-2.jpg','','','no','','yes','97367'),(4,'DSD105176','WSV-816W','BushRag',8025,'Sniper Veil Woodland',NULL,6,'Camo/Ghillie','Outdoors','2004-10-13 04:28:46','','sports/outdoors/camo_ghillie/',8.2,9.97,0,'UPS RATES',2,'No','NA','No additional specifications are available at this time.','27-171-244-105176.jpg','','','yes','','yes','97367'),(5,'DSD105178','BP-144','BushRag',8027,'Bush Patch',NULL,3,'Camo/Ghillie','Outdoors','2004-10-13 04:34:19','','sports/outdoors/camo_ghillie/',8.2,13.97,0,'UPS RATES',2,'Yes','9.77','Patches are 2\" x 2\" squares','27-171-244-105178.jpg','','','no','','yes','97367'),(6,'DSD400569','S','GhillieSuits',8524,'Stalker Ghillie Poncho',NULL,44,'Camo/Ghillie','Outdoors','2005-01-17 20:50:36','','sports/outdoors/camo_ghillie/',105.6,160,0,'UPS RATES',8,'No','NA','No additional specifications are available at this time.','27-171-336-400569.jpg','','','no','','yes','97367'),(7,'DSD400572','BP34','GhillieSuits',8527,'Ghillie Back Pack Cover 3x4',NULL,63,'Camo/Ghillie','Outdoors','2005-01-17 22:04:37','','sports/outdoors/camo_ghillie/',40.81,77,0,'UPS RATES',5,'No','NA','No additional specifications are available at this time.','27-171-336-400572.jpg','','','no','','yes','97367'),(8,'DSD400570','T','GhillieSuits',8525,'Tracker Ghillie Poncho',NULL,43,'Camo/Ghillie','Outdoors','2005-01-17 21:08:44','','sports/outdoors/camo_ghillie/',68.64,104,0,'UPS RATES',6,'No','NA','No additional specifications are available at this time.','27-171-336-400570.jpg','','','no','','yes','97367'),(9,'DSD400571','BP46','GhillieSuits',8526,'Ghillie Blanket Cover 4x6',NULL,55,'Camo/Ghillie','Outdoors','2005-01-17 21:55:21','','sports/outdoors/camo_ghillie/',78.97,149,0,'UPS RATES',6,'No','NA','No additional specifications are available at this time.','27-171-336-400571.jpg','','','no','','yes','97367'),(10,'DSD400573','BP23','GhillieSuits',8528,'Ghillie Back Pack/Veil 2x3',NULL,36,'Camo/Ghillie','Outdoors','2005-01-17 22:13:25','','sports/outdoors/camo_ghillie/',15.9,30,0,'UPS RATES',3,'No','NA','No additional specifications are available at this time.','27-171-336-400573.jpg','','','no','','yes','97367');
/*!40000 ALTER TABLE `dsdi_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingram_micro_products`
--

DROP TABLE IF EXISTS `ingram_micro_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingram_micro_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spex_essential_product_id` int(11) NOT NULL,
  `action_indicator` varchar(255) DEFAULT '',
  `ingram_sku` varchar(255) DEFAULT '',
  `vendor_number` varchar(255) DEFAULT '',
  `vendor_name` varchar(255) DEFAULT '',
  `part_description_1` varchar(255) DEFAULT '',
  `part_description_2` varchar(255) DEFAULT '',
  `retail_price` float DEFAULT '0',
  `vendor_part_number` varchar(255) DEFAULT '',
  `weight` float DEFAULT '0',
  `upc_code` varchar(255) DEFAULT '',
  `legnth` float DEFAULT '0',
  `width` float DEFAULT '0',
  `price_change_flag` varchar(255) DEFAULT '',
  `customer_price` float DEFAULT '0',
  `special_price_flag` float DEFAULT '0',
  `availability_flag` varchar(255) DEFAULT '',
  `sku_status` varchar(255) DEFAULT '',
  `alliance_flag` varchar(255) DEFAULT '',
  `cpu_code` varchar(255) DEFAULT '',
  `media_type` varchar(255) DEFAULT '',
  `ingram_category` varchar(255) DEFAULT '',
  `new_item_receipt_flag` varchar(255) DEFAULT '',
  `instant_rebate_flag` varchar(255) DEFAULT '',
  `restricted_flag` varchar(255) DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_ingram_micro_products_on_spex_essential_product_id` (`spex_essential_product_id`),
  UNIQUE KEY `index_ingram_micro_products_on_ingram_sku` (`ingram_sku`)
) ENGINE=InnoDB AUTO_INCREMENT=129468 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingram_micro_products`
--

LOCK TABLES `ingram_micro_products` WRITE;
/*!40000 ALTER TABLE `ingram_micro_products` DISABLE KEYS */;
INSERT INTO `ingram_micro_products` VALUES (1,649959,'A','BA0011','U206','OPEN VALUE SUBSCRIPTION','1YR OFFICESTD ALNG LICSAPK OLV','D AP',149,'021-09108',0,'',0,0,'0000.00',NULL,118.5,'S','N','','INT-SW','SLIC','1539','','N','','2010-12-26 09:01:13','2010-12-26 09:01:13'),(2,649960,'A','BA0013','U206','OPEN VALUE SUBSCRIPTION','1YR OFFICESTD ALNG LICSAPK OLV','C AP',183,'021-09202',0,'',0,0,'0000.00',NULL,144.16,'S','N','','INT-SW','SLIC','1539','','N','','2010-12-26 09:01:15','2010-12-26 09:01:15'),(3,649961,'A','BA0025','U206','OPEN VALUE SUBSCRIPTION','1YR WORD ALNG LICSAPK OLV D AP','',85,'059-07014',0,'',0,0,'0000.00',NULL,57.89,'S','N','','WP-SW','SLIC','1539','','N','','2010-12-26 09:01:15','2010-12-26 09:01:15'),(4,649962,'A','BA0027','U206','OPEN VALUE SUBSCRIPTION','1YR WORD ALNG LICSAPK OLV C AP','',104,'059-07527',0,'',0,0,'0000.00',NULL,71.09,'S','N','','WP-SW','SLIC','1539','','N','','2010-12-26 09:01:15','2010-12-26 09:01:15'),(5,650290,'A','BA0039','U206','OPEN VALUE SUBSCRIPTION','1YR EXCEL ALNG LICSAPK OLV D AP','',85,'065-06444',0,'',0,0,'0000.00',NULL,57.89,'S','N','','SS-SW','SLIC','1539','','N','','2010-12-26 09:01:15','2010-12-26 09:01:15'),(6,649963,'A','BA0041','U206','OPEN VALUE SUBSCRIPTION','1YR EXCEL ALNG LICSAPK OLV C AP','',104,'065-06861',0,'',0,0,'0000.00',NULL,71.09,'S','N','','SS-SW','SLIC','1539','','N','','2010-12-26 09:01:15','2010-12-26 09:01:15'),(7,649964,'A','BA0049','U206','OPEN VALUE SUBSCRIPTION','1YR WORKS ALNG LICSAPK OLV D AP','',12,'070-04445',0,'',0,0,'0000.00',NULL,9.46,'S','N','','INT-SW','SLIC','1539','','N','','2010-12-26 09:01:15','2010-12-26 09:01:15'),(8,649965,'A','BA0054','U206','OPEN VALUE SUBSCRIPTION','WORKS 9.0 ALNG OLV D EACH AP','',21,'070-04451',0,'',0,0,'0000.00',NULL,16.56,'S','N','','INT-SW','VLIC','1539','','N','','2010-12-26 09:01:16','2010-12-26 09:01:16'),(9,649966,'A','BA0055','U206','OPEN VALUE SUBSCRIPTION','1YR WORKS ALNG LICSAPK OLV C AP','',15,'070-05434',0,'',0,0,'0000.00',NULL,11.58,'S','N','','INT-SW','SLIC','1539','','N','','2010-12-26 09:01:16','2010-12-26 09:01:16'),(10,649967,'A','BA0056','U206','OPEN VALUE SUBSCRIPTION','WORKS 9.0 ALNG OLV C EACH AP','',26,'070-05451',0,'',0,0,'0000.00',NULL,20.42,'S','N','','INT-SW','VLIC','1539','','N','','2010-12-26 09:01:16','2010-12-26 09:01:16');
/*!40000 ALTER TABLE `ingram_micro_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_products`
--

DROP TABLE IF EXISTS `order_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_order_products_on_order_id` (`order_id`),
  KEY `index_order_products_on_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_products`
--

LOCK TABLES `order_products` WRITE;
/*!40000 ALTER TABLE `order_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `shipping_address_id` int(11) DEFAULT NULL,
  `credit_card_id` int(11) DEFAULT NULL,
  `tax_cost` float DEFAULT NULL,
  `shipping_cost` float DEFAULT NULL,
  `subtotal` float DEFAULT NULL,
  `total_cost` float DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `transaction_number` varchar(255) DEFAULT '',
  `tracking_number` varchar(255) DEFAULT '',
  `tracking_type` varchar(255) DEFAULT '',
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `index_orders_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) DEFAULT NULL,
  `content_type` varchar(255) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT '0',
  `thumbnail` tinyint(1) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `hero` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_product_images_on_product_id_and_parent_id` (`product_id`,`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=235710 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (222263,'185162-lenovo-thinkpad-w500-notebook-core-2-duo-t9600-2-8ghz-15-4-black-intel-core-2-duo-t9600-2-8ghz-15-4-wuxga-2gb-ddr3-sdram-160gb-hdd-dvd-writer-wi-fi-gigabit-ethernet-bluetooth-windows-xp-p-x300.jpg','.jpg',185162,0,0,300,'2010-12-27 12:19:29','2010-12-27 12:19:29',0),(222264,'185162-lenovo-thinkpad-w500-notebook-core-2-duo-t9600-2-8ghz-15-4-black-intel-core-2-duo-t9600-2-8ghz-15-4-wuxga-2gb-ddr3-sdram-160gb-hdd-dvd-writer-wi-fi-gigabit-ethernet-bluetooth-windows-xp-p-x150.jpg','.jpg',185162,222263,1,150,'2010-12-27 12:19:29','2010-12-27 12:19:29',0),(222265,'185162-lenovo-thinkpad-w500-notebook-core-2-duo-t9600-2-8ghz-15-4-black-intel-core-2-duo-t9600-2-8ghz-15-4-wuxga-2gb-ddr3-sdram-160gb-hdd-dvd-writer-wi-fi-gigabit-ethernet-bluetooth-windows-xp-p-x75.jpg','.jpg',185162,222263,1,75,'2010-12-27 12:19:29','2010-12-27 12:19:29',0),(222460,'185265-lenovo-thinkpad-w500-notebook-core-2-duo-t9600-2-8ghz-15-4-intel-core-2-duo-t9600-2-8ghz-15-4-wuxga-4gb-ddr3-sdram-250gb-hdd-dvd-writer-gigabit-ethernet-wi-fi-bluetooth-windows-vista-busine-x300.jpg','.jpg',185265,0,0,300,'2010-12-27 12:21:56','2010-12-27 12:21:56',0),(222461,'185265-lenovo-thinkpad-w500-notebook-core-2-duo-t9600-2-8ghz-15-4-intel-core-2-duo-t9600-2-8ghz-15-4-wuxga-4gb-ddr3-sdram-250gb-hdd-dvd-writer-gigabit-ethernet-wi-fi-bluetooth-windows-vista-busine-x150.jpg','.jpg',185265,222460,1,150,'2010-12-27 12:21:56','2010-12-27 12:21:56',0),(222462,'185265-lenovo-thinkpad-w500-notebook-core-2-duo-t9600-2-8ghz-15-4-intel-core-2-duo-t9600-2-8ghz-15-4-wuxga-4gb-ddr3-sdram-250gb-hdd-dvd-writer-gigabit-ethernet-wi-fi-bluetooth-windows-vista-busine-x75.jpg','.jpg',185265,222460,1,75,'2010-12-27 12:21:56','2010-12-27 12:21:56',0),(222495,'185279-lenovo-thinkpad-t500-notebook-core-2-duo-p8600-2-4ghz-15-4-black-intel-centrino-2-core-2-duo-p8600-2-4ghz-15-4-wsxga-3gb-ddr3-sdram-160gb-hdd-dvd-writer-dvdr-rw-gigabit-ethernet-wi-fi-x300.jpg','.jpg',185279,0,0,300,'2010-12-27 12:22:18','2010-12-27 12:22:18',0),(222496,'185279-lenovo-thinkpad-t500-notebook-core-2-duo-p8600-2-4ghz-15-4-black-intel-centrino-2-core-2-duo-p8600-2-4ghz-15-4-wsxga-3gb-ddr3-sdram-160gb-hdd-dvd-writer-dvdr-rw-gigabit-ethernet-wi-fi-x150.jpg','.jpg',185279,222495,1,150,'2010-12-27 12:22:18','2010-12-27 12:22:18',0),(222497,'185279-lenovo-thinkpad-t500-notebook-core-2-duo-p8600-2-4ghz-15-4-black-intel-centrino-2-core-2-duo-p8600-2-4ghz-15-4-wsxga-3gb-ddr3-sdram-160gb-hdd-dvd-writer-dvdr-rw-gigabit-ethernet-wi-fi-x75.jpg','.jpg',185279,222495,1,75,'2010-12-27 12:22:18','2010-12-27 12:22:18',0),(222504,'185335-lenovo-thinkpad-r500-notebook-core-2-duo-p8400-2-26ghz-15-4-black-intel-core-2-duo-p8400-2-26ghz-15-4-wxga-2gb-ddr3-sdram-160gb-hdd-dvd-writer-gigabit-ethernet-wi-fi-pc-dos-license-black-x300.jpg','.jpg',185335,0,0,300,'2010-12-27 12:23:25','2010-12-27 12:23:26',0),(222505,'185335-lenovo-thinkpad-r500-notebook-core-2-duo-p8400-2-26ghz-15-4-black-intel-core-2-duo-p8400-2-26ghz-15-4-wxga-2gb-ddr3-sdram-160gb-hdd-dvd-writer-gigabit-ethernet-wi-fi-pc-dos-license-black-x150.jpg','.jpg',185335,222504,1,150,'2010-12-27 12:23:26','2010-12-27 12:23:26',0),(222506,'185335-lenovo-thinkpad-r500-notebook-core-2-duo-p8400-2-26ghz-15-4-black-intel-core-2-duo-p8400-2-26ghz-15-4-wxga-2gb-ddr3-sdram-160gb-hdd-dvd-writer-gigabit-ethernet-wi-fi-pc-dos-license-black-x75.jpg','.jpg',185335,222504,1,75,'2010-12-27 12:23:26','2010-12-27 12:23:26',0),(222510,'185339-lenovo-thinkpad-r500-notebook-core-2-duo-t6570-2-10ghz-15-4-black-intel-centrino-core-2-duo-t6570-2-1ghz-15-4-wxga-2gb-ddr3-sdram-250gb-hdd-dvd-writer-dvdr-rw-gigabit-ethernet-wi-fi-b-x300.jpg','.jpg',185339,0,0,300,'2010-12-27 12:23:31','2010-12-27 12:23:31',0),(222511,'185339-lenovo-thinkpad-r500-notebook-core-2-duo-t6570-2-10ghz-15-4-black-intel-centrino-core-2-duo-t6570-2-1ghz-15-4-wxga-2gb-ddr3-sdram-250gb-hdd-dvd-writer-dvdr-rw-gigabit-ethernet-wi-fi-b-x150.jpg','.jpg',185339,222510,1,150,'2010-12-27 12:23:31','2010-12-27 12:23:31',0),(222512,'185339-lenovo-thinkpad-r500-notebook-core-2-duo-t6570-2-10ghz-15-4-black-intel-centrino-core-2-duo-t6570-2-1ghz-15-4-wxga-2gb-ddr3-sdram-250gb-hdd-dvd-writer-dvdr-rw-gigabit-ethernet-wi-fi-b-x75.jpg','.jpg',185339,222510,1,75,'2010-12-27 12:23:31','2010-12-27 12:23:31',0),(222561,'185379-lenovo-thinkpad-w500-mobile-workstation-core-2-duo-t9600-2-8ghz-15-4-intel-core-2-duo-t9600-2-8ghz-15-4-wuxga-3gb-ddr3-sdram-320gb-hdd-dvd-writer-gigabit-ethernet-wi-fi-bluetooth-windows-vi-x300.jpg','.jpg',185379,0,0,300,'2010-12-27 12:24:25','2010-12-27 12:24:26',0),(222562,'185379-lenovo-thinkpad-w500-mobile-workstation-core-2-duo-t9600-2-8ghz-15-4-intel-core-2-duo-t9600-2-8ghz-15-4-wuxga-3gb-ddr3-sdram-320gb-hdd-dvd-writer-gigabit-ethernet-wi-fi-bluetooth-windows-vi-x150.jpg','.jpg',185379,222561,1,150,'2010-12-27 12:24:25','2010-12-27 12:24:25',0),(222563,'185379-lenovo-thinkpad-w500-mobile-workstation-core-2-duo-t9600-2-8ghz-15-4-intel-core-2-duo-t9600-2-8ghz-15-4-wuxga-3gb-ddr3-sdram-320gb-hdd-dvd-writer-gigabit-ethernet-wi-fi-bluetooth-windows-vi-x75.jpg','.jpg',185379,222561,1,75,'2010-12-27 12:24:25','2010-12-27 12:24:25',0),(222896,'185514-panasonic-toughbook-19-notebook-intel-core-2-duo-su9300-1-2ghz-10-4-xga-2gb-ddr2-sdram-160gb-hdd-gigabit-ethernet-windows-vista-windows-xp-professional-downgradable-magnesium-alloy-x300.jpg','.jpg',185514,0,0,300,'2010-12-27 12:27:43','2010-12-27 12:27:43',0),(222897,'185514-panasonic-toughbook-19-notebook-intel-core-2-duo-su9300-1-2ghz-10-4-xga-2gb-ddr2-sdram-160gb-hdd-gigabit-ethernet-windows-vista-windows-xp-professional-downgradable-magnesium-alloy-x150.jpg','.jpg',185514,222896,1,150,'2010-12-27 12:27:43','2010-12-27 12:27:43',0),(222898,'185514-panasonic-toughbook-19-notebook-intel-core-2-duo-su9300-1-2ghz-10-4-xga-2gb-ddr2-sdram-160gb-hdd-gigabit-ethernet-windows-vista-windows-xp-professional-downgradable-magnesium-alloy-x75.jpg','.jpg',185514,222896,1,75,'2010-12-27 12:27:43','2010-12-27 12:27:43',0),(224087,'186133-lenovo-thinkpad-r400-notebook-core-2-duo-p8400-2-26ghz-14-1-black-intel-core-2-duo-p8400-2-26ghz-14-1-wxga-3gb-ddr3-sdram-160gb-hdd-combo-drive-cd-rw-dvd-rom-gigabit-ethernet-wi-fi-windo-x300.jpg','.jpg',186133,0,0,300,'2010-12-27 12:52:49','2010-12-27 12:52:49',0),(224088,'186133-lenovo-thinkpad-r400-notebook-core-2-duo-p8400-2-26ghz-14-1-black-intel-core-2-duo-p8400-2-26ghz-14-1-wxga-3gb-ddr3-sdram-160gb-hdd-combo-drive-cd-rw-dvd-rom-gigabit-ethernet-wi-fi-windo-x150.jpg','.jpg',186133,224087,1,150,'2010-12-27 12:52:49','2010-12-27 12:52:49',0),(224089,'186133-lenovo-thinkpad-r400-notebook-core-2-duo-p8400-2-26ghz-14-1-black-intel-core-2-duo-p8400-2-26ghz-14-1-wxga-3gb-ddr3-sdram-160gb-hdd-combo-drive-cd-rw-dvd-rom-gigabit-ethernet-wi-fi-windo-x75.jpg','.jpg',186133,224087,1,75,'2010-12-27 12:52:49','2010-12-27 12:52:49',0);
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT '',
  `description` text,
  `ds_vendor_id` int(11) DEFAULT '0',
  `ds_vendor_type` varchar(255) DEFAULT '',
  `msrp` float DEFAULT '0',
  `reseller_price` float DEFAULT '0',
  `manufacturer` varchar(255) DEFAULT '',
  `weight` float DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `map` float DEFAULT '0',
  `category_id` int(11) NOT NULL DEFAULT '0',
  `upc_code` varchar(255) DEFAULT '',
  `availability` varchar(255) DEFAULT 'NA',
  PRIMARY KEY (`id`),
  KEY `index_products_on_category_id` (`category_id`),
  FULLTEXT KEY `fulltext_product` (`title`,`description`,`manufacturer`)
) ENGINE=MyISAM AUTO_INCREMENT=190943 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (12504,'HiRez Portable 7 inch Digital TV','<br/><br/> ',12504,'DsdiProduct',159.99,89.9,'Tivax',3,'2010-09-05 23:36:18','2010-09-05 23:36:18',0,274,'','NA'),(12515,'Amplified Indoor Digital TV Antenna','<br/><br/> ',12515,'DsdiProduct',29.99,16.2,'Tivax',1.5,'2010-09-05 23:37:45','2010-09-05 23:37:45',0,274,'','NA'),(12586,'MiniVu7-C Portable 7 inch Digital TV','<br/><br/> ',12586,'DsdiProduct',154.99,78.9,'Tivax',2.5,'2010-09-05 23:45:11','2010-09-05 23:45:11',0,274,'','NA'),(12587,'MiniVu7 Portable 7 inch Digital TV','<br/><br/> ',12587,'DsdiProduct',149.99,74.5,'Tivax',2.5,'2010-09-05 23:45:17','2010-09-05 23:45:17',0,274,'','NA'),(12588,'Scout35 Portable 3.5 inch Digital TV','<br/><br/> ',12588,'DsdiProduct',139.99,73.4,'Tivax',2,'2010-09-05 23:45:28','2010-09-05 23:45:28',0,274,'','NA'),(12589,'HiRez7 Docking Station','<br/><br/> ',12589,'DsdiProduct',39.99,18.4,'Tivax',1,'2010-09-05 23:45:37','2010-09-05 23:45:37',0,274,'','NA'),(12590,'Scout 35 Docking Station','<br/><br/> ',12590,'DsdiProduct',39.99,18.4,'Tivax',1,'2010-09-05 23:45:43','2010-09-05 23:45:43',0,274,'','NA'),(57995,'Disney TRON: Evolution CE X360','',5508,'DandhProduct',129.99,108.76,'Disney Interactive',0.5,'2010-11-20 08:10:43','2010-11-20 08:10:43',0,567,'','NA'),(58044,'WB Operation Flashpoint: Dragon Rising','The island of Skira has been a disputed territory since the end of World War II. Officially, it falls under the sovereignty of the Russian Federation, but a U.S. and Japanese presence has been there following the discovery of extremely rich and viable oil fields.As you are aware, the Russian Federation has requested U.S. military support. In response, the USS Iwo Jima has been deployed. You and your fellow Marines should expect to engage scattered but heavily entrenched PLA positions. Our success on Skira could avert total war on the mainland. <b>Co-Op Modes:</b><b>Player Vs Player:</b>',5557,'DandhProduct',19.99,16.93,'Warner Bros.',0.3,'2010-11-20 08:14:31','2010-11-20 08:14:31',0,564,'','NA'),(58085,'Codemasters Damnation','Evolving the shooter genre with its unique and exhilarating combination of fluid action and combat, Damnation will feature huge, open environments, frenetic combat, daredevil acrobatics and high-octane vehicle-based stunts. Presenting players with an intense test of reflexes, quick thinking and rapid-fire conflict, Damnation will feature vast, breathtaking landscapes, each covering miles of distance and thousands of vertical feet.Billed as a \'shooter gone vertical\' and visually inspired by iconic elements of American history, these massive streaming landscapes will form the battlegrounds for a post-industrial conflict between humanity and an unstoppable arms dealer hell-bent on total world domination.',5598,'DandhProduct',39.99,34.88,'Southpeak Interactive',0.25,'2010-11-20 08:17:46','2010-11-20 08:17:46',0,564,'','NA'),(58183,'WB FUEL','',5696,'DandhProduct',19.99,13.34,'Warner Bros.',0.5,'2010-11-20 08:25:27','2010-11-20 08:25:27',0,567,'','NA'),(58232,'THQ Darksiders','Deceived by the forces of evil into prematurely bringing about the end of the world, War - the first Horseman of the Apocalypse - stands accused of breaking the sacred law by inciting a war between Heaven and Hell. In the ensuing slaughter, demonic forces defeated the Heavenly Hosts and laid claim to the Earth.Brought before the sacred Charred Council, War is indicted for his crimes and stripped of his powers. Dishonored and facing his own demise, War is given the opportunity to find redemption by returning to Earth to search for the truth - and to punish those responsible.<b>Apocalyptic Power:</b><b>Epic Quest:</b><b>Battle Heaven and Hell:</b>',5745,'DandhProduct',19.99,16.93,'THQ',0.2,'2010-11-20 08:29:05','2010-11-20 08:29:05',0,564,'','NA'),(58262,'THQ Homefront','Join the Resistance, stand united and fight for freedom against an overwhelming military force in Homefront\'s gripping single player campaign penned by John Milius (Apocalypse Now, Red Dawn). Stand alongside a cast of memorable characters as an emotional plot unfolds in this terrifyingly plausible near-future world. Experience visceral, cinematic first-person shooter action as you fight your way across Occupied USA using guerrilla tactics, and commandeer military vehicles and advanced drone technology to defeat the enemy.<b>Discover a terrifyingly plausible near-future world:</b> <b>Fight for a cause:</b> <b>Witness the human cost of war:</b> <b>Experience explosive FPS gameplay:</b> <b>Take the battle online:</b> ',5775,'DandhProduct',59.99,52.33,'THQ',0.4,'2010-11-20 08:50:04','2010-11-20 08:50:04',0,564,'','NA'),(58272,'THQ Warhammer 40,000: Space Marine','The player becomes the ultimate defender of humanity - a mighty Space Marine - sent to stop the brutal Ork invasion of a vital Forge World. As the barbaric Orks rip the planet apart, it\'s up to you and your battle-hardened squad of Space Marines to cut a bloody path through the Ork horde and discover what they\'re so eager to find.In Space Marine, award-winning video game developer Relic Entertainment (Homeworld, Company of Heroes, Warhammer 40,000: Dawn Of War I &amp; II) will bring the epic Warhammer 40,000 universe to life like never before in a dark and compelling Action / Shooter.',5785,'DandhProduct',59.99,52.33,'THQ',0.3,'2010-11-20 08:50:52','2010-11-20 08:50:52',0,564,'','NA'),(58281,'THQ UFC Undisputed 2010','So you wanna be a fighter! Step into the Octagon in UFC Undisputed 2010 to see if you have what it takes to be the best of the best. UFC Undisputed 2010 features the most authentic MMA action while boasting the best fighters in the world. After one round with all the new features and key improvements, you\'ll embody the essence and spirit of a real fighter.',5794,'DandhProduct',39.99,34.88,'THQ',0.25,'2010-11-20 09:23:40','2010-11-20 09:23:40',0,564,'','NA'),(58290,'THQ Truth or Lies','Put your friends in the Hot Seat to get answers to all of the questions you\'ve been dying to ask! The unique vocal calibration software lets you know whether or not your friends are telling the truth! Play Truth of Lies and discover what secrets are waiting to be revealed!',5803,'DandhProduct',19.99,16.93,'THQ',0.25,'2010-11-20 09:24:24','2010-11-20 09:24:24',0,564,'','NA'),(58299,'THQ Red Faction: Armageddon','Half a century after the Red Faction resistance and their Marauder allies freed Mars from the brutal Earth Defense Force, harmony on Mars is again threatened but this time by a lethal force shrouded in mystery.',5812,'DandhProduct',59.99,52.33,'THQ',0.4,'2010-11-20 09:25:09','2010-11-20 09:25:09',0,564,'','NA'),(58308,'THQ WWE SmackDown vs. Raw 2011','Having sold more than 50 million units worldwide, the renowned WWE simulation experience and annual centre piece in THQ\'s expanding WWE videogame portfolio returns to define the ultimate WWE moments and give players even greater creative and decision making freedom throughout their storied journeys within WWE. WWE SmackDown vs. Raw 2011 will empower players more than ever to define their gameplay experiences in a dynamic and ever-changing WWE.<b>New Dynamic Physics System:</b>  <b>New WWE Universe Mode:</b>  <b>Largest Roster in Franchise History:</b>  <b>Creation Upgrades:</b>  <b>Road to WrestleMania:</b>  <b>Online Mayhem:</b>  ',5821,'DandhProduct',59.99,52.33,'THQ',0.1,'2010-11-20 09:25:54','2010-11-20 09:25:54',0,564,'','NA'),(58318,'THQ De Blob The Underground','',5831,'DandhProduct',59.99,52.33,'THQ',0.4,'2010-11-20 09:26:44','2010-11-20 09:26:44',0,564,'','NA'),(58327,'THQ DreamWorks\' Megamind: Ultimate Showdown','Just as Megamind has become our new Mega Hero, a sudden crime wave hits the city. The Doom Syndicate &amp; their Doom Goons have emerged and are looking to take over! Only Megamind and his arsenal of gadgets can stop them!<b>Become the Mega Hero:</b> <b>2-Player Co-Op:</b> <b>Battle Mega Villains:</b> <b>Operate a Variety of Mega Gadgets:</b> <b>Build Ingenious Inventions:</b> ',5840,'DandhProduct',39.99,34.88,'THQ',0.25,'2010-11-20 09:27:30','2010-11-20 09:27:30',0,564,'','NA'),(58337,'THQ Marvel Super Hero Squad: The Infinity Gauntlet (99218)','Marvel Super Hero Squad: The Infinity Gauntletcontinues the excitement of the original Marvel Super Hero Squad with an all-new storyline that follows Season 2 of the hit animated TV series as shown on Cartoon Network. Players can \"Hero Up\" with friends in cooperative play and master the unique Factor Power of each of the Marvel heroes in three game modes: Story Mode, Freeplay Mode and Challenge Mode. The game also boasts a brand new puzzle component, in which players will need to utilize the characters\' unique abilities to move or destroy objects, traverse through certain environments, and summon specific strengths to overcome obstacles. With new adventures, tricky puzzles, an expanded selection of Marvel Super Hero Squad members to unlock and play as, Marvel Super Hero Squad: The Infinity Gauntletis set to thrill gamers from here to Super Hero City.<b>Superpowers Go!:</b> <b>New Environments!:</b> <b>Collect Rare Super Hero Squad Items!:</b> <b>Team Up!:</b> <b>Heroic Feats!:</b> ',5850,'DandhProduct',39.99,34.88,'THQ',0.3,'2010-11-20 09:28:19','2010-11-20 09:28:19',0,564,'','NA'),(58347,'THQ YOU DON\'T KNOW JACK (99225)','YOU DON\'T KNOW JACK, the original quiz show party game, is back and trivia-y-er than ever! You\'re the contestant in a truly interactive game show experience, complete with cash, prizes, backstage characters, pounding music, bizarre sound effects and your lovable but verbally sassy host, Cookie Masterson. Play at home or online - alone or with friends - as you battle through a trivia mind-field on your way to victory, defeat or, more likely, soiled pants.We decided to re-imagine a new-and-improved YOU DON\'T KNOW JACK for the 21st century. All of your favorite elements are still there: the twisted multiple-choice questions, musical question intros, the DisOrDat, Screw Your Neighbor and the Jack Attack, plus all kinds of new face-melting features and surprises - including online play! And of course, tons of all-new twisted trivia questions covering everything from Dr. Phil to Dr. Pepper, from Miley Cyrus to the Mile High Club. It\'s fun, it\'s funny, it\'s funky, and it kills more than 99.9% of known fungi. YOU DON\'T KNOW JACK!',5860,'DandhProduct',39.99,34.88,'THQ',0.3,'2010-11-20 09:29:03','2010-11-20 09:29:03',0,564,'','NA'),(58356,'THQ WWE All Stars','WWE All Stars will deliver one of the greatest rosters ever assembled in a wrestling-centric videogame.  Renowned WWE Legends will align with today\'s most prominent WWE Superstars, inviting players to generate fantasy matches and ultimately determine the greatest competitors of all time.  In addition, each WWE Legend and WWE Superstar will boast a distinctive and highly stylized appearance, adding to the overall atmosphere and intrepid attitude exuding from the on-screen action.',5869,'DandhProduct',59.99,52.33,'THQ',0.4,'2010-11-20 09:29:47','2010-11-20 09:29:47',0,564,'','NA'),(58443,'Microsoft Fable II','Fable II is the highly anticipated sequel to the wildly successful original that sold more than three million copies, offering even more choices and building on the core gameplay theme of Fable, where your every decision continually defines who you become. This action role-playing game (RPG) allows you to live the life you choose in the newly expanded open world of Albion. Set 500 years after the original, Fable II delivers an epic story and innovative real-time gameplay, including a massive amount of freedom and choice to explore a vast collection of dungeons, catacombs, and taverns in the world of Albion.<b>Choices, consequences:</b> <b>A land far, far away:</b> <b>Fight with ease:</b> <b>A hero\'s best friend:</b> <b>Experience the world together:</b> <b>Earn in-game gold:</b> ',5956,'DandhProduct',19.99,16.42,'Microsoft (X-Box)',0.25,'2010-11-20 09:37:09','2010-11-20 09:37:09',0,567,'','NA'),(58513,'Microsoft Halo 3','The epic saga continues with Halo 3, the hugely anticipated third chapter in the highly successful and critically acclaimed Halo franchise. Master Chief returns to finish the fight, bringing the epic conflict between the Covenant, the Flood, and the entire human race to a dramatic, pulse-pounding climax. Halo 3 represents the third chapter in the Halo trilogy an international award-winning action series that grew into a global entertainment phenomenon, selling more than 14.5 million units worldwide, logging more than 650 million hours of multiplayer action on Xbox LIVE, and spawning action figures, books, a graphic novel, apparel, an upcoming film adaptation, and more.<b>Epic story: </b> <b>Next-gen advantage:</b> <b>Evolution of design:</b> <b>Unparalleled experience:</b> ',6026,'DandhProduct',29.99,25.14,'Microsoft (X-Box)',0.3,'2010-11-20 09:42:22','2010-11-20 09:42:22',0,567,'','NA'),(58762,'WB F1 2010 The Video Game','F1 2010 is the first multi-format, high definition FORMULA ONE video game from Codemasters, the developer and publisher of award-winning racing games, under its exclusive worldwide agreement with Formula One Administration Limited. Complete with all the official drivers, teams and circuits of the 2010 FIA FORMULA ONE WORLD CHAMPIONSHIP, immersing players in the glamour, pressure and exhilaration of the world\'s most exciting motorsport, on and off the circuit.',6275,'DandhProduct',59.99,51.81,'Warner Bros.',0.25,'2010-11-20 09:57:26','2010-11-20 09:57:26',0,564,'','NA'),(58772,'WB F1 2010 The Video Game (40334WB)','F1 2010 is the first multi-format, high definition FORMULA ONE video game from Codemasters, the developer and publisher of award-winning racing games, under its exclusive worldwide agreement with Formula One Administration Limited. Complete with all the official drivers, teams and circuits of the 2010 FIA FORMULA ONE WORLD CHAMPIONSHIP, immersing players in the glamour, pressure and exhilaration of the world\'s most exciting motorsport, on and off the circuit.',6285,'DandhProduct',59.99,51.81,'Warner Bros.',0.25,'2010-11-20 09:58:06','2010-11-20 09:58:06',0,567,'','NA'),(60586,'Batman: Arkham Asylum PS3','',8099,'DandhProduct',29.99,26.16,'Square Enix',0.25,'2010-11-20 11:55:08','2010-11-20 11:55:08',0,564,'','NA'),(60606,'Batman: Arkham Asylum X360','',8119,'DandhProduct',29.99,26.16,'Square Enix',0.1,'2010-11-20 11:56:07','2010-11-20 11:56:07',0,567,'','NA'),(60786,'WB Terminator Salvation','',8299,'DandhProduct',19.99,16.93,'Warner Bros.',0.25,'2010-11-20 12:05:41','2010-11-20 12:05:41',0,567,'','NA'),(61398,'WB Watchmen: The End is Nigh The Complete Experience','Immerse yourself in the iconic watchmen world and experience hardcore, gut-punching combat as urban vigilantes Rorschach and Nite Owl. Watchmen: The end is night takes place 10 years before Zach Snyder\'s watchmen film, with the hero-banning keene act still a few years away. In a time when crime and terror rule the streets, the end seems inevitable.<b>Watchmen: The End Is Nigh Part 1:</b><b>Watchmen: The End Is Nigh Part 2:</b><b>Watchmen: The End is Nigh Parts 1 and 2 Videogame with additional film bonus:</b><b>Watchmen Blu-ray:</b>',8911,'DandhProduct',29.99,15.13,'Warner Bros.',0.25,'2010-11-20 12:51:19','2010-11-20 12:51:19',0,567,'','NA'),(185162,'Lenovo ThinkPad W500 Notebook - Core 2 Duo T9600 2.8GHz - 15.4\" - Black - Intel Core 2 Duo T9600 2.8GHz - 15.4\" WUXGA - 2GB DDR3 SDRAM - 160GB HDD - DVD-Writer - Wi-Fi, Gigabit Ethernet, Bluetooth - Windows XP P','<p>ThinkPad W500 Mobile Workstation with legendary design features, superior quality, durability, reliability and latest technologies ensures the product stays viable for the next few years.</p>',123686,'IngramMicroProduct',1999,1742.18,'Lenovo Group Limited',8,'2010-12-27 12:19:29','2010-12-27 12:19:29',0,272,'0884343196084','Call'),(185265,'Lenovo ThinkPad W500 Notebook - Core 2 Duo T9600 2.8GHz - 15.4\" - Intel Core 2 Duo T9600 2.8GHz - 15.4\" WUXGA - 4GB DDR3 SDRAM - 250GB HDD - DVD-Writer - Gigabit Ethernet, Wi-Fi, Bluetooth - Windows Vista Busine','<p>Meet the new ThinkPad W500 Mobile Workstation. Featuring the latest Intel Core 2 Duo processor, superior performance 512MB Discrete Open GL graphics, key ISV certifications and support, a razor-sharp 15.4\" premium WUXGA widescreen display and an embedded Trusted Platform Module security solution, it offers today\'s businesses the ultimate in performance, mobility and security.</p>',123789,'IngramMicroProduct',1999,1742.18,'Lenovo Group Limited',10,'2010-12-27 12:21:56','2010-12-27 12:21:56',0,272,'0884343902227','Call'),(185279,'Lenovo ThinkPad T500 Notebook - Core 2 Duo P8600 2.4GHz - 15.4\" - Black - Intel Centrino 2 Core 2 Duo P8600 2.4GHz - 15.4\" WSXGA+ - 3GB DDR3 SDRAM - 160GB HDD - DVD-Writer (DVDÂ±R/Â±RW) - Gigabit Ethernet, Wi-Fi','<p>The ThinkPad T500 Notebook is designed to enhance productivity and change the way you work. To begin with, it features widescreen display that helps to lower power consumption and offers brighter colors.</p>',123803,'IngramMicroProduct',1299,1172.07,'Lenovo Group Limited',10,'2010-12-27 12:22:18','2010-12-27 12:22:18',0,272,'0884343901985','Call'),(185335,'Lenovo ThinkPad R500 Notebook - Core 2 Duo P8400 2.26GHz - 15.4\" - Black - Intel Core 2 Duo P8400 2.26GHz - 15.4\" WXGA - 2GB DDR3 SDRAM - 160GB HDD - DVD-Writer - Gigabit Ethernet, Wi-Fi - PC DOS License - Black','<p>ThinkPad R500 Notebook is equipped specifically for home office buyers. This notebook provide easy-to-use and easy-to-manage security, connectivity and other features critical to working in today\'s networked world.</p>',123859,'IngramMicroProduct',0,726.14,'Lenovo Group Limited',6.4,'2010-12-27 12:23:25','2010-12-27 12:23:25',0,272,'','Call'),(185339,'Lenovo ThinkPad R500 Notebook - Core 2 Duo T6570 2.10GHz - 15.4\" - Black - Intel Centrino Core 2 Duo T6570 2.1GHz - 15.4\" WXGA - 2GB DDR3 SDRAM - 250GB HDD - DVD-Writer (DVDÂ±R/Â±RW) - Gigabit Ethernet, Wi-Fi, B','<p>ThinkPad R500 Notebook offers the best blend of essential features for frequently mobile users who want easy, ready-to-run computing. Whether it is processor power, display size, or connectivity, you have the right balance of portability, strength and affordability for all your mobile computing needs. </p>',123863,'IngramMicroProduct',1069,986.47,'Lenovo Group Limited',0,'2010-12-27 12:23:31','2010-12-27 12:23:31',0,272,'','Call'),(185379,'Lenovo ThinkPad W500 Mobile Workstation - Core 2 Duo T9600 2.8GHz - 15.4\" - Intel Core 2 Duo T9600 2.8GHz - 15.4\" WUXGA - 3GB DDR3 SDRAM - 320GB HDD - DVD-Writer - Gigabit Ethernet, Wi-Fi, Bluetooth - Windows Vi','<p>The new ThinkPad W500 Mobile Workstation offer lightning-fast Intel Core 2 Duo technology, advanced graphics, cutting-edge technology features and the durability and rock-solid reliability you expect from Lenovo.</p>',123903,'IngramMicroProduct',1999,1742.18,'Lenovo Group Limited',7.25,'2010-12-27 12:24:25','2010-12-27 12:24:25',0,272,'0884343902234','Call'),(185514,'Panasonic Toughbook 19 Notebook - Intel Core 2 Duo SU9300 1.2GHz - 10.4\" XGA - 2GB DDR2 SDRAM - 160GB HDD - Gigabit Ethernet - Windows Vista / Windows XP Professional Downgradable - Magnesium Alloy','<p>With Toughbook 19 Notebook take handwritten notes, mark and edit documents and draw diagrams. It even converts handwriting to printed text. The Toughbook 19 Notebook -tough times two.</p>',124038,'IngramMicroProduct',3629,2925.71,'Panasonic',7.75,'2010-12-27 12:27:43','2010-12-27 12:27:43',0,272,'0092281891125','Call'),(186133,'Lenovo ThinkPad R400 Notebook - Core 2 Duo P8400 2.26GHz - 14.1\" - Black - Intel Core 2 Duo P8400 2.26GHz - 14.1\" WXGA - 3GB DDR3 SDRAM - 160GB HDD - Combo Drive (CD-RW/DVD-ROM) - Gigabit Ethernet, Wi-Fi - Windo','<p>By combining the latest Intel technology, graphics and a variety of wireless solutions, the ThinkPad R400 Notebook is designed to boost performance and help you work smartly and efficiently. It features 14.1\" widescreen displays with a wide range of technology that includes the latest hard drive, a camera, modem, a 6-cell battery and UltraNav for improved ergonomics.</p>',124657,'IngramMicroProduct',0,1103.73,'Lenovo Group Limited',5.5,'2010-12-27 12:52:48','2010-12-27 12:52:48',0,272,'','Call');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_users`
--

DROP TABLE IF EXISTS `roles_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_users`
--

LOCK TABLES `roles_users` WRITE;
/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;
INSERT INTO `roles_users` VALUES (1,325,1,'0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20100819000751'),('20100819035705'),('20100819194721'),('20100819195347'),('20100820213025'),('20100822060541'),('20100822061252'),('20100823052122'),('20100825015458'),('20100825211756'),('20100904060054'),('20101119024706'),('20101220050159'),('20101222034051'),('20101222040632'),('20101226023842'),('20110109214053'),('20110109221537'),('20110109232828'),('20110127190057'),('20110128071513'),('20120510201738'),('20120511175217');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_addresses`
--

DROP TABLE IF EXISTS `shipping_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipping_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `current_default` tinyint(1) DEFAULT '0',
  `session_id` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `index_shipping_addresses_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_addresses`
--

LOCK TABLES `shipping_addresses` WRITE;
/*!40000 ALTER TABLE `shipping_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spex_essential_products`
--

DROP TABLE IF EXISTS `spex_essential_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spex_essential_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `etilize_product_id` int(11) DEFAULT NULL,
  `ingram_sku` varchar(100) DEFAULT NULL,
  `dandh_sku` varchar(100) DEFAULT NULL,
  `market` varchar(40) DEFAULT NULL,
  `mfg_id` int(11) DEFAULT NULL,
  `manufacturer_name` varchar(60) DEFAULT NULL,
  `mfgpartno` varchar(60) DEFAULT NULL,
  `gtin` varchar(255) DEFAULT NULL,
  `etilize_category_id` int(11) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `name` text,
  `marketing_text` text,
  `tech_specs` text,
  `image_url` varchar(100) DEFAULT NULL,
  `etilize_creation_date` varchar(50) DEFAULT NULL,
  `etilize_modified_date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_spex_essential_products_on_etilize_product_id` (`etilize_product_id`),
  KEY `index_spex_essential_products_on_ingram_sku` (`ingram_sku`),
  KEY `index_spex_essential_products_on_dandh_sku` (`dandh_sku`)
) ENGINE=InnoDB AUTO_INCREMENT=860024 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spex_essential_products`
--

LOCK TABLES `spex_essential_products` WRITE;
/*!40000 ALTER TABLE `spex_essential_products` DISABLE KEYS */;
INSERT INTO `spex_essential_products` VALUES (1,10000007,'215338','DSS24PLUS','US',1017,'D-Link Systems, Inc','DSS-24+','0790069237812,0662705401560,0746320734484,0746320097541,0051851440255,0790069242359,0718908389089,00',4799,'Switches & Bridges','D-Link Ethernet Switch - 24 x 10/100Base-TX, 2 x 100Base-FX','D-Link\'s DSS-24+ is a high performance unmanaged Layer 2 Switch that provides users with 24 10/100Mbps Fast Ethernet ports with NWay auto-negotiation per port. Designed with a new chipset, the DSS-24+ can automatically detect either MDI/MDIX cable type through any of the Ethernet ports, which eliminates the need for an uplink port. The DSS-24+ includes support for an optional 2-port 100BASE-FX module with an \"SC connector\" increasing cable connectivity to other servers and switches. The DSS-24+ is targeted for both small office and small business environments.','<li>Brand Name : D-Link</li><li>Product Type : Ethernet Switch</li><li>Number of Ports : 24</li><li>Network Technology : 100Base-FX</li><li>Network Technology : 10/100Base-TX</li><li>Number of Expansion Slots : 1</li>','http://content.etilize.com/300/10000007.jpg','12/10/2010','12/24/2010'),(2,10000014,'039035','','US',10221,'3Com Corporation','3C17204-US','',4799,'Switches & Bridges','3Com SuperStack 3 Switch 4400 - 48 x 10/100Base-TX','Deploy high-performance, feature-rich Ethernet LAN switching with high port density. This affordable, intelligent 10/100 switch is fully manageable, making it a good choice for networks of any size. The 3Com SuperStack 3 Switch 4400 also helps increase network availability and reliability. The switch optimizes and controls data flow through the use of advanced quality of service, helping to ensure that mission-critical traffic reaches the intended users every time. Rapid Spanning Tree, stack-wide trunking, resilient stacking, link aggregation and built-in redundant power supply support deliver robust performance and fault tolerance.','<li>Brand Name : 3Com</li><li>Product Family : SuperStack 3</li><li>Product Type : Ethernet Switch</li><li>Number of Ports : 48</li><li>Network Technology : 10/100Base-TX</li><li>Number of Expansion Slots : 2</li><li>Manageable : Yes</li>','http://content.etilize.com/300/10000014.jpg','11/08/2010','12/24/2010'),(3,10000020,'663801','','US',10254,'Cisco Systems, Inc','WS-X6148-RJ21V=','',10005,'Modules','Cisco Switching Module','The Catalyst 6500 48-port 10/100 Fast Ethernet RJ-21 module is designed for the wiring closet. The WS-X6148-RJ21V provides voice capability and inline power.','<li>Brand Name : Cisco</li><li>Product Type : Switching Module</li><li>Number of Ports/Channels : 48</li><li>Interface Type : 10/100Base-TX</li><li>Data Transfer Rate : 10 Mbps</li><li>Data Transfer Rate : 100 Mbps</li>','http://content.etilize.com/160/10000020.jpg','11/08/2010','12/09/2010'),(4,10000020,'CM0229','','US',10254,'Cisco Systems, Inc','WS-X6148-RJ21V=','',10005,'Modules','Cisco Switching Module','The Catalyst 6500 48-port 10/100 Fast Ethernet RJ-21 module is designed for the wiring closet. The WS-X6148-RJ21V provides voice capability and inline power.','<li>Brand Name : Cisco</li><li>Product Type : Switching Module</li><li>Number of Ports/Channels : 48</li><li>Interface Type : 10/100Base-TX</li><li>Data Transfer Rate : 10 Mbps</li><li>Data Transfer Rate : 100 Mbps</li>','http://content.etilize.com/160/10000020.jpg','11/08/2010','12/09/2010'),(5,10000021,'CM0230','','US',10254,'Cisco Systems, Inc','WS-X6148-RJ45V=','',10005,'Modules','Cisco Switching Module','The Catalyst 6500 48-port 10/100 Fast Ethernet RJ-45 module is designed for the wiring closet. The WS-X6148-RJ45V provides voice capability and inline power.','<li>Brand Name : Cisco</li><li>Product Type : Switching Module</li><li>Number of Ports/Channels : 48</li><li>Interface Type : 10/100Base-TX</li><li>Data Transfer Rate : 10 Mbps</li><li>Data Transfer Rate : 100 Mbps</li>','http://content.etilize.com/160/10000021.jpg','11/08/2010','12/09/2010'),(6,10000036,'544104','','US',101156,'Nortel Networks Limited','DS1404011','',10005,'Modules','Nortel Passport 8616SXE Gigabit Ethernet Module','','<li>Brand Name : Nortel</li><li>Product Family : Passport</li><li>Product Type : Expansion Module</li><li>Number of Ports/Channels : 1</li><li>Interface Type : 1000Base-SX</li><li>Data Transfer Rate : 1 Gbps</li>','','11/08/2010','12/09/2010'),(7,10000038,'925286','','US',10254,'Cisco Systems, Inc','WS-X5157=','',10005,'Modules','Cisco Catalyst 5000 WS-X5157 ATM LANE Dual PHY OC-3 Module','','<li>Brand Name : Cisco</li><li>Product Family : 5000</li><li>Product Type : ATM Module</li><li>Number of Ports/Channels : 2</li><li>Interface Type : OC-3</li>','','11/08/2010','12/09/2010'),(8,10000039,'','DI704P','US',1017,'D-Link Systems, Inc','DI-704P','',4800,'Routers & Gateways','D-Link Express EtherNetwork Broadband Router - 4 x 10/100Base-TX LAN, 1 x 10Base-T WAN, 1 x Parallel, 1 x Serial','D-Link, the worldwide leader in innovative home and business networking, sets a new standard for broadband router performance with the Express EtherNetwork DI-704P. <br> <br>The DI-704P is an Ethernet Broadband Router with a built-in 4-port switch. It also features a parallel port to share a printer on the home or office network and includes a print server application for Windows1. As many as four computers can be connected to the router\'s integrated switch, using its four 10/100Mbps AutoMDIX Ethernet ports. The DI-704P package even includes an Ethernet cable to get you started.','<li>Brand Name : D-Link</li><li>Product Family : Express EtherNetwork</li><li>Product Type : Router Appliance</li><li>Number of Ports : 5</li><li>Fast Ethernet Port : Yes</li><li>Form Factor : Desktop</li>','http://content.etilize.com/300/10000039.jpg','11/08/2010','12/09/2010'),(9,10000051,'272336','','US',10166,'Oki Electric Industry Co., Ltd','62415401','',4805,'Dot Matrix Printers','Oki MICROLINE 320 Turbo/N Dot Matrix Printer - 9-pin - 435 cps Mono - 240 x 216 dpi - Parallel, USB','The MICROLINE 320 Turbo/n builds on the heritage of Tank-Tough reliability established by OKI\'s ML320, our best-selling dot matrix printer all around the world. Now, the ML320 Turbo/n comes factory-configured with a high-speed OkiLAN 6120e Internal Print Server for use across your company network or via the Internet.   <p></p>This 9-pin dot matrix printer is blazing new trails in productivity. Engineered for dedicated printing in the most demanding point-of-sale, automation and utility applications, the ML320 Turbo/n can easily run twice as long as most printers in its class! It can simplify any job on virtually any stock, and it\'s economical enough to put wherever you need data on the spot. The ML320 Turbo/n puts the \"work\" in workstations for financial departments, wholesale or retail sales counters, even for warehouse or manufacturing environments.','<li>Brand Name : Oki</li><li>Product Family : MICROLINE</li><li>Product Type : Dot Matrix Printer</li><li>Maximum Mono Print Speed (cps) : 435 cps</li><li>Maximum Print Resolution : 240 x 216 dpi</li><li>Number of Pins : 9-pin</li><li>USB : Yes</li><li>Ethernet : Yes</li>','http://content.etilize.com/300/10000051.jpg','10/27/2010','12/13/2010'),(10,10000057,'300000','LX300PLUS','US',10375,'Epson Corporation','C294001','',4805,'Dot Matrix Printers','Epson LX-300+ Dot Matrix Printer - 9-pin - 300 cps Mono - 240 x 216 dpi - Parallel, Serial','<p>9-pin technology Dot Matrix printer prints up to 337 characters per second in 12 characters-per-inch, high-speed draft mode. Features greater flexibility with serial, parallel and USB ports. Delivers an MTBF rating of 6,000 POH. Produces up to 400 million strokes per wire. Handles five-part forms with ease. Includes eight built-in bar code fonts so you can customize documents as needed. Works effectively in space-constrained environments using little counter space. Lightweight printer generates spreadsheets, mailing labels, and correspondence with clear, sharp text. At 49 dB, the LX-300+II is quieter than most impact printers. Printer has an 8K input buffer; USB, Parallel, Serial interfaces; and continuous feed of 88 milliseconds per 16\" and 3\" per second. Paper size ranges from 3.9\" to 10.1\".</p>','<li>Brand Name : Epson</li><li>Product Family : LX</li><li>Product Type : Dot Matrix Printer</li><li>Maximum Mono Print Speed (cps) : 300 cps</li><li>Maximum Print Resolution : 240 x 216 dpi</li><li>Number of Pins : 9-pin</li><li>Number of Columns : 80</li><li>Media Size : A4</li><li>Media Size : B5</li><li>Media Size : Letter</li><li>Media Size : Legal</li><li>Media Size : Executive</li>','http://content.etilize.com/300/10000057.jpg','12/22/2010','12/22/2010');
/*!40000 ALTER TABLE `spex_essential_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `crypted_password` varchar(40) DEFAULT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `remember_token` varchar(40) DEFAULT NULL,
  `remember_token_expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=326 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (325,'bikokid@gmail.com','fa774954415ec0bdf1a667baee134e464042521d','133a867938eb429f8a712356fd1020c2df40db8a','23238f0258cb41626ca41250168f7ebaf96c6f2f','2012-05-11 23:26:41','2012-05-11 23:26:41',NULL,NULL);
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

-- Dump completed on 2012-05-11 16:29:53
