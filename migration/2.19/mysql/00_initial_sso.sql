-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: bear-api-prod-cluster.cluster-ctcfk2m5eqck.eu-west-1.rds.amazonaws.com    Database: sso2
-- ------------------------------------------------------
-- Server version	5.7.12

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `emails_project` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'amv2',
  `ui_url` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'https://argoflow.io',
  `ui_password_reset_url` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'https://argoflow.io/set-new-password?security-code=%s',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` VALUES (3,'Argoflow Manager','amv2','https://k8s-manager.argoflow.io','https://k8s-manager.argoflow.io/set-new-password?security-code=%s');
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applications_products`
--

DROP TABLE IF EXISTS `applications_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applications_products` (
  `application_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `product_application_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Internal application_id in a product',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`application_id`,`product_id`),
  UNIQUE KEY `applications_products__unique` (`application_id`,`product_id`),
  KEY `applications_products__products_idx` (`product_id`),
  CONSTRAINT `applications_products__applications` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `applications_products__products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications_products`
--

LOCK TABLES `applications_products` WRITE;
/*!40000 ALTER TABLE `applications_products` DISABLE KEYS */;
INSERT INTO `applications_products` VALUES (3, 2, '', 1, '2023-01-01 00:00:00', NULL);
/*!40000 ALTER TABLE `applications_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_services`
--

DROP TABLE IF EXISTS `external_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_services` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  `application_id` int(10) unsigned NOT NULL,
  `sub_organization_settings` text COLLATE utf8_unicode_ci,
  `sub_organization_limits` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `external_services__applications_idx` (`application_id`),
  CONSTRAINT `external_services__applications` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `external_services__organization` FOREIGN KEY (`id`) REFERENCES `organizations` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gar_sessions`
--

DROP TABLE IF EXISTS `gar_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gar_sessions` (
  `session_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `ticket` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`session_id`),
  UNIQUE KEY `session_ticket` (`session_id`,`ticket`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gar_tickets`
--

DROP TABLE IF EXISTS `gar_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gar_tickets` (
  `ticket` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `external_user_id` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ticket`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `languages_code` (`code`),
  KEY `languages_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'FR','Français'),(2,'EN','English'),(3,'IT','Italiano'),(4,'RU','Русский'),(5,'ES','Español (Spain)'),(6,'PT','Português'),(7,'DE','Deutsch'),(8,'TR','Turkish'),(9,'ZH','中文'),(10,'JA','日本語'),(11,'KO','한국어'),(12,'NL','Nederlands'),(13,'BG','Български език'),(14,'AR','العربية'),(15,'RO','Română'),(16,'DA','Dansk'),(17,'NO','Norsk'),(18,'SV','Svenska'),(19,'MX','Español (Mexico)'),(20,'CZ','Česky'),(21,'HU','Magyar'),(22,'PL','Polski'),(23,'SK','Slovenčina'),(24,'SR','Српски'),(25,'TH','ไทย'),(26,'VI','Tiếng Việt'),(27,'ID','Indonesian'),(28,'EL','ελληνικά'),(33,'PT-BR','Brazil'),(34,'ZH-HK','香港特別行政區'),(35,'ZH-TW','中華民國');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `language_id` int(10) unsigned NOT NULL,
  `is_multiorganization` tinyint(1) NOT NULL DEFAULT '0',
  `parent_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `limits` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'JSON with Global organization’s limits. E.g. amount of users allowed.',
  `settings` text COLLATE utf8_unicode_ci COMMENT 'Settings for all products. E.g.\n{\n  "bapi": {\n    "limits": {\n      "scans": 1000,\n      "markers": 100\n    }\n  },\n  "wapi": {\n    "pages": 100\n  }\n}',
  `favicon` longtext COLLATE utf8_unicode_ci,
  `payment_notification` longtext COLLATE utf8_unicode_ci,
  `payment_notification_state_id` int(11) NOT NULL DEFAULT '0',
  `contact_email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `organizations__name` (`name`),
  KEY `organizations__parent_name` (`parent_id`,`name`),
  KEY `organizations__languages_idx` (`language_id`),
  CONSTRAINT `organizations__languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6479 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations`
--

LOCK TABLES `organizations` WRITE;
/*!40000 ALTER TABLE `organizations` DISABLE KEYS */;
INSERT INTO `organizations` VALUES (1,'Migration organization',1,1,NULL,1,0,'2022-07-18 15:44:19',NULL,NULL,NULL,'{}',NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations_external_ids`
--

DROP TABLE IF EXISTS `organizations_external_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizations_external_ids` (
  `organization_id` int(10) unsigned NOT NULL,
  `service_id` int(10) unsigned NOT NULL,
  `id` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`organization_id`,`service_id`),
  UNIQUE KEY `organizations_external_ids__service_id` (`service_id`,`id`),
  KEY `organizations_external_ids__services_idx` (`service_id`),
  CONSTRAINT `organizations_external_ids__organizations` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `organizations_external_ids__services` FOREIGN KEY (`service_id`) REFERENCES `external_services` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organizations_products`
--

DROP TABLE IF EXISTS `organizations_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizations_products` (
  `organization_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `product_organization_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Internal organization_id in a product',
  `product_parent_organization_id` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subscription_start_date` timestamp NULL DEFAULT NULL,
  `subscription_end_date` timestamp NULL DEFAULT NULL,
  `subscription_to_be_renewed` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 means this organization will receive a notification to renew the subscription',
  PRIMARY KEY (`organization_id`,`product_id`),
  UNIQUE KEY `organizations_products__unique` (`organization_id`,`product_id`),
  KEY `organizations_products__products_idx` (`product_id`),
  KEY `organizations_products_subscription_start` (`product_id`,`subscription_start_date`),
  KEY `organizations_products_subscription_end` (`product_id`,`subscription_end_date`),
  CONSTRAINT `organizations_products__organizations` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `organizations_products__products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `api` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `token` text COLLATE utf8_unicode_ci COMMENT 'Encrypted product token',
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (2,'wapi','Argoflow API','{{AF_API_URL}}',1,'2021-01-01 00:00:00',NULL,'{{TOKEN}}','Augmented PDF');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles__name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (0,'User','Manage their own and non private projects within their organization; Do not have access to the private projects of his team mates, cannot unlock and edit locked projects','2022-10-17 12:29:26'),(1,'Admin','Manage organizations settings;\nCan create suborganizations;\nManage users within their organization and suborganization (add new, delete) according to the quotas available by the plan;\nManage the team projects (create, edit or delete any project), can modify locked or private projects and sees everything within the account.;\nCan see the subscription data (invoice history...) but cannot change it (updrage, downgrade, subscribe...);\nHas access to Members menu and Messages (ARGOplay);\nCan see projects of subsorganizations;','2022-10-17 12:29:26'),(2,'Account Manager','Admin + Manage organizations, quotes and limits','2022-10-17 12:29:26'),(3,'Owner','Admin + rights to manage account subscriptions and billings (When we will reintroduce online subscription with Stripe); Owner has access to the invoice history, can subscribe to additional seats or quotas, upgrade the subscription, cancel plan and will receive all emails related to invoices ','2022-10-17 12:29:26'),(4,'Super Admin','GOD like, he owns every rights and beyond; The only role allowed to create organizations','2022-10-17 12:29:26');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_migrations` (
  `version` bigint(20) NOT NULL,
  `dirty` tinyint(1) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES (9,0);
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL DEFAULT '0',
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(250) COLLATE utf8_unicode_ci NOT NULL COMMENT 'password hash',
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language_id` int(10) unsigned NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `if_mfa_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If Multi-factor authentication is enabled for a user',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar` longtext COLLATE utf8_unicode_ci,
  `notes` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `is_system_account` tinyint(1) NOT NULL DEFAULT '0',
  `application_id` int(10) unsigned DEFAULT '3',
  `is_read_only` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users__email__application_id` (`email`,`application_id`),
  KEY `users__organizations_idx` (`organization_id`),
  KEY `users__organization_first_name` (`organization_id`,`first_name`),
  KEY `users__organization_last_name` (`organization_id`,`last_name`),
  KEY `users__languages_idx` (`language_id`),
  KEY `users__roles_idx` (`role_id`),
  KEY `users__applications_idx` (`application_id`),
  CONSTRAINT `users__applications` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `users__languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `users__organizations` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `users__roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28405 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,4,'argoflow-migration-super-admin@ar-go.co','yy26e9xDLKe8pXtN','Migration','Admin',2,1,0,0,NULL,NULL,NULL,'2022-10-28 15:17:43','2023-01-26 09:46:40',NULL,0,3,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_external_ids`
--

DROP TABLE IF EXISTS `users_external_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_external_ids` (
  `user_id` int(10) unsigned NOT NULL,
  `service_id` int(10) unsigned NOT NULL,
  `id` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`service_id`),
  UNIQUE KEY `users_external_ids__service_id` (`service_id`,`id`),
  KEY `users_external_ids__services_idx` (`service_id`),
  CONSTRAINT `users_external_ids__services` FOREIGN KEY (`service_id`) REFERENCES `external_services` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `users_external_ids__users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_password_reset_codes`
--

DROP TABLE IF EXISTS `users_password_reset_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_password_reset_codes` (
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `application_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`email`,`application_id`),
  KEY `users_password_reset_codes__applications_idx` (`application_id`),
  CONSTRAINT `users_password_reset_codes__applications` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_products`
--

DROP TABLE IF EXISTS `users_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_products` (
  `user_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `product_user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Internal user_id in a product',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`product_id`),
  UNIQUE KEY `users_products__unique` (`user_id`,`product_id`),
  KEY `users_products__products_idx` (`product_id`),
  CONSTRAINT `users_products__products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_products__users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_sessions`
--

DROP TABLE IF EXISTS `users_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_sessions` (
  `user_id` int(10) unsigned NOT NULL,
  `origin` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `session_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`origin`),
  CONSTRAINT `users_sessions__users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-11 16:19:44

-- Organization
DROP TRIGGER IF EXISTS `organizations_BEFORE_UPDATE`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `organizations_BEFORE_UPDATE` BEFORE UPDATE ON `organizations` FOR EACH ROW
BEGIN
	SET NEW.updated_at = NOW();
END$$
DELIMITER ;

-- Users
DROP TRIGGER IF EXISTS `users_BEFORE_UPDATE`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `users_BEFORE_UPDATE` BEFORE UPDATE ON `users` FOR EACH ROW
BEGIN
	SET NEW.updated_at = NOW();
END$$
DELIMITER ;