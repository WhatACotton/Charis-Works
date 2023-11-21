-- MariaDB dump 10.19-11.1.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: CharisWorks
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB

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
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customer` (
  `Email` varchar(100) NOT NULL,
  `UserID` varchar(100) NOT NULL,
  `CustomerName` varchar(100) DEFAULT 'default',
  `ZipCode` varchar(100) DEFAULT 'default',
  `Address1` varchar(100) DEFAULT 'default',
  `Address2` varchar(100) NOT NULL DEFAULT 'default',
  `Address3` varchar(100) DEFAULT NULL,
  `PhoneNumber` varchar(100) NOT NULL DEFAULT 'default',
  `IsRegistered` tinyint(1) NOT NULL DEFAULT 0,
  `CreatedDate` timestamp NULL DEFAULT NULL,
  `LastAccessedDate` timestamp NOT NULL,
  `IsEmailVerified` tinyint(1) NOT NULL DEFAULT 0,
  `role` varchar(100) NOT NULL DEFAULT 'buyer',
  `Cart` text DEFAULT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER InsertDate
BEFORE INSERT
ON Customer FOR EACH ROW
SET New.CreatedDate = NOW(),New.LastAccessedDate = NOW() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Item`
--

DROP TABLE IF EXISTS `Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Item` (
  `ItemID` varchar(100) DEFAULT NULL,
  `StripeAccountID` varchar(100) NOT NULL,
  `ItemOrder` int(11) NOT NULL AUTO_INCREMENT,
  `Status` varchar(100) NOT NULL,
  `Price` int(11) NOT NULL,
  `Stock` int(11) NOT NULL,
  `ItemName` varchar(100) NOT NULL,
  `Description` text NOT NULL DEFAULT '説明',
  `Color` varchar(100) NOT NULL DEFAULT '色',
  `Series` varchar(100) NOT NULL DEFAULT 'シリーズ',
  `Size` varchar(100) NOT NULL DEFAULT 'サイズ',
  `Top` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`ItemOrder`),
  UNIQUE KEY `Item_UN2` (`ItemID`),
  KEY `Item_FK` (`StripeAccountID`),
  CONSTRAINT `Item_FK` FOREIGN KEY (`StripeAccountID`) REFERENCES `Maker` (`StripeAccountID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ItemDetailsImage`
--

DROP TABLE IF EXISTS `ItemDetailsImage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ItemDetailsImage` (
  `ItemID` varchar(100) NOT NULL,
  `Image` varchar(100) NOT NULL,
  `Order` int(11) NOT NULL,
  PRIMARY KEY (`ItemID`),
  CONSTRAINT `ItemDetailsImage_FK` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `LogInLog`
--

DROP TABLE IF EXISTS `LogInLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LogInLog` (
  `UserID` varchar(100) NOT NULL,
  `SessionKey` varchar(100) NOT NULL,
  KEY `LogInLog_FK` (`UserID`),
  CONSTRAINT `LogInLog_FK` FOREIGN KEY (`UserID`) REFERENCES `Customer` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER LogToCustomer
AFTER INSERT
ON LogInLog FOR EACH ROW
UPDATE CharisWorks.Customer SET Customer.LastAccessedDate = NOW() WHERE Customer.UserID = New.UserID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Maker`
--

DROP TABLE IF EXISTS `Maker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Maker` (
  `UserID` varchar(100) NOT NULL,
  `StripeAccountID` varchar(100) NOT NULL,
  `MakerName` varchar(100) NOT NULL DEFAULT 'default',
  `Description` text NOT NULL DEFAULT 'default',
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Maker_UN` (`StripeAccountID`),
  CONSTRAINT `Maker_FK` FOREIGN KEY (`UserID`) REFERENCES `Customer` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TransactionDetails`
--

DROP TABLE IF EXISTS `TransactionDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TransactionDetails` (
  `TransactionID` varchar(100) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `ItemOrder` int(11) NOT NULL AUTO_INCREMENT,
  `ItemID` varchar(100) NOT NULL,
  PRIMARY KEY (`ItemOrder`),
  KEY `TransactionDetails_FK` (`ItemID`),
  KEY `TransactionDetails_FK_1` (`TransactionID`),
  CONSTRAINT `TransactionDetails_FK` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`),
  CONSTRAINT `TransactionDetails_FK_1` FOREIGN KEY (`TransactionID`) REFERENCES `Transactions` (`TransactionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Transactions`
--

DROP TABLE IF EXISTS `Transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Transactions` (
  `TransactionID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `CustomerName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TotalAmount` int(11) NOT NULL,
  `Address1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Address2` varchar(100) NOT NULL,
  `Address3` varchar(100) DEFAULT NULL,
  `PhoneNumber` varchar(100) NOT NULL,
  `ZipCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TransactionTime` timestamp NOT NULL,
  `StripeID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `Transactions_UN` (`TransactionID`),
  KEY `Transactions_FK` (`UserID`),
  CONSTRAINT `Transactions_FK` FOREIGN KEY (`UserID`) REFERENCES `Customer` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_esperanto_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER InsertTransactionDate
BEFORE INSERT
ON Transactions FOR EACH ROW
SET NEW.TransactionTime = NOW() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'CharisWorks'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-20 20:29:32
