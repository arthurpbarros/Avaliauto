-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: banco
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add Token',1,'add_token'),(2,'Can change Token',1,'change_token'),(3,'Can delete Token',1,'delete_token'),(4,'Can view Token',1,'view_token'),(5,'Can add token',2,'add_tokenproxy'),(6,'Can change token',2,'change_tokenproxy'),(7,'Can delete token',2,'delete_tokenproxy'),(8,'Can view token',2,'view_tokenproxy'),(9,'Can add user',3,'add_user'),(10,'Can change user',3,'change_user'),(11,'Can delete user',3,'delete_user'),(12,'Can view user',3,'view_user'),(13,'Can add type',4,'add_type'),(14,'Can change type',4,'change_type'),(15,'Can delete type',4,'delete_type'),(16,'Can view type',4,'view_type'),(17,'Can add vehicle',5,'add_vehicle'),(18,'Can change vehicle',5,'change_vehicle'),(19,'Can delete vehicle',5,'delete_vehicle'),(20,'Can view vehicle',5,'view_vehicle'),(21,'Can add consultancy',6,'add_consultancy'),(22,'Can change consultancy',6,'change_consultancy'),(23,'Can delete consultancy',6,'delete_consultancy'),(24,'Can view consultancy',6,'view_consultancy'),(25,'Can add log entry',7,'add_logentry'),(26,'Can change log entry',7,'change_logentry'),(27,'Can delete log entry',7,'delete_logentry'),(28,'Can view log entry',7,'view_logentry'),(29,'Can add permission',8,'add_permission'),(30,'Can change permission',8,'change_permission'),(31,'Can delete permission',8,'delete_permission'),(32,'Can view permission',8,'view_permission'),(33,'Can add group',9,'add_group'),(34,'Can change group',9,'change_group'),(35,'Can delete group',9,'delete_group'),(36,'Can view group',9,'view_group'),(37,'Can add content type',10,'add_contenttype'),(38,'Can change content type',10,'change_contenttype'),(39,'Can delete content type',10,'delete_contenttype'),(40,'Can view content type',10,'view_contenttype'),(41,'Can add session',11,'add_session'),(42,'Can change session',11,'change_session'),(43,'Can delete session',11,'delete_session'),(44,'Can view session',11,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_avaliauto_api_user_id` FOREIGN KEY (`user_id`) REFERENCES `avaliauto_api_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliauto_api_consultancy`
--

DROP TABLE IF EXISTS `avaliauto_api_consultancy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliauto_api_consultancy` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `data` datetime(6) NOT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `local` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `client_id` bigint NOT NULL,
  `mechanical_id` bigint DEFAULT NULL,
  `vehicle_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `avaliauto_api_consul_client_id_5ca42e0e_fk_avaliauto` (`client_id`),
  KEY `avaliauto_api_consul_mechanical_id_2814fe42_fk_avaliauto` (`mechanical_id`),
  KEY `avaliauto_api_consul_vehicle_id_b23bb8ea_fk_avaliauto` (`vehicle_id`),
  CONSTRAINT `avaliauto_api_consul_client_id_5ca42e0e_fk_avaliauto` FOREIGN KEY (`client_id`) REFERENCES `avaliauto_api_user` (`id`),
  CONSTRAINT `avaliauto_api_consul_mechanical_id_2814fe42_fk_avaliauto` FOREIGN KEY (`mechanical_id`) REFERENCES `avaliauto_api_user` (`id`),
  CONSTRAINT `avaliauto_api_consul_vehicle_id_b23bb8ea_fk_avaliauto` FOREIGN KEY (`vehicle_id`) REFERENCES `avaliauto_api_vehicle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliauto_api_consultancy`
--

LOCK TABLES `avaliauto_api_consultancy` WRITE;
/*!40000 ALTER TABLE `avaliauto_api_consultancy` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliauto_api_consultancy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliauto_api_type`
--

DROP TABLE IF EXISTS `avaliauto_api_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliauto_api_type` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliauto_api_type`
--

LOCK TABLES `avaliauto_api_type` WRITE;
/*!40000 ALTER TABLE `avaliauto_api_type` DISABLE KEYS */;
INSERT INTO `avaliauto_api_type` VALUES (1,'Cliente'),(2,'Mecânico');
/*!40000 ALTER TABLE `avaliauto_api_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliauto_api_user`
--

DROP TABLE IF EXISTS `avaliauto_api_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliauto_api_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `tel` varchar(11) NOT NULL,
  `type_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `avaliauto_api_user_type_id_dde90ac0_fk_avaliauto_api_type_id` (`type_id`),
  CONSTRAINT `avaliauto_api_user_type_id_dde90ac0_fk_avaliauto_api_type_id` FOREIGN KEY (`type_id`) REFERENCES `avaliauto_api_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliauto_api_user`
--

LOCK TABLES `avaliauto_api_user` WRITE;
/*!40000 ALTER TABLE `avaliauto_api_user` DISABLE KEYS */;
INSERT INTO `avaliauto_api_user` VALUES (2,'2022-05-15 03:04:14.015829',0,'2022-05-15 03:01:15.518218','admin@gmail.com','user','pbkdf2_sha256$320000$DBIzm9gZdtJ0CRt7uu8Xpr$N/64yAMm3hJb7+fXWS3gzIZLLDLKVIWHdCrqNZVnzJM=','','',1,1,'',1),(3,'2022-05-15 03:04:53.010122',1,'2022-05-15 03:02:51.245570','admin2@gmail.com','user','pbkdf2_sha256$320000$E5eMRMAGohHKnjmcqr4vxy$IlyncbaklkyykQcqFfG+XDOKB+3zz6llqnkEuFz//G4=','','',1,1,'',1);
/*!40000 ALTER TABLE `avaliauto_api_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliauto_api_user_groups`
--

DROP TABLE IF EXISTS `avaliauto_api_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliauto_api_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `avaliauto_api_user_groups_user_id_group_id_6c7d8748_uniq` (`user_id`,`group_id`),
  KEY `avaliauto_api_user_groups_group_id_05608086_fk_auth_group_id` (`group_id`),
  CONSTRAINT `avaliauto_api_user_g_user_id_30c065d7_fk_avaliauto` FOREIGN KEY (`user_id`) REFERENCES `avaliauto_api_user` (`id`),
  CONSTRAINT `avaliauto_api_user_groups_group_id_05608086_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliauto_api_user_groups`
