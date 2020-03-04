-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: Mobike
-- ------------------------------------------------------
-- Server version	5.7.27

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
-- Table structure for table `AccountHistory`
--

DROP TABLE IF EXISTS `AccountHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AccountHistory` (
  `customer_id` int(11) NOT NULL,
  `updated_timestamp_as_unix_epoch` int(11) NOT NULL,
  `updated_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `balance` int(20) NOT NULL,
  `behavior_credit` int(15) DEFAULT NULL,
  PRIMARY KEY (`updated_timestamp_as_unix_epoch`,`customer_id`),
  KEY `customer_id` (`customer_id`),
  KEY `epoch_index` (`updated_timestamp_as_unix_epoch`) COMMENT 'Index that helps sort the data (in descending order values in the updated_timestamp_as_unix_epoch) faster in the table. This is to improve the performance of some of the queries',
  CONSTRAINT `AccountHistory_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AccountHistory`
--

LOCK TABLES `AccountHistory` WRITE;
/*!40000 ALTER TABLE `AccountHistory` DISABLE KEYS */;
INSERT INTO `AccountHistory` VALUES (1,1574344842,'2019-11-21 14:00:42',20,100),(2,1574344842,'2019-11-21 14:00:42',25,100),(3,1574344842,'2019-11-21 14:00:42',12,100),(4,1574344842,'2019-11-21 14:00:42',20,100),(5,1574344842,'2019-11-21 14:00:42',20,100),(1,1574346631,'2019-11-21 14:30:31',0,100),(2,1574346641,'2019-11-21 14:30:41',20,100),(5,1574346645,'2019-11-21 14:30:45',-28,98),(4,1574346650,'2019-11-21 14:30:50',-23,98),(1,1574347068,'2019-11-21 14:37:48',20,100),(4,1574347068,'2019-11-21 14:37:48',25,96),(5,1574347068,'2019-11-21 14:37:48',20,96),(5,1574445206,'2019-11-22 17:53:26',17,96),(3,1574445618,'2019-11-22 18:00:18',8,100),(1,1582522492,'2020-02-24 05:34:52',16,100),(1,1582522638,'2020-02-24 05:37:18',14,100);
/*!40000 ALTER TABLE `AccountHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bicycle`
--

DROP TABLE IF EXISTS `Bicycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bicycle` (
  `bicycle_id` int(15) NOT NULL AUTO_INCREMENT,
  `bic_status` varchar(150) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `zipcode` varchar(20) DEFAULT NULL,
  `loc_name` varchar(50) DEFAULT NULL,
  `loc_latitude` decimal(10,8) DEFAULT NULL,
  `loc_longitude` decimal(11,8) DEFAULT NULL,
  `added_at_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `removed_at_timestamp` timestamp NULL DEFAULT NULL,
  `moderator_id` int(11) DEFAULT NULL,
  `bicycle_type` varchar(100) DEFAULT 'comfort',
  PRIMARY KEY (`bicycle_id`),
  KEY `moderator_id` (`moderator_id`),
  KEY `bicycle_type_foreign_key` (`bicycle_type`),
  KEY `latitude_index` (`loc_latitude`),
  KEY `longitude_index` (`loc_longitude`),
  KEY `bike_status_index` (`bic_status`),
  KEY `city_index` (`city`),
  CONSTRAINT `Bicycle_ibfk_1` FOREIGN KEY (`moderator_id`) REFERENCES `ContentModerator` (`moderator_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `bicycle_type_foreign_key` FOREIGN KEY (`bicycle_type`) REFERENCES `BikeType` (`bicycle_type`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bicycle`
--

LOCK TABLES `Bicycle` WRITE;
/*!40000 ALTER TABLE `Bicycle` DISABLE KEYS */;
INSERT INTO `Bicycle` VALUES (1,'damaged - ready to move','CLT','NC','28262','PopMartin Student Union',35.29716300,-80.73492310,'2019-11-18 14:00:27',NULL,1,'comfort'),(2,'damaged - ready to move','CLT','NC','28262','Walmart Supercentre',35.30038350,-80.72713180,'2019-11-18 14:00:27',NULL,1,'commuting'),(3,'available','CLT','NC','28262','PopMartin Student Union',35.29716300,-80.73492310,'2019-11-18 14:00:27',NULL,2,'mountain-bike'),(4,'available','CLT','NC','28262','PopMartin Student Union',35.29716300,-80.73492310,'2019-11-18 14:00:27',NULL,3,'road'),(5,'available','CLT','NC','28262','Harris Teeter',35.30038350,-80.72713180,'2019-11-18 14:00:27',NULL,3,'track'),(6,'available','NYC','NY','10009','Death & Company',40.72545300,-73.98453030,'2019-11-18 14:00:27',NULL,5,'comfort'),(7,'available','NYC','NY','10009','Oda House',40.72545300,-73.98453030,'2019-11-18 14:00:27',NULL,5,'commuting'),(8,'damaged - ready to move','NYC','NY','10009','The Public Theatre',40.72549900,-73.98754440,'2019-11-18 14:00:27',NULL,5,'mountain-bike'),(9,'available','NYC','NY','10009','9th Street station',40.73381140,-74.00101230,'2019-11-18 14:00:27',NULL,5,'road'),(10,'available','NYC','NY','10009','9th Street station',40.73381140,-74.00101230,'2019-11-18 14:00:27',NULL,5,'track'),(11,'available','SJ','CA','95113','San Jose centre for the Performing Arts',37.32815680,-121.88391790,'2019-11-18 14:00:27',NULL,4,'comfort'),(12,'damaged - ready to move','SJ','CA','95113','Chavelas Restaurant',37.32659110,-121.88603060,'2019-11-18 14:00:27',NULL,4,'commuting'),(13,'available','SJ','CA','95113','SAP Centre',37.32973930,-121.89331550,'2019-11-18 14:00:27',NULL,4,'mountain-bike'),(14,'available','SJ','CA','95113','Roosevelt Park',37.34852950,-121.87474030,'2019-11-18 14:00:27',NULL,4,'road'),(15,'available','SJ','CA','95113','Roosevelt Park',37.34852950,-121.87474030,'2019-11-18 14:00:27',NULL,4,'track');
/*!40000 ALTER TABLE `Bicycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BikePrice`
--

DROP TABLE IF EXISTS `BikePrice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BikePrice` (
  `prepaid_plan_id` int(11) NOT NULL,
  `bicycle_type` varchar(100) NOT NULL,
  `price_per_hour` float NOT NULL DEFAULT '5',
  `updated_at_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `moderator_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`prepaid_plan_id`,`bicycle_type`),
  KEY `moderator_id_foreign_key` (`moderator_id`),
  KEY `bicycle_type_foreign_key` (`bicycle_type`),
  KEY `composite_bicycle_type_plan_id_index` (`bicycle_type`,`prepaid_plan_id`),
  CONSTRAINT `bikeprice_ibfk_1` FOREIGN KEY (`moderator_id`) REFERENCES `ContentModerator` (`moderator_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `bikeprice_ibfk_2` FOREIGN KEY (`prepaid_plan_id`) REFERENCES `PrepaidPlan` (`plan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bikeprice_ibfk_3` FOREIGN KEY (`bicycle_type`) REFERENCES `BikeType` (`bicycle_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BikePrice`
--

LOCK TABLES `BikePrice` WRITE;
/*!40000 ALTER TABLE `BikePrice` DISABLE KEYS */;
INSERT INTO `BikePrice` VALUES (1,'comfort',1,'2019-11-21 13:59:35',1),(1,'commuting',1.2,'2019-11-21 13:59:35',1),(1,'mountain-bike',2,'2019-11-21 13:59:35',2),(1,'road',1,'2019-11-21 13:59:35',2),(1,'track',1.5,'2019-11-21 13:59:35',3),(2,'comfort',0.9,'2019-11-21 13:59:56',1),(2,'commuting',1,'2019-11-21 13:59:56',1),(2,'mountain-bike',1.8,'2019-11-21 13:59:56',2),(2,'road',0.9,'2019-11-21 13:59:56',2),(2,'track',1.35,'2019-11-21 13:59:56',3),(3,'comfort',0.9,'2019-11-21 13:59:43',1),(3,'commuting',1,'2019-11-21 13:59:43',1),(3,'mountain-bike',1.8,'2019-11-21 13:59:43',2),(3,'road',0.9,'2019-11-21 13:59:43',2),(3,'track',1.35,'2019-11-21 13:59:43',3),(4,'comfort',1.5,'2019-11-21 13:59:37',1),(4,'commuting',1.9,'2019-11-21 13:59:37',1),(4,'mountain-bike',3,'2019-11-21 13:59:37',2),(4,'road',1.5,'2019-11-21 13:59:37',2),(4,'track',2.25,'2019-11-21 13:59:37',3),(5,'comfort',1,'2019-11-21 14:00:00',1),(5,'commuting',1.2,'2019-11-21 14:00:00',1),(5,'mountain-bike',2.2,'2019-11-21 14:00:00',2),(5,'road',1,'2019-11-21 14:00:00',2),(5,'track',1.6,'2019-11-21 14:00:00',3),(6,'comfort',1.2,'2019-11-21 13:59:49',1),(6,'commuting',1.6,'2019-11-21 13:59:49',1),(6,'mountain-bike',2.5,'2019-11-21 13:59:49',2),(6,'road',1.2,'2019-11-21 13:59:49',2),(6,'track',2,'2019-11-21 13:59:49',3),(7,'comfort',1.5,'2019-11-21 13:59:40',1),(7,'commuting',1.9,'2019-11-21 13:59:40',1),(7,'mountain-bike',3,'2019-11-21 13:59:40',2),(7,'road',1.5,'2019-11-21 13:59:40',2),(7,'track',2.25,'2019-11-21 13:59:40',3),(8,'comfort',1,'2019-11-21 14:00:02',1),(8,'commuting',1.2,'2019-11-21 14:00:02',1),(8,'mountain-bike',2.2,'2019-11-21 14:00:02',2),(8,'road',1,'2019-11-21 14:00:02',2),(8,'track',1.6,'2019-11-21 14:00:02',3),(9,'comfort',1.2,'2019-11-21 13:59:53',1),(9,'commuting',1.6,'2019-11-21 13:59:53',1),(9,'mountain-bike',2.5,'2019-11-21 13:59:53',2),(9,'road',1.2,'2019-11-21 13:59:53',2),(9,'track',2,'2019-11-21 13:59:53',3);
/*!40000 ALTER TABLE `BikePrice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BikeType`
--

DROP TABLE IF EXISTS `BikeType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BikeType` (
  `bicycle_type` varchar(100) NOT NULL DEFAULT 'ordinary',
  `updated_at_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `moderator_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`bicycle_type`),
  UNIQUE KEY `bicycle_type` (`bicycle_type`),
  KEY `moderator_id` (`moderator_id`),
  CONSTRAINT `biketype_ibfk_1` FOREIGN KEY (`moderator_id`) REFERENCES `ContentModerator` (`moderator_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BikeType`
--

LOCK TABLES `BikeType` WRITE;
/*!40000 ALTER TABLE `BikeType` DISABLE KEYS */;
INSERT INTO `BikeType` VALUES ('comfort','2019-11-21 13:59:22',5),('commuting','2019-11-21 13:59:22',3),('mountain-bike','2019-11-21 13:59:22',4),('road','2019-11-21 13:59:22',1),('track','2019-11-21 13:59:22',2);
/*!40000 ALTER TABLE `BikeType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContentModerator`
--

DROP TABLE IF EXISTS `ContentModerator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContentModerator` (
  `moderator_id` int(20) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `authorization_level` varchar(10) DEFAULT 'LEVEL1',
  `responsibility_city` varchar(40) NOT NULL DEFAULT 'Charlotte',
  `employee_num` int(11) NOT NULL,
  PRIMARY KEY (`moderator_id`),
  UNIQUE KEY `unique_moderator` (`employee_num`),
  KEY `responsibility_city_index` (`responsibility_city`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContentModerator`
--

LOCK TABLES `ContentModerator` WRITE;
/*!40000 ALTER TABLE `ContentModerator` DISABLE KEYS */;
INSERT INTO `ContentModerator` VALUES (1,'tina','Brown','tina12.moderator@mobike.com','+1234567890','SOH','CLT',887657),(2,'John','Doe','johndoe.moderator@mobike.com','+1234737370','SOH','CLT',887668),(3,'Jane','Doe','janedoe.moderator@mobike.com','+1234546320','SOH','CLT',887680),(4,'Daenerys','Targaryen','motherofdragons.moderator@mobike.com','+12345467423','SOH','SJ',887699),(5,'Tyrion','Lannister','drunk.moderator@mobike.com','+12386547423','SOH','NYC',887676);
/*!40000 ALTER TABLE `ContentModerator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) NOT NULL,
  `passwd` varchar(40) NOT NULL,
  `ssn` int(20) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `first_name` varchar(40) NOT NULL,
  `last_name` varchar(40) NOT NULL,
  `email_address` varchar(40) DEFAULT NULL,
  `address_line_1` varchar(100) DEFAULT NULL,
  `address_line_2` varchar(100) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `is_logged_in` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `ssn` (`ssn`),
  KEY `city_index` (`city`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (1,'Heet','heetzpassword',123456789,'+1 98058569','Heet','Detroja','detheet@gmail.com','Arlyn Circle','University  Bld','CLT','NC','28265','Yes'),(2,'Nan','nanzpassword',123456790,'+1 98058598','Nan','Zhang','zhanan@gmail.com','University Terrace','University  Bld','CLT','NC','28273','Yes'),(3,'Navit','navitzpassword',123456540,'+1 98053641','Navit','Grover','gronav@gmail.com','University Terrace North','University  Bld','CLT','NC','28220','yes'),(4,'Khal','khalzpassword',1234567230,'+1 98058464','Khal','Drogo','leaderOfdothraki@gmail.com','Barren lands of Essos','East of Westeros','SJ','CA','95113','Yes'),(5,'Jamie','jamiezpassword',1234514502,'+1 9805823451','Jamie','Lannister','kingslayer@gmail.com','Site of the Iron Throne','King\'s Landing','NYC','NY','10009','Yes');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerPrepaidPlan`
--

DROP TABLE IF EXISTS `CustomerPrepaidPlan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerPrepaidPlan` (
  `plan_id` int(20) NOT NULL,
  `customer_id` int(20) NOT NULL,
  `start_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `end_date` timestamp NULL DEFAULT NULL,
  `customer_plan_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`customer_plan_id`),
  UNIQUE KEY `unique_plan_subscription` (`plan_id`,`customer_id`,`end_date`),
  KEY `customer_id_foreign` (`customer_id`),
  KEY `composite_plan_id_customer_id_index` (`customer_id`,`plan_id`),
  CONSTRAINT `customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `PrepaidPlan` (`plan_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerPrepaidPlan`
--

LOCK TABLES `CustomerPrepaidPlan` WRITE;
/*!40000 ALTER TABLE `CustomerPrepaidPlan` DISABLE KEYS */;
INSERT INTO `CustomerPrepaidPlan` VALUES (1,1,'2019-11-21 14:00:37',NULL,1),(3,2,'2019-11-21 14:00:37',NULL,2),(2,3,'2019-11-21 14:00:37',NULL,3),(9,4,'2019-11-21 14:00:37',NULL,4),(5,5,'2019-11-21 14:00:37',NULL,5);
/*!40000 ALTER TABLE `CustomerPrepaidPlan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DamageReport`
--

DROP TABLE IF EXISTS `DamageReport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DamageReport` (
  `damage_report_id` int(15) NOT NULL AUTO_INCREMENT,
  `reporter_id` int(11) DEFAULT NULL,
  `bicycle_id` int(11) NOT NULL,
  `reported_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `damage_type` varchar(20) NOT NULL,
  `is_valid` bit(1) DEFAULT NULL,
  `repaired_time` timestamp NULL DEFAULT NULL,
  `reporter_type` enum('customer','assistant') DEFAULT NULL,
  `moderator_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`damage_report_id`),
  KEY `bicycle_id` (`bicycle_id`),
  KEY `moderator_id_foreign_key` (`moderator_id`),
  KEY `reporter_type_index` (`reporter_type`),
  CONSTRAINT `DamageReport_ibfk_2` FOREIGN KEY (`bicycle_id`) REFERENCES `Bicycle` (`bicycle_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `moderator_id_foreign_key` FOREIGN KEY (`moderator_id`) REFERENCES `ContentModerator` (`moderator_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DamageReport`
--

LOCK TABLES `DamageReport` WRITE;
/*!40000 ALTER TABLE `DamageReport` DISABLE KEYS */;
INSERT INTO `DamageReport` VALUES (1,1,1,'2019-11-21 14:04:17','Broken Handle',NULL,NULL,'customer',1),(2,2,2,'2019-11-21 14:04:17','Seat dislocated',NULL,NULL,'customer',2),(3,5,8,'2019-11-21 14:04:17','Wheel Punctured',NULL,NULL,'assistant',5),(4,4,12,'2019-11-21 14:04:17','Pedal broken',NULL,NULL,'assistant',4);
/*!40000 ALTER TABLE `DamageReport` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER EnsureCustomerHasPositiveBehaviorScore
BEFORE INSERT
ON DamageReport
FOR EACH ROW
BEGIN
    DECLARE lastScore DECIMAL (5,2);
    DECLARE message VARCHAR(150);
    IF NEW.reporter_type = 'customer'
    THEN
		
		SELECT 
			CAST(
				(substring_index(
					group_concat(
						cast(AH.behavior_credit as CHAR) 
							order by AH.updated_timestamp_as_unix_epoch desc
					), ',' , 1 
				))
			AS SIGNED) AS old_score
		INTO lastScore
		FROM
			AccountHistory AH
		WHERE
			AH.customer_id = NEW.reporter_id
		group by  AH.customer_id;
		
		IF 
			lastScore IS NULL
		THEN
			SELECT SUBSTRING(CONCAT(CONCAT('Customer', CAST(IFNULL(NEW.reporter_id, 'NULL') AS CHAR)), ' does not have a behavior score defined ', '.Can not create Report. '), 1, 127) INTO message ;
			signal sqlstate '45000' set message_text = message ;
		ELSEIF 
			lastScore < 90
		THEN
			SELECT SUBSTRING(CONCAT(CONCAT('Customer', CAST(IFNULL(NEW.reporter_id, 'NULL') AS CHAR)), ' has bad behavior score ', '.Can not create Report. '), 1, 127) INTO message ;
			signal sqlstate '45000' set message_text = message;
		END IF;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER EnsureNoDuplicateDamageReport
BEFORE INSERT
ON DamageReport
FOR EACH ROW
BEGIN
    DECLARE numRequestsNotFinished int;
    DECLARE message VARCHAR(150);
    IF checkBikeExists(NEW.bicycle_id) = false
    THEN
		SELECT SUBSTRING(CONCAT(CONCAT('Bicycle', CAST(IFNULL(NEW.bicycle_id, 'NULL') AS CHAR)), ' does not exist', '.Can not create report '), 1, 127) INTO message ;
		signal sqlstate '45000' set message_text = message ;
    ELSE
    -- Check if there is a pending MoveRequest already for the Bike
		SELECT 
			COUNT(bicycle_id)  num_requests INTO numRequestsNotFinished
		FROM 
			MoveRequest 
		WHERE 
			bicycle_id = NEW.bicycle_id
            AND status NOT IN ('finished','falsereport')
		GROUP BY
			bicycle_id
		LIMIT 1;
        
        IF numRequestsNotFinished IS NOT NULL AND numRequestsNotFinished > 0
        THEN
			SELECT SUBSTRING(CONCAT(CONCAT('Bicycle', CAST(IFNULL(NEW.bicycle_id, 'NULL') AS CHAR)), ' has already been reported as damaged', '.Can not create duplicate report '), 1, 127) INTO message ;
			signal sqlstate '45000' set message_text = message ;
		END IF;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER MarkBikeAsDamaged
    BEFORE INSERT
    ON DamageReport FOR EACH ROW
BEGIN
	DECLARE statusUpdated BOOLEAN;
    DECLARE message VARCHAR(100);
    DECLARE updateStatusAs VARCHAR(100);
    DECLARE bikeAlreadyMarkedAsDamaged BOOLEAN;
    SET updateStatusAs = 'damaged';
    
	SET bikeAlreadyMarkedAsDamaged = matchBikeStatus(NEW.bicycle_id, updateStatusAs);
    IF 
		bikeAlreadyMarkedAsDamaged = true
    THEN
		SELECT CONCAT( CONCAT( 'Bike: ',  CAST(NEW.bicycle_id AS CHAR) ) , CONCAT(' is already marked as damaged ', updateStatusAs )) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	ELSE
	
		CALL UpdateBikeStatus(updateStatusAs , NEW.bicycle_id , statusUpdated);
		IF 
			statusUpdated = false 
		THEN 
			SELECT CONCAT( CONCAT( 'Bike: ',  CAST(NEW.bicycle_id AS CHAR) ) , CONCAT(' status could not be updated to ', updateStatusAs )) INTO message ;
			signal sqlstate '45000' set message_text = message ;
		END IF;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER FillModeratorId
BEFORE INSERT
ON DamageReport
FOR EACH ROW
BEGIN
	IF NEW.moderator_id IS NULL
    THEN
		SET NEW.moderator_id = getModeratorWithLeastMoveRequestsLoad(NEW.bicycle_id);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER CreateMoveRequestForDamagedBike
    AFTER INSERT
    ON DamageReport FOR EACH ROW
BEGIN
	DECLARE preferredModerator int(11);
    DECLARE preferredAssistant int(100);
    DECLARE updateStatusAs VARCHAR(100);
    DECLARE pickup_latitude DECIMAL(10,8);
    DECLARE pickup_longitude DECIMAL(11,8);
    DECLARE pickup_loc varchar(150);
    DECLARE dropoff_latitude DECIMAL(10,8);
    DECLARE dropoff_longitude DECIMAL(11,8);
    DECLARE dropoff_loc varchar(150);
    DECLARE message varchar(150);
    DECLARE statusUpdated BOOLEAN;
    SET updateStatusAs = 'damaged - ready to move';
    
    -- IF MOVE REQUEST IS CREATED BY A CUSTOMER, WE CHOOSE A MODERATOR AND AN ASSISTANT FOR THE NEW MOVE REQUEST
    CALL FindRepairCentreNearestToBike(
		NEW.bicycle_id, 
		pickup_loc, 
		pickup_latitude,
		pickup_longitude,
		dropoff_loc,
		dropoff_latitude,
		dropoff_longitude
	);
    
    IF 
		NEW.moderator_id IS NOT NULL
    THEN
		SET preferredModerator = NEW.moderator_id;
    ELSE
		SET preferredModerator = getModeratorWithLeastMoveRequestsLoad(NEW.bicycle_id);
	END IF;
        
    
    IF 
		NEW.reporter_type = 'assistant' 
        AND NEW.reporter_id IS NOT NULL
    THEN
		SET preferredAssistant = NEW.reporter_id;
	ELSE
		SET preferredAssistant = getAssistantWithLeastMoveRequestsLoad(NEW.bicycle_id);
	END IF;
    
    -- CREATE A MOVE REQUEST
    INSERT INTO MoveRequest
		(
			bicycle_id, 
            moderator_id, 
            pickup_loc_name, 
            pickup_loc_latitude, 
            pickup_loc_longitude, 
            dropoff_loc_name, 
            dropoff_loc_latitude, 
            dropoff_loc_longitude, 
            assistant_id,
            req_type,
            damage_report_id,
            req_created_time
		)
    VALUES
		(
			NEW.bicycle_id, 
            preferredModerator, 
            pickup_loc, 
            pickup_latitude, 
            pickup_longitude, 
            dropoff_loc, 
            dropoff_latitude, 
            dropoff_longitude, 
            preferredAssistant,
            'repair' ,
            NEW.damage_report_id,
            current_timestamp()
		);
	
    -- UPDATE BIKE's STATUS TO 'MARKED FOR MOVE'
	CALL UpdateBikeStatus(updateStatusAs , NEW.bicycle_id , statusUpdated);
    -- NO NEED TO RAISE ERROR AS IT CAN BE TAKEN CARE OF LATER BY THE MOBIKE ASSISTANT
     IF 
	 		statusUpdated = false 
	 	THEN 
	 		SELECT CONCAT( CONCAT( 'Bike: ',  CAST(NEW.bicycle_id AS CHAR) ) , CONCAT(' status could not be updated to ', updateStatusAs )) INTO message ;
	 		signal sqlstate '45000' set message_text = message ;
	 	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER PenaliseForInvalidDamageRequest
AFTER UPDATE
ON DamageReport
FOR EACH ROW
BEGIN
	DECLARE customerId int(11);
    DECLARE historyUpdated BOOLEAN;
	IF OLD.is_valid IS NULL AND NEW.is_valid = 0
    THEN
		SELECT DR.reporter_id INTO customerId FROM DamageReport DR WHERE DR.damage_report_id = OLD.damage_report_id AND DR.reporter_type = 'customer';
        IF customerId IS NOT NULL
        THEN 
			CALL UpdateAccountHistoryForCustomer(customerId, 0, 2 , historyUpdated);
        END IF;
    END IF;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `MobikeAssistant`
--

DROP TABLE IF EXISTS `MobikeAssistant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MobikeAssistant` (
  `assistant_id` int(11) NOT NULL AUTO_INCREMENT,
  `moderator_id` int(11) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email_address` varchar(100) NOT NULL,
  `phone_number` varchar(25) NOT NULL,
  `responsibility_city` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`assistant_id`),
  UNIQUE KEY `unique_assistant` (`first_name`,`last_name`,`email_address`),
  KEY `moderator_id_foreign_key` (`moderator_id`),
  KEY `responsibility_city_index` (`responsibility_city`),
  CONSTRAINT `mobikeassistant_ibfk_1` FOREIGN KEY (`moderator_id`) REFERENCES `ContentModerator` (`moderator_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MobikeAssistant`
--

LOCK TABLES `MobikeAssistant` WRITE;
/*!40000 ALTER TABLE `MobikeAssistant` DISABLE KEYS */;
INSERT INTO `MobikeAssistant` VALUES (1,1,'Lord','Varys','varys.assistant@mobike.com','+184523231','CLT'),(2,3,'Melisandre','Fire','melisandre.assistant@mobike.com','+1874579331','CLT'),(3,4,'Jon','Snow','jonsnow.assistant@mobike.com','+1874563231','SJ'),(4,4,'Jorah','Mormont','jorahloveskhaleesi.assistant@mobike.com','+1874563231','SJ'),(5,5,'Podrick','Payne','jonsnow.assistant@mobike.com','+1874563231','NYC');
/*!40000 ALTER TABLE `MobikeAssistant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MoveRequest`
--

DROP TABLE IF EXISTS `MoveRequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MoveRequest` (
  `request_id` int(20) NOT NULL AUTO_INCREMENT,
  `bicycle_id` int(15) NOT NULL,
  `moderator_id` int(11) DEFAULT NULL,
  `pickup_loc_name` varchar(150) DEFAULT NULL,
  `dropoff_loc_name` varchar(150) DEFAULT NULL,
  `pickup_loc_latitude` decimal(10,8) DEFAULT NULL,
  `pickup_loc_longitude` decimal(11,8) DEFAULT NULL,
  `dropoff_loc_latitude` decimal(10,8) DEFAULT NULL,
  `dropoff_loc_longitude` decimal(11,8) DEFAULT NULL,
  `assistant_id` int(11) DEFAULT NULL,
  `req_created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `req_finished_time` timestamp NULL DEFAULT NULL,
  `req_type` enum('normal','repair') NOT NULL,
  `damage_report_id` int(11) DEFAULT NULL,
  `status` enum('in-process','repairnotneeded','finished','falsereport') DEFAULT 'in-process',
  PRIMARY KEY (`request_id`),
  KEY `assistant_id_foreign_key` (`assistant_id`),
  KEY `bicycle_id_foreign_key` (`bicycle_id`),
  KEY `damage_report_id_foreign_key` (`damage_report_id`),
  KEY `moderator_id_index` (`moderator_id`),
  KEY `dropoff_loc_name_index` (`dropoff_loc_name`),
  CONSTRAINT `assistant_id_foreign_key` FOREIGN KEY (`assistant_id`) REFERENCES `MobikeAssistant` (`assistant_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `bicycle_id_foreign_key` FOREIGN KEY (`bicycle_id`) REFERENCES `Bicycle` (`bicycle_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `damage_report_id_foreign_key` FOREIGN KEY (`damage_report_id`) REFERENCES `DamageReport` (`damage_report_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `moderator_id_foreign` FOREIGN KEY (`moderator_id`) REFERENCES `ContentModerator` (`moderator_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MoveRequest`
--

LOCK TABLES `MoveRequest` WRITE;
/*!40000 ALTER TABLE `MoveRequest` DISABLE KEYS */;
INSERT INTO `MoveRequest` VALUES (1,1,1,'PopMartin Student Union','Charlotte Mobike Repair Centre 1',35.29716300,-80.73492310,35.10273810,-80.79199550,1,'2019-11-21 14:04:17',NULL,'repair',1,'in-process'),(2,2,2,'Walmart Supercentre','Charlotte Mobike Repair Centre 2',35.30038350,-80.72713180,35.21499850,-80.83870990,1,'2019-11-21 14:04:17',NULL,'repair',2,'in-process'),(3,8,5,'The Public Theatre','NYC Mobike Repair Centre 1',40.72549900,-73.98754440,40.71792450,-73.98723480,5,'2019-11-21 14:04:17',NULL,'repair',3,'in-process'),(4,12,4,'Chavelas Restaurant','San Jose Mobike Repair Centre 1',37.32659110,-121.88603060,37.24610100,-121.91709580,4,'2019-11-21 14:04:17',NULL,'repair',4,'in-process');
/*!40000 ALTER TABLE `MoveRequest` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER UpdateBikeLocationOnCompletionOfMoveRequest
AFTER UPDATE
ON MoveRequest
FOR EACH ROW
BEGIN
	-- DO THIS ONLY IF THE request_finished_time is updated for the first time
    DECLARE statusUpdated BOOLEAN;
    DECLARE message VARCHAR(150);
    IF 
		OLD.req_finished_time IS NULL
        AND NEW.req_finished_time IS NOT NULL
	THEN
		UPDATE 
				Bicycle B 
			SET
				B.loc_name = OLD.dropoff_loc_name,
				B.loc_latitude = OLD.dropoff_loc_latitude,
				B.loc_longitude = OLD.dropoff_loc_longitude
			WHERE 
				B.bicycle_id = OLD.bicycle_id;
		IF
			OLD.req_type = 'normal'
		THEN
			CALL UpdateBikeStatus('available', OLD.bicycle_id, statusUpdated);
		ELSEIF
			OLD.req_type = 'repair'
		THEN
			CALL UpdateBikeStatus('damaged - sent for repair', OLD.bicycle_id, statusUpdated);
		END IF;
		
		IF statusUpdated = false OR statusUpdated IS NULL
		THEN
				SELECT CONCAT( CONCAT( 'Bike: ',  CAST(OLD.bicycle_id AS CHAR) ) , ' location and bike\'s status can not be updated ') INTO message ;
				signal sqlstate '45000' set message_text = message ;
		END IF;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `PaymentCard`
--

DROP TABLE IF EXISTS `PaymentCard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PaymentCard` (
  `credit_card_number` double NOT NULL,
  `customer_id` int(11) NOT NULL,
  `card_type` varchar(20) NOT NULL,
  `bank` varchar(20) NOT NULL,
  `expiry_date` date NOT NULL,
  `cvv_number` int(3) NOT NULL,
  PRIMARY KEY (`credit_card_number`,`customer_id`),
  UNIQUE KEY `unique_card` (`customer_id`,`credit_card_number`,`card_type`,`expiry_date`,`cvv_number`),
  CONSTRAINT `customer_id_foreign_key` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PaymentCard`
--

LOCK TABLES `PaymentCard` WRITE;
/*!40000 ALTER TABLE `PaymentCard` DISABLE KEYS */;
/*!40000 ALTER TABLE `PaymentCard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PrepaidPlan`
--

DROP TABLE IF EXISTS `PrepaidPlan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PrepaidPlan` (
  `plan_id` int(20) NOT NULL AUTO_INCREMENT,
  `plan_name` varchar(20) DEFAULT NULL,
  `cost` int(20) DEFAULT NULL,
  `valid_in_city` varchar(50) DEFAULT 'Charlotte',
  `status` enum('available','unavailable') DEFAULT 'available',
  `moderator_id` int(11) DEFAULT NULL,
  `valid_from_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `valid_till_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`plan_id`),
  UNIQUE KEY `unique_plan` (`plan_name`,`cost`,`valid_in_city`),
  KEY `moderator_id` (`moderator_id`),
  CONSTRAINT `PrepaidPlan_ibfk_1` FOREIGN KEY (`moderator_id`) REFERENCES `ContentModerator` (`moderator_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PrepaidPlan`
--

LOCK TABLES `PrepaidPlan` WRITE;
/*!40000 ALTER TABLE `PrepaidPlan` DISABLE KEYS */;
INSERT INTO `PrepaidPlan` VALUES (1,'MONTHLYFRIENDLY',15,'CLT','available',1,'2019-11-21 13:59:29',NULL),(2,'ANNUAL',7,'CLT','available',2,'2019-11-21 13:59:29',NULL),(3,'QUARTERLY',12,'CLT','available',3,'2019-11-21 13:59:29',NULL),(4,'MONTHLYFRIENDLY',15,'NYC','available',5,'2019-11-21 13:59:29',NULL),(5,'ANNUAL',7,'NYC','available',5,'2019-11-21 13:59:29',NULL),(6,'QUARTERLY',12,'NYC','available',5,'2019-11-21 13:59:29',NULL),(7,'MONTHLYFRIENDLY',15,'SJ','available',4,'2019-11-21 13:59:29',NULL),(8,'ANNUAL',7,'SJ','available',4,'2019-11-21 13:59:29',NULL),(9,'QUARTERLY',12,'SJ','available',4,'2019-11-21 13:59:29',NULL);
/*!40000 ALTER TABLE `PrepaidPlan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PromotionalCode`
--

DROP TABLE IF EXISTS `PromotionalCode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PromotionalCode` (
  `promocode_id` int(20) NOT NULL AUTO_INCREMENT,
  `promocode` varchar(20) NOT NULL,
  `valid_from_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `valid_till_time` timestamp NULL DEFAULT NULL,
  `moderator_id` int(11) DEFAULT NULL,
  `discount_percent` int(3) NOT NULL DEFAULT '0',
  `status` enum('available','unavailable') DEFAULT 'available',
  PRIMARY KEY (`promocode_id`),
  UNIQUE KEY `unique_promocode` (`promocode`,`discount_percent`),
  KEY `moderator_id` (`moderator_id`),
  CONSTRAINT `PromotionalCode_ibfk_1` FOREIGN KEY (`moderator_id`) REFERENCES `ContentModerator` (`moderator_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PromotionalCode`
--

LOCK TABLES `PromotionalCode` WRITE;
/*!40000 ALTER TABLE `PromotionalCode` DISABLE KEYS */;
INSERT INTO `PromotionalCode` VALUES (1,'NEWUSER10','2019-11-21 14:00:06',NULL,1,10,'available'),(2,'LOYALTY10','2019-11-21 14:00:06',NULL,2,10,'available'),(3,'THANKS25','2019-11-21 14:00:06',NULL,3,10,'available'),(4,'WINTER15','2019-11-21 14:00:06',NULL,5,15,'available');
/*!40000 ALTER TABLE `PromotionalCode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ride`
--

DROP TABLE IF EXISTS `Ride`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ride` (
  `ride_id` int(15) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `bicycle_id` int(11) NOT NULL,
  `start_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `end_time` timestamp NULL DEFAULT NULL,
  `start_location` varchar(150) DEFAULT NULL,
  `end_location` varchar(150) DEFAULT NULL,
  `cost` int(20) DEFAULT NULL,
  `promocode_id` int(20) DEFAULT NULL,
  `damage_report_id` int(15) DEFAULT NULL,
  `behavior_credit_change` int(20) NOT NULL DEFAULT '0',
  `start_loc_latitude` decimal(10,8) DEFAULT NULL,
  `start_loc_longitude` decimal(11,8) DEFAULT NULL,
  `end_loc_latitude` decimal(10,8) DEFAULT NULL,
  `end_loc_longitude` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`ride_id`),
  KEY `customer_id` (`customer_id`),
  KEY `bicycle_id` (`bicycle_id`),
  KEY `promocode_id` (`promocode_id`),
  KEY `damage_report_id` (`damage_report_id`),
  CONSTRAINT `Ride_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `Ride_ibfk_2` FOREIGN KEY (`bicycle_id`) REFERENCES `Bicycle` (`bicycle_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Ride_ibfk_3` FOREIGN KEY (`promocode_id`) REFERENCES `PromotionalCode` (`promocode_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `Ride_ibfk_4` FOREIGN KEY (`damage_report_id`) REFERENCES `DamageReport` (`damage_report_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ride`
--

LOCK TABLES `Ride` WRITE;
/*!40000 ALTER TABLE `Ride` DISABLE KEYS */;
INSERT INTO `Ride` VALUES (1,1,3,'2019-11-21 03:59:52','2019-11-21 14:30:31','Charlotte Country Club','Chipotle',20,NULL,NULL,0,35.25717930,-80.76859530,35.31467390,-80.74538290),(2,2,4,'2019-11-21 08:59:52','2019-11-21 14:30:41','Chipotle','Charlotte Country Club',4,NULL,NULL,0,35.31467390,-80.74538290,35.25717930,-80.76859530),(3,5,6,'2019-11-19 14:29:52','2019-11-21 14:30:45','Death & Company','Death & Company',48,NULL,NULL,0,40.72545300,-73.98453030,40.72545300,-73.98453030),(4,4,11,'2019-11-20 02:29:52','2019-11-21 14:30:50','San Jose centre for the Performing Arts','San Jose centre for the Performing Arts',43,NULL,NULL,0,37.32815680,-121.88391790,37.32815680,-121.88391790),(5,5,5,'2019-11-22 15:50:03','2019-11-22 17:53:26','Harris Teeter','Harris Teeter',3,NULL,NULL,0,35.30038350,-80.72713180,35.30038350,-80.72713180),(6,3,3,'2019-11-22 15:59:21','2019-11-22 18:00:18','Chipotle','Chipotle',4,NULL,NULL,0,35.31467390,-80.74538290,35.31467390,-80.74538290),(7,1,3,'2020-02-24 03:30:57','2020-02-24 05:34:52','Chipotle','PopMartin Student Union',4,NULL,NULL,0,35.31467390,-80.74538290,35.29716300,-80.73492310),(8,1,4,'2020-02-24 03:36:06','2020-02-24 05:37:18','Charlotte Country Club','PopMartin Student Union',2,NULL,NULL,0,35.25717930,-80.76859530,35.29716300,-80.73492310);
/*!40000 ALTER TABLE `Ride` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER EnsureBikeAvailableBeforeStartingRide
	BEFORE INSERT 
	ON Ride
	FOR EACH ROW
BEGIN 
	DECLARE message varchar(200);
    DECLARE bike_loc_name varchar(150);
    DECLARE bike_loc_lat DECIMAL(10,8);
    DECLARE bike_loc_long DECIMAL(11,8);
	IF 
		matchBikeStatus(NEW.bicycle_id, 'available') = false
    THEN
		SELECT SUBSTRING(CONCAT(CONCAT('Trigger EnsureBikeAvailableBeforeStartingRide:  ', CAST(IFNULL(NEW.bicycle_id, 'NULL') AS CHAR)), ' is not available'), 1, 127) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	ELSE
		SELECT 
			B.loc_name, 
            B.loc_latitude, 
            B.loc_longitude 
		INTO 
			bike_loc_name,
            bike_loc_lat,
            bike_loc_long
        FROM 
			Bicycle B 
        WHERE 
			B.bicycle_id = NEW.bicycle_id;
		
        IF bike_loc_name is NULL
        THEN
			SELECT SUBSTRING(CONCAT(CONCAT('Trigger EnsureBikeAvailableBeforeStartingRide. Can not determine bike\'s location for bike: ', CAST(IFNULL(NEW.bicycle_id, 'NULL') AS CHAR)), ' . '), 1, 127) INTO message ;
			signal sqlstate '45000' set message_text = message ;
		ELSE
			SET NEW.start_location = bike_loc_name ;
            SET NEW.start_loc_latitude = bike_loc_lat ;
            SET NEW.start_loc_longitude = bike_loc_long ;
        END IF;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER EnsureCustomerHasPositiveBalanceAndValidPlan
BEFORE INSERT
ON Ride
FOR EACH ROW
BEGIN
    DECLARE lastBalance DECIMAL (5,2);
    DECLARE currentPlanId int;
    DECLARE message VARCHAR(150);
    
    SELECT 
		CAST(
				(substring_index(
					group_concat(
						cast(AH.balance as CHAR) 
							order by AH.updated_timestamp_as_unix_epoch desc
					), ',' , 1 
				))
			AS DECIMAL(5,2) ) AS old_balance
			INTO lastBalance
    FROM
		AccountHistory AH
    WHERE
		AH.customer_id = NEW.customer_id
	group by  AH.customer_id;
    
    SELECT 
		CPP.plan_id INTO currentPlanId
	FROM 
		CustomerPrepaidPlan CPP
	WHERE 
		CPP.customer_id = NEW.customer_id
        AND CPP.end_date IS NULL;
    
    IF 
		lastBalance IS NULL OR lastBalance < 0
    THEN
		SELECT SUBSTRING(CONCAT(CONCAT('Can not start Ride. Account Balance is null/negative for customer: ', CAST(IFNULL(NEW.customer_id, 'NULL') AS CHAR)), '.'), 1, 127) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	ELSEIF 
		currentPlanId IS NULL
	THEN
		SELECT SUBSTRING(CONCAT(CONCAT('Can not start Ride. Customer: ', CAST(IFNULL(NEW.customer_id, 'NULL') AS CHAR)), ' is not on a valid plan'), 1, 127) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER MarkBikeInUseForRide
    BEFORE INSERT
    ON Ride FOR EACH ROW
    BEGIN
	DECLARE statusUpdated BOOLEAN;
    DECLARE message VARCHAR(100);
	CALL UpdateBikeStatus('in use', NEW.bicycle_id, statusUpdated);
    IF 
		statusUpdated = false 
	THEN 
		SELECT CONCAT( CONCAT( 'Bike: ',  CAST(NEW.bicycle_id AS CHAR) ) , ' status could not be updated to "in use" ') INTO message ;
		signal sqlstate '45000' set message_text = message ;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER CheckRideExists
BEFORE UPDATE
ON Ride
FOR EACH ROW
BEGIN
    DECLARE rideExists BOOLEAN;
    DECLARE message VARCHAR(150);
    SET rideExists = checkRideExists(NEW.ride_id);
	IF rideExists = false
    THEN 
		SELECT SUBSTRING(CONCAT(CONCAT('Ride ', CAST(IFNULL(NEW.ride_id, 'NULL') AS CHAR)), ' does not exist'), 1, 127) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER MarkBikeAvailableAfterRide
    AFTER UPDATE
    ON Ride FOR EACH ROW
BEGIN
	DECLARE statusUpdated BOOLEAN;
    DECLARE message VARCHAR(100);
	IF 
		OLD.end_location IS NULL AND NEW.end_location IS NOT NULL
	THEN
		IF 
			matchBikeStatus(NEW.bicycle_id, 'in use') = true
		THEN
			CALL UpdateBikeStatus('available', NEW.bicycle_id, statusUpdated);
			IF 
				statusUpdated = false 
			THEN 
				SELECT CONCAT( CONCAT( 'Bike: ',  CAST(OLD.bicycle_id AS CHAR) ) , ' status could not be updated to "available" ') INTO message ;
				signal sqlstate '45000' set message_text = message;
			END IF;
		END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'Mobike'
--

--
-- Dumping routines for database 'Mobike'
--
/*!50003 DROP FUNCTION IF EXISTS `calculateRideCost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculateRideCost`(rideId INT) RETURNS float
BEGIN
	DECLARE message varchar(500);
    DECLARE cost FLOAT;
    DECLARE endTimeExists BOOLEAN;
    
    SET cost = 0;
    SET endTimeExists = (
		SELECT 
			CASE WHEN R.end_time IS NULL THEN false ELSE true END
		from
			RIde R
		where
			R.ride_id = rideId
    );
    
    IF 
		endTimeExists = false
	THEN
		SELECT SUBSTRING('Function calculateRideCost : end time is null, cannot calculate cost', 1, 127) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	ELSE
		SET cost = (
			Select 
				IFNULL(round(BP.price_per_hour * timestampdiff(HOUR, R.start_time, R.end_time), 2), 0) cost_of_ride
			from 
				BikePrice BP,
				PrepaidPlan PP,
				Customer C,
				CustomerPrepaidPlan CPP,
				Bicycle B,
				RIde R
			where 
				PP.plan_id = BP.prepaid_plan_id AND
				B.bicycle_type = BP.bicycle_type AND
				CPP.plan_id = PP.plan_id AND
                CPP.end_date IS NULL AND
				CPP.customer_id = C.customer_id AND
				R.customer_id = C.customer_id AND
				R.bicycle_id = B.bicycle_id AND
				R.ride_id = rideId
		);    
	END IF;
    RETURN cost;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `canBikeBeRemoved` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `canBikeBeRemoved`(bikeId int(11)) RETURNS tinyint(1)
BEGIN 
	DECLARE bikeCurentStatus VARCHAR(50);
    SET bikeCurentStatus = (SELECT B.bic_status  FROM Bicycle B WHERE B.bicycle_id = bikeId);
    IF IFNULL(bikeCurentStatus, '') = 'in use' THEN return false;
    ELSE return true ;
    END IF ;
    return false;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `checkBikeExists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkBikeExists`(bikeId INT) RETURNS tinyint(1)
BEGIN
	DECLARE message varchar(500);
    DECLARE bikeExists BOOLEAN;
    
	IF IFNULL(bikeId, 0) = 0 OR bikeId <= 0
    THEN 
		SELECT SUBSTRING(CONCAT(CONCAT('Function checkBikeExists : invalid bikeId ', CAST(IFNULL(bikeId, 'NULL') AS CHAR)), ' . Provide a valid value for bikeId in the function call checkBikeExists(bikeId)'), 1, 127) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	ELSE 
		SET bikeExists = (
			SELECT 
				CASE WHEN B.bic_status IS NULL THEN false ELSE true END
			FROM 
				Bicycle B
			WHERE B.bicycle_id = bikeId
		);
		
		IF 
			ifnull(bikeExists, false ) = true 
        THEN 
			return true;
		ELSE 
			return false;
		END IF;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `checkRideExists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkRideExists`(rideId INT) RETURNS tinyint(1)
BEGIN
	DECLARE message varchar(500);
    DECLARE rideExists BOOLEAN;
    
	IF IFNULL(rideId, 0) = 0 OR rideId <= 0
    THEN 
		SELECT SUBSTRING(CONCAT(CONCAT('Function checkRideExists : invalid rideId ', CAST(IFNULL(rideId, 'NULL') AS CHAR)), ' . Provide a valid value for rideId in the function call checkRideExists(rideId)'), 1, 127) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	ELSE 
		SET rideExists = (
			SELECT 
				CASE WHEN R.ride_id IS NULL THEN false ELSE true END
			FROM 
				Ride R
			WHERE R.ride_id = rideId
		);
		
		IF 
			ifnull(rideExists, false ) = true 
        THEN 
			return true;
		ELSE 
			return false;
		END IF;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getAssistantWithLeastMoveRequestsLoad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getAssistantWithLeastMoveRequestsLoad`(bicycleId INT) RETURNS int(11)
BEGIN
	DECLARE preferredAssistantId int(11);
			-- GET MOBIKE ASSISTANTWITH LEAST LOAD OF MOVE REQUESTS FOR A BICYCLE WITHIN A GIVEN CITY
	SELECT assistant_id AS AssistantWithLeastLoad INTO preferredAssistantId
	FROM
	(SELECT
		COUNT(MR.request_id) num_requests_assigned,
		MR.assistant_id assistant_id
	FROM 
		MoveRequest MR,
	(SELECT MA.assistant_id assistant_id
	FROM 
		MobikeAssistant MA,
		Bicycle B
	WHERE
		B.city = MA.responsibility_city
		AND B.bicycle_id = 1
	) as CityAssistants
	WHERE
	CityAssistants.assistant_id = MR.assistant_id
	GROUP BY MR.assistant_id
	order by num_requests_assigned ASC) AssistantLoadAscending
	LIMIT 1;
	
    IF 
		preferredAssistantId IS NULL
    THEN
		SELECT MA.assistant_id INTO preferredAssistantId FROM MobikeAssistant MA, Bicycle B WHERE MA.responsibility_city = B.city LIMIT 1;
	END IF;
    
    RETURN preferredAssistantId ;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getModeratorWithLeastMoveRequestsLoad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getModeratorWithLeastMoveRequestsLoad`(bicycleId INT) RETURNS int(11)
BEGIN
	DECLARE preferredModeratorId int(11);

	-- GET MODERATOR WITH LEAST LOAD OF MOVE REQUESTS FOR A BICYCLE WITHIN A GIVEN CITY
	SELECT moderator_id AS ModeratorWithLeastLoadMoveRequests INTO preferredModeratorId
	FROM
	(SELECT
		COUNT(MR.request_id) num_requests_moderated,
		MR.moderator_id
	FROM 
		MoveRequest MR,
	(SELECT CM.moderator_id moderator_id
	FROM 
		ContentModerator CM,
		Bicycle B
	WHERE
		B.city = CM.responsibility_city
		AND B.bicycle_id = 1
	) as CityModerators
	WHERE
	CityModerators.moderator_id = MR.moderator_id
	GROUP BY MR.moderator_id
	order by num_requests_moderated ASC) ModeratorLoadAscending
	LIMIT 1;
    
    IF 
		preferredModeratorId IS NULL
    THEN
		SELECT CM.moderator_id INTO preferredModeratorId FROM ContentModerator CM, Bicycle B WHERE CM.responsibility_city = B.city LIMIT 1;
	END IF;
    
    RETURN preferredModeratorId ;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `isPromocodeValid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `isPromocodeValid`(promocode varchar(20)) RETURNS tinyint(1)
BEGIN
	DECLARE timeDiffMins INT;
    DECLARE promocodeExists BOOLEAN;
    SET promocodeExists = (
    SELECT 
			count( PC.promocode )
		FROM 
			PromotionalCode PC 
		WHERE PC.promocode = promocode
	);
    IF ifnull(promocodeExists, 0) < 1 THEN RETURN false ;
    ELSE    
		SET timeDiffMins = (
			SELECT 
				(TIMESTAMPDIFF(MINUTE, IFNULL(PC.valid_till_time, addtime(current_timestamp(), '01:00:00')), current_timestamp()))
			FROM 
				PromotionalCode PC 
			WHERE PC.promocode = promocode
		);
        
		IF IFNULL(timeDiffMins , 0 ) > 1 THEN RETURN false ;
		ELSE RETURN true;
		END IF ;
	END IF;
    RETURN false;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `matchBikeStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `matchBikeStatus`(bikeId INT, matchCurrentStatus VARCHAR(100)) RETURNS tinyint(1)
BEGIN
	DECLARE message varchar(100);
    DECLARE currentStatus varchar(100);
	IF 
		IFNULL(matchCurrentStatus, 'EMPTY') = 'EMPTY' 
    THEN 
		SELECT SUBSTRING(CONCAT(CONCAT('Function matchBikeStatus(): invalid matchCurrentStatus ', CAST(IFNULL(matchBikeStatus, 'NULL') AS CHAR)), ' . Provide a valid value for matchCurrentStatus in the function call matchBikeStatus(bikeId, matchCurrentStatus)'), 1, 127) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	ELSEIF IFNULL(bikeId, 0) = 0 OR bikeId <= 0
    THEN 
		SELECT SUBSTRING(CONCAT(CONCAT('Function matchBikeStatus(): invalid bikeId ', CAST(IFNULL(bikeId, 'NULL') AS CHAR)), ' . Provide a valid value for bikeId in the function call matchBikeStatus(bikeId, matchCurrentStatus)'), 1, 127) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	ELSE 
		IF checkBikeExists(bikeId) = true
        THEN 
			SET currentStatus = (
				SELECT 
					B.bic_status
				FROM 
					Bicycle B
				WHERE B.bicycle_id = bikeId
			);
            IF IFNULL(currentStatus, '' ) = matchCurrentStatus then return true;
			ELSE return false;
            END IF;
		ELSE 
			signal sqlstate '45000' set message_text = 'Bike - whose status match is requested - does not exist';
		END IF;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Assistants_in_city` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Assistants_in_city`(
in 	city varchar(50))
begin
select * from MobikeAssistant
where responsibility_city=city
order by assistant_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BalanceHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BalanceHistory`(
in user_id int)
begin
select updated_timestamp as time, balance
from AccountHistory
where customer_id=user_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BehaviorCreditHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BehaviorCreditHistory`(
in user_id int)
begin
select updated_timestamp as 'Time', behavior_credit as 'Behavior Credit'
from AccountHistory
where customer_id=user_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CompleteMoveRequest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CompleteMoveRequest`(
	IN moveRequestId int(11),
    OUT opSuccess BOOLEAN
)
BEGIN
	DECLARE affectedRows INT;
    DECLARE moveRequestAlreadyCompleted BOOLEAN;
    DECLARE message VARCHAR(150);
    
    SET moveRequestAlreadyCompleted = (SELECT CASE WHEN MR.req_finished_time IS NULL THEN false ELSE true END FROM MoveRequest MR WHERE MR.request_id = moveRequestId);
    IF 
		moveRequestAlreadyCompleted = true
    THEN
		SELECT CONCAT( CONCAT( 'Move Request: ',  CAST(moveRequestId AS CHAR) ) , ' is already been completed') INTO message ;
		signal sqlstate '45000' set message_text = message ;
	ELSE
		UPDATE MoveRequest MR SET MR.req_finished_time = current_timestamp() , status = 'finished' WHERE MR.request_id = moveRequestId;
		SELECT ROW_COUNT() INTO affectedRows;
		IF 
			affectedRows = 1
		THEN
			SET opSuccess = true;
		ELSE
			SET opSuccess = false;
		END IF;
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreditCard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreditCard`(
in user_id int)
begin
select credit_card_number as 'Credit Card Number', card_type as 'Card Type', bank as 'Bank', expiry_date as 'Expiry Date',cvv_number as 'CVV'
from PaymentCard
where customer_id=user_id
order by credit_card_number;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DamageHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DamageHistory`(
in bic_id int)
begin
select bicycle_id as 'Bicycle', repaired_time as 'Repaired Time', damage_type as 'Damage Type'
from DamageReport
where bicycle_id=bic_id and repaired_time is not null
order by bicycle_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EndRideWithoutOut` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EndRideWithoutOut`(
	IN end_location VARCHAR(150),
    IN end_loc_latitude DECIMAL(10, 8),
    IN end_loc_longitude DECIMAL(11, 8),
    IN rideId int(11))
BEGIN
	DECLARE statusUpdated BOOLEAN;
    DECLARE message VARCHAR(150);
    DECLARE updateStatusAs VARCHAR(100);
	DECLARE updatedRowCount int;
    DECLARE balanceUpdated BOOLEAN;
    DECLARE customerId int(11);
    DECLARE bicycleId int(11);
    DECLARE rideExists int(11);
    DECLARE rideCost float;
    DECLARE succeeded BOOLEAN;
    
    SELECT checkRideExists(rideId) INTO rideExists;
    
    IF rideExists = false
    THEN 
		SELECT SUBSTRING(CONCAT(CONCAT('Ride ', CAST(IFNULL(NEW.ride_id, 'NULL') AS CHAR)), ' does not exist'), 1, 127) INTO message ;
        signal sqlstate '45000' set message_text = message ;
	END IF;
        
    SELECT Ride.customer_id, Ride.bicycle_id INTO customerId, bicycleId from Ride where ride_id = rideId;
    
    UPDATE 
		Ride R
	SET
		R.end_location = end_location,
        R.end_loc_latitude = end_loc_latitude,
        R.end_loc_longitude = end_loc_longitude,
        R.end_time = CURRENT_TIMESTAMP()
	WHERE
		R.ride_id = rideId;
        
    SET  rideCost = calculateRideCost(rideId);
    
    SET updateStatusAs = 'available';
	
    UPDATE 
		Ride R
	SET
        R.cost = rideCost
	WHERE
		R.ride_id = rideId;
	
    SELECT R.cost INTO message FROM Ride R where R.ride_id = rideId;
    
    
	CALL UpdateBikeStatus( updateStatusAs , bicycleId , statusUpdated ) ;
    --  DO NOT RAISE ERROR AS IT WOULD PREVENT RIDE FROM GETTING ENDED AND THE RIDE WOULD STAY ON
	IF
		statusUpdated = false
	THEN 
		SELECT CONCAT( CONCAT( 'Bike: ',  CAST(bicycleId AS CHAR) ) , CONCAT(' status could not be updated to ', updateStatusAs )) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	END IF;
	
    -- Update Bike location
	UPDATE 
		Bicycle B
	SET 
		B.loc_name = end_location,
		B.loc_latitude = end_loc_latitude,
		B.loc_longitude = end_loc_longitude
	WHERE
		B.bicycle_id = bicycleId;
	
	SELECT ROW_COUNT() into updatedRowCount;
	IF
		updatedRowCount = 1
	THEN
		SET succeeded = true;
	ELSE
		SET succeeded = false;
	END IF;
    
    
	CALL UpdateAccountHistoryForCustomer(customerId, rideCost, 0, balanceUpdated);
    
	IF balanceUpdated = false THEN
		SELECT 'Account Balance can not be updated' INTO message ;
		signal sqlstate '45000' set message_text = message ;
	END IF;
    
    SET succeeded = true;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FindBikesWithinNMilesOfLatLong` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FindBikesWithinNMilesOfLatLong`(
	IN around_latitude decimal(10, 8),
	IN around_longitude decimal(11, 8),
	IN radius float
)
BEGIN
	SELECT B.bicycle_id, B.loc_latitude, B.loc_longitude, B.*,
		( 3959 * 
			acos( 
				cos( radians( around_latitude ) ) * cos ( radians( B.loc_latitude ) ) 
                * cos( radians(  B.loc_longitude ) - radians( around_longitude ) ) 
                + sin( radians( around_latitude ) ) * sin(radians(B.loc_latitude ) ) 
			) 
		) AS distance 
	FROM Bicycle B 
	HAVING distance < radius
	ORDER BY distance 
	LIMIT 0 , 20;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FindRepairCentreNearestToBike` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FindRepairCentreNearestToBike`(
	IN bikeId int(11),
    OUT pickup_loc varchar(150), 
    OUT pickup_latitude decimal(10, 8), 
    OUT pickup_longitude decimal(11, 8),
    OUT dropoff_loc varchar(150), 
    OUT dropoff_latitude decimal(10, 8), 
    OUT dropoff_longitude decimal(11, 8)
)
BEGIN
    DECLARE around_latitude DECIMAL(10,8);
    DECLARE around_longitude DECIMAL(11,8);
    DECLARE around_loc varchar(150);
    DECLARE out_latitude DECIMAL(10,8);
    DECLARE out_longitude DECIMAL(11,8);
    DECLARE out_loc varchar(150);
    DECLARE dist FLOAT;
    
    SELECT 
		B.loc_name,
        B.loc_latitude,
        B.loc_longitude
	INTO
		around_loc,
		around_latitude,
		around_longitude
	FROM 
		Bicycle B 
	WHERE 
		B.bicycle_id = bikeId;
	
    IF around_loc IS NOT NULL
    THEN
		SET pickup_loc = around_loc;
        SET pickup_latitude = around_latitude;
        SET pickup_longitude = around_longitude;
	END IF;
    
    SELECT RepairCentres.repair_centre_name, RepairCentres.repair_centre_lat, RepairCentres.repair_centre_long,
		( 3959 * 
			acos( 
				cos( radians( around_latitude ) ) * cos ( radians( RepairCentres.repair_centre_lat ) ) 
                * cos( radians(  RepairCentres.repair_centre_long ) - radians( around_longitude ) ) 
                + sin( radians( around_latitude ) ) * sin(radians( RepairCentres.repair_centre_lat ) ) 
			) 
		) AS distance_to_repair_centre
	INTO
			out_loc,
			out_latitude,
            out_longitude,
            dist
	FROM 
    (
		SELECT 
			MR.dropoff_loc_name repair_centre_name, 
			MR.dropoff_loc_latitude repair_centre_lat, 
			MR.dropoff_loc_longitude repair_centre_long
		FROM
		MoveRequest MR
		WHERE lower(MR.dropoff_loc_name) LIKE '%mobike%repair%'
    ) RepairCentres
	ORDER BY distance_to_repair_centre
	LIMIT 1;
    
    IF out_loc IS NOT NULL
    THEN 
		SET dropoff_loc = out_loc;
        SET dropoff_latitude = out_latitude;
        SET dropoff_longitude = out_longitude;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FulfillDamageReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FulfillDamageReport`(
	IN damageReportId int(11)
)
BEGIN
	DECLARE reportExists BOOLEAN;
	DECLARE alreadyFulfilled BOOLEAN;
    DECLARE message VARCHAR(150);
    DECLARE statusUpdated BOOLEAN;
    DECLARE bicycleId int(11);
    SELECT
		CASE WHEN DR.damage_report_id IS NOT NULL THEN true ELSE false END damageReportExists,
        CASE WHEN DR.repaired_time IS NULL THEN false ELSE true END damageAlreadyRepaired,
        DR.bicycle_id
	INTO 
		reportExists,
        alreadyFulfilled,
        bicycleId
	FROM 
		DamageReport DR 
	WHERE 
		DR.damage_report_id = damageReportId;
	IF reportExists = false OR reportExists  IS NULL
    THEN
		SELECT CONCAT( CONCAT( 'DamageRequest with id: ',  CAST(damageReportId AS CHAR) ) , ' does not exist') INTO message ;
		signal sqlstate '45000' set message_text = message;
	ELSE
		IF alreadyFulfilled = true
        THEN
			SELECT CONCAT( CONCAT( 'DamageRequest with id: ',  CAST(damageReportId AS CHAR) ) , ' has already been fulfilled') INTO message ;
			signal sqlstate '45000' set message_text = message;
		ELSE
			UPDATE DamageReport
            SET repaired_time = current_timestamp()
            WHERE damage_report_id = damageReportId;
            IF bicycleId IS NOT NULL THEN
					CALL UpdateBikeStatus('repaired - ready to move', bicycleId, statusUpdated);
			END IF;
        END IF;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MoveCustomerToNewPlan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MoveCustomerToNewPlan`(
	IN newPlanId INT,
    IN customerId int(11)
)
BEGIN
	DECLARE customerExists Boolean;
    DECLARE planExists Boolean;
	DECLARE currentPlanId int(11);
    DECLARE updatedRows int;
    DECLARE message varchar(150);
    SET updatedRows = 0;

	-- check if customer Exists
    SELECT CASE WHEN C.customer_id IS NULL THEN false ELSE true END INTO customerExists FROM Customer C WHERE C.customer_id = customerId;
    
    IF 
		customerExists = false
	THEN 
		SELECT SUBSTRING(CONCAT(CONCAT(CONCAT('Customer: ', CAST(IFNULL(customerId, 'NULL') AS CHAR)), '.'), 'does not exist.'), 1, 127) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	END IF;
    
    -- check if plan Exists
    SELECT CASE WHEN PP.plan_id IS NULL THEN false ELSE true END INTO planExists FROM PrepaidPlan PP WHERE PP.plan_id = newPlanId AND (PP.valid_till_time IS NULL OR (timestampdiff(DAY, current_timestamp(), PP.valid_till_time) ) > 1);
    IF 
		planExists = false
	THEN 
		SELECT SUBSTRING(CONCAT(CONCAT(CONCAT('Plan: ', CAST(IFNULL(newPlanId, 'NULL') AS CHAR)), '.'), 'does not exist.'), 1, 127) INTO message;
		signal sqlstate '45000' set message_text = message ;
	END IF;
    
    
	-- Get current plan id
	SELECT 
		CAST(
					(substring_index(
						group_concat(
							cast(CPP.plan_id as CHAR) 
								order by CPP.end_date desc
						), ',' , 1 
					))
		AS UNSIGNED) as current_plan_id INTO currentPlanId
	FROM 
		CustomerPrepaidPlan CPP
	WHERE 
		CPP.customer_id = customerId
	GROUP BY CPP.customer_id;

	-- Put an end date to current plan
	IF
		currentPlanId IS NOT NULL 
	THEN
		UPDATE 
			CustomerPrepaidPlan CPP
		SET 
			CPP.end_date = current_timestamp()
		WHERE
			CPP.customer_id = customerId AND
			CPP.plan_id = currentPlanId;
		
		SELECT ROW_COUNT() INTO updatedRows;
		IF 
			updatedRows <> 1
		THEN 
			SELECT SUBSTRING(CONCAT(CONCAT(CONCAT('Could not end current plan for customer: ', CAST(IFNULL(customerId, 'NULL') AS CHAR)), '.'), CONCAT('Current plan id is: ', CAST(currentPlanId as char))), 1, 127) INTO message ;
			signal sqlstate '45000' set message_text = message ;
		END IF;
	END IF;
    
    -- MOVE TO NEW PLAN
	INSERT INTO CustomerPrepaidPlan (plan_id, customer_id) VALUES(newPlanId, customerId);
	select row_count() into updatedRows;
	IF updatedRows <> 1 THEN
		SELECT SUBSTRING('Could not move customer to new plan. Row can not be inserted', 1, 127) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MoveRequestFor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MoveRequestFor`(
in 	MobikeAssitant_id int)
begin
select assistant_id, request_id, bicycle_id, moderator_id, pickup_loc_name, dropoff_loc_name, pickup_loc_latitude, pickup_loc_longitude, dropoff_loc_latitude, dropoff_loc_longitude, req_created_time
from MoveRequest
where assistant_id=MobikeAssitant_id
order by req_created_time;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `price_for` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `price_for`(
in plan_id int(11),
in bic_type varchar(100))
begin
select * from BikePrice
where prepaid_plan_id=plan_id and bicycle_type=bic_type
order by updated_at_timestamp
limit 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RideHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RideHistory`(
in user_id int)
begin
select start_time as 'Start Time', end_time as 'End Time', start_location as 'Start Location', end_location as 'End Location',cost as 'Cost'
from Ride
where customer_id=user_id
order by start_time;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ShowBikesInCity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ShowBikesInCity`(
in city varchar(50))
begin
select * from Bicycle B
where B.city = city;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ShowFinishedRideInCity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ShowFinishedRideInCity`(
in city varchar(50))
begin
select * from Ride R, Bicycle B
where R.bicycle_id = B.bicycle_id AND B.city = city AND R.end_time IS NOT NULL ORDER BY R.end_time DESC
LIMIT 5;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ShowOngoingRidesInCity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ShowOngoingRidesInCity`(
in city varchar(50))
begin
select * from Ride R, Bicycle B
where R.bicycle_id = B.bicycle_id AND B.city = city AND R.end_time IS NULL;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ShowStatusBikesInCity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ShowStatusBikesInCity`(
in status varchar(50),
in city varchar(50))
begin
select * from Bicycle B
where B.city = city AND bic_status = status ;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `StartRide` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `StartRide`(
in bicycleId int(11),
in customerId int(11))
begin
INSERT 
	INTO 
		Ride 
			(bicycle_id, 
            customer_id, 
            start_time
            ) 
		VALUES(
			bicycleId, 
            customerId, 
            subtime(current_timestamp(), '02:00:00')
		);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateAccountHistoryForCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateAccountHistoryForCustomer`(
IN customerId int(11),
IN balanceSub float,
IN behaviorScoreSub float,
OUT succeeded BOOLEAN
)
BEGIN
	DECLARE updatedRowCount BOOLEAN;
    DECLARE oldBalance float;
    DECLARE oldBehaviorScore int;
    DECLARE message VARCHAR(150);
    DECLARE rideExists boolean;
	
    SELECT 
		CAST(
			(substring_index(
				group_concat(
					cast(AH.balance as CHAR) 
						order by AH.updated_timestamp_as_unix_epoch desc
				), ',' , 1 
			))
		AS DECIMAL(5,2) ) AS old_balance,
		CAST(
			(substring_index(
				group_concat(
					cast(AH.behavior_credit as CHAR) 
						order by AH.updated_timestamp_as_unix_epoch desc
				), ',' , 1 
			))
		AS SIGNED) AS old_score
        INTO oldBalance, oldBehaviorScore
	FROM 
		AccountHistory AH 
	where AH.customer_id = customerId
	group by  AH.customer_id;
	
    IF 
		oldBalance IS NULL
	THEN
		SELECT SUBSTRING(CONCAT(CONCAT('Can not update accoutn balance for customer: ', CAST(IFNULL(customerId, 'NULL') AS CHAR)), ' . Customer has no row in AccountHistory and thus no balance'), 1, 127) INTO message ;
		signal sqlstate '45000' set message_text = message ;
	ELSE 
		IF oldBalance - balanceSub < 0
			THEN SET behaviorScoreSub = behaviorScoreSub + 2; -- Add 2 to the credit score subtraction
		END IF;
		INSERT INTO AccountHistory (customer_id, updated_timestamp_as_unix_epoch, updated_timestamp, balance, behavior_credit)
		VALUES (customerId, unix_timestamp(), current_timestamp(), oldBalance - balanceSub, oldBehaviorScore - behaviorScoreSub);
	END IF;
	
	SELECT row_count() INTO updatedRowCount;
    
    IF 
		updatedRowCount = 1
	THEN
		SET SUCCEEDED = true;
	ELSE
		SET SUCCEEDED = false;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateBikeStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBikeStatus`(in status varchar(100), in bikeId int(11) , OUT succesful BOOLEAN)
BEGIN
	DECLARE updatedRows int;
	Update 
		Bicycle B 
	SET B.bic_status = status
	WHERE
		B.bicycle_id = bikeId;
	SET succesful = true;
    -- row_count is Unreliable
    -- SELECT row_count() INTO updatedRows;
	--     IF updatedRows > 0 THEN SET succesful = true ;
	--    ELSE SET succesful = false ;
    -- 	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ValidateDamageReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ValidateDamageReport`(
	IN damageReportId int(11),
    IN is_dr_valid BIT
)
BEGIN
	DECLARE reportExists BOOLEAN;
	DECLARE alreadyValidated BOOLEAN;
    DECLARE bicycleId int(11);
    DECLARE moveRequestId int(11);
    DECLARE statusUpdated BOOLEAN;
    DECLARE message VARCHAR(150);
    
	SELECT
		CASE WHEN DR.damage_report_id IS NOT NULL THEN true ELSE false END damageReportExists,
        CASE WHEN DR.is_valid IS NULL THEN false ELSE true END damageAlreadyValidated,
        DR.bicycle_id
	INTO 
		reportExists,
        alreadyValidated,
        bicycleId
	FROM 
		DamageReport DR 
	WHERE 
		DR.damage_report_id = damageReportId;
	IF reportExists = false OR reportExists  IS NULL
    THEN
		SELECT CONCAT( CONCAT( 'DamageRequest with id: ',  CAST(damageReportId AS CHAR) ) , ' does not exist') INTO message ;
		signal sqlstate '45000' set message_text = message ;
	ELSE
		IF alreadyValidated = true
        THEN
			SELECT CONCAT( CONCAT( 'DamageRequest with id: ',  CAST(damageReportId AS CHAR) ) , ' has already been validated') INTO message ;
			signal sqlstate '45000' set message_text = message ;
		ELSE
			IF is_dr_valid = 1
            THEN 
				UPDATE DamageReport
				SET is_valid = 1
				WHERE damage_report_id = damageReportId;
			ELSEIF is_dr_valid = 0
            THEN
				SELECT MV.request_id 
                INTO moveRequestId
                FROM 
					DamageReport DR,
					MoveRequest MV
				WHERE 
					MV.damage_report_id = DR.damage_report_id;
				
                IF moveRequestId IS NOT NULL
                THEN
					UPDATE MoveRequest
                    SET status = 'falsereport'
                    WHERE request_id = moveRequestId;
                END IF;
                    
				UPDATE DamageReport
				SET is_valid = 0, repaired_time = current_timestamp()
				WHERE damage_report_id = damageReportId;
                IF bicycleId IS NOT NULL THEN
					CALL UpdateBikeStatus('available', bicycleId, statusUpdated);
				END IF;
            END IF;
        END IF;
	END IF;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-03 16:30:19