--

LOCK TABLES `avaliauto_api_user_groups` WRITE;
/*!40000 ALTER TABLE `avaliauto_api_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliauto_api_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliauto_api_user_user_permissions`
--

DROP TABLE IF EXISTS `avaliauto_api_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliauto_api_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `avaliauto_api_user_user__user_id_permission_id_a2fb85d9_uniq` (`user_id`,`permission_id`),
  KEY `avaliauto_api_user_u_permission_id_220207f9_fk_auth_perm` (`permission_id`),
  CONSTRAINT `avaliauto_api_user_u_permission_id_220207f9_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `avaliauto_api_user_u_user_id_6bf5be9d_fk_avaliauto` FOREIGN KEY (`user_id`) REFERENCES `avaliauto_api_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliauto_api_user_user_permissions`
--

LOCK TABLES `avaliauto_api_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `avaliauto_api_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliauto_api_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliauto_api_vehicle`
--

DROP TABLE IF EXISTS `avaliauto_api_vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliauto_api_vehicle` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `brand` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `year` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliauto_api_vehicle`
--

LOCK TABLES `avaliauto_api_vehicle` WRITE;
/*!40000 ALTER TABLE `avaliauto_api_vehicle` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliauto_api_vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_avaliauto_api_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_avaliauto_api_user_id` FOREIGN KEY (`user_id`) REFERENCES `avaliauto_api_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (7,'admin','logentry'),(9,'auth','group'),(8,'auth','permission'),(1,'authtoken','token'),(2,'authtoken','tokenproxy'),(6,'avaliauto_api','consultancy'),(4,'avaliauto_api','type'),(3,'avaliauto_api','user'),(5,'avaliauto_api','vehicle'),(10,'contenttypes','contenttype'),(11,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-05-15 03:00:21.707400'),(2,'contenttypes','0002_remove_content_type_name','2022-05-15 03:00:21.894900'),(3,'auth','0001_initial','2022-05-15 03:00:22.816775'),(4,'auth','0002_alter_permission_name_max_length','2022-05-15 03:00:22.988650'),(5,'auth','0003_alter_user_email_max_length','2022-05-15 03:00:23.004220'),(6,'auth','0004_alter_user_username_opts','2022-05-15 03:00:23.019915'),(7,'auth','0005_alter_user_last_login_null','2022-05-15 03:00:23.035473'),(8,'auth','0006_require_contenttypes_0002','2022-05-15 03:00:23.051152'),(9,'auth','0007_alter_validators_add_error_messages','2022-05-15 03:00:23.066785'),(10,'auth','0008_alter_user_username_max_length','2022-05-15 03:00:23.082350'),(11,'auth','0009_alter_user_last_name_max_length','2022-05-15 03:00:23.098036'),(12,'auth','0010_alter_group_name_max_length','2022-05-15 03:00:23.129293'),(13,'auth','0011_update_proxy_permissions','2022-05-15 03:00:23.144850'),(14,'auth','0012_alter_user_first_name_max_length','2022-05-15 03:00:23.160477'),(15,'avaliauto_api','0001_initial','2022-05-15 03:00:24.816723'),(16,'admin','0001_initial','2022-05-15 03:00:25.207348'),(17,'admin','0002_logentry_remove_auto_add','2022-05-15 03:00:25.222986'),(18,'admin','0003_logentry_add_action_flag_choices','2022-05-15 03:00:25.238598'),(19,'authtoken','0001_initial','2022-05-15 03:00:25.488598'),(20,'authtoken','0002_auto_20160226_1747','2022-05-15 03:00:25.519901'),(21,'authtoken','0003_tokenproxy','2022-05-15 03:00:25.535536'),(22,'sessions','0001_initial','2022-05-15 03:00:25.629223');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('fi0do2i7rqs6b8fnfye3q6ernufls05p','.eJxVjEEOwiAQRe_C2hDAaWFcuu8ZCDCDVA0kpV0Z765NutDtf-_9l_BhW4vfOi9-JnERZ3H63WJID647oHuotyZTq-syR7kr8qBdTo34eT3cv4MSevnWOeoBkskZNcCYMLBiJGMVYmQEY1MkZY22YEeEoFzGAbKzLhIgM4n3B-GPN80:1nq4Yv:HVZh_QoCiE3DWXP7rh404GKCemibQWRVjc3Jbeznars','2022-05-29 03:04:53.017116');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-15  0:11:28
