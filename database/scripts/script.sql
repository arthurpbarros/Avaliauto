-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: banco
-- ------------------------------------------------------
-- Server version	5.7.38-log

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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add Token',1,'add_token'),(2,'Can change Token',1,'change_token'),(3,'Can delete Token',1,'delete_token'),(4,'Can view Token',1,'view_token'),(5,'Can add token',2,'add_tokenproxy'),(6,'Can change token',2,'change_tokenproxy'),(7,'Can delete token',2,'delete_tokenproxy'),(8,'Can view token',2,'view_tokenproxy'),(9,'Can add user',3,'add_user'),(10,'Can change user',3,'change_user'),(11,'Can delete user',3,'delete_user'),(12,'Can view user',3,'view_user'),(13,'Can add type',4,'add_type'),(14,'Can change type',4,'change_type'),(15,'Can delete type',4,'delete_type'),(16,'Can view type',4,'view_type'),(17,'Can add consultancy',5,'add_consultancy'),(18,'Can change consultancy',5,'change_consultancy'),(19,'Can delete consultancy',5,'delete_consultancy'),(20,'Can view consultancy',5,'view_consultancy'),(21,'Can add log entry',6,'add_logentry'),(22,'Can change log entry',6,'change_logentry'),(23,'Can delete log entry',6,'delete_logentry'),(24,'Can view log entry',6,'view_logentry'),(25,'Can add permission',7,'add_permission'),(26,'Can change permission',7,'change_permission'),(27,'Can delete permission',7,'delete_permission'),(28,'Can view permission',7,'view_permission'),(29,'Can add group',8,'add_group'),(30,'Can change group',8,'change_group'),(31,'Can delete group',8,'delete_group'),(32,'Can view group',8,'view_group'),(33,'Can add content type',9,'add_contenttype'),(34,'Can change content type',9,'change_contenttype'),(35,'Can delete content type',9,'delete_contenttype'),(36,'Can view content type',9,'view_contenttype'),(37,'Can add session',10,'add_session'),(38,'Can change session',10,'change_session'),(39,'Can delete session',10,'delete_session'),(40,'Can view session',10,'view_session');
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
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_avaliauto_api_user_id` FOREIGN KEY (`user_id`) REFERENCES `avaliauto_api_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `data` datetime(6) NOT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `cep` varchar(50) NOT NULL,
  `rua` varchar(255) NOT NULL,
  `numero` varchar(50) NOT NULL,
  `bairro` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `vehicle_model` varchar(255) NOT NULL,
  `vehicle_year` int(11) DEFAULT NULL,
  `client_id` bigint(20) NOT NULL,
  `mechanical_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `avaliauto_api_consul_client_id_5ca42e0e_fk_avaliauto` (`client_id`),
  KEY `avaliauto_api_consul_mechanical_id_2814fe42_fk_avaliauto` (`mechanical_id`),
  CONSTRAINT `avaliauto_api_consul_client_id_5ca42e0e_fk_avaliauto` FOREIGN KEY (`client_id`) REFERENCES `avaliauto_api_user` (`id`),
  CONSTRAINT `avaliauto_api_consul_mechanical_id_2814fe42_fk_avaliauto` FOREIGN KEY (`mechanical_id`) REFERENCES `avaliauto_api_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
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
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `type_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `avaliauto_api_user_type_id_dde90ac0_fk_avaliauto_api_type_id` (`type_id`),
  CONSTRAINT `avaliauto_api_user_type_id_dde90ac0_fk_avaliauto_api_type_id` FOREIGN KEY (`type_id`) REFERENCES `avaliauto_api_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliauto_api_user`
--

LOCK TABLES `avaliauto_api_user` WRITE;
/*!40000 ALTER TABLE `avaliauto_api_user` DISABLE KEYS */;
INSERT INTO `avaliauto_api_user` VALUES (1,NULL,0,'2022-06-24 00:27:52.081807','sandro.paiva@gmail.com','user','pbkdf2_sha256$320000$NGKpryUQzoZC8w4nVEOu9L$DZHJH5HyR35+jvZr4ghECjSA9zBPxVQKHntr8GA6cvg=','Sandro','Paiva',0,1,'84954124568',1),(2,NULL,0,'2022-06-24 00:29:09.235120','arthur.pinheiro@gmail.com','user','pbkdf2_sha256$320000$24iU3gRUqnXYGQxl0uF6Y3$gTLBG3WvqhJA0jxWP45abUoCVLaDnrK8MWRNnzL7Ebk=','Arthur','Pinheiro',0,1,'84912457845',1),(3,NULL,0,'2022-06-24 00:29:34.523485','guilherme.hendres@gmail.com','user','pbkdf2_sha256$320000$dAM1x542gEHIheDhjha27Z$G9QQ97imHb42jrIsEQ0b7XsaqwOHntk1/txhBBDp1lA=','Guilherme','Hendres',0,1,'8448125698',1),(4,NULL,0,'2022-06-24 00:29:57.587157','antonio.saraiva@gmail.com','user','pbkdf2_sha256$320000$lr8NuRuZunVj0zpAM5tOYJ$eu8JqXcbfgYw/ZVpaEW196NHZTY0k+YC4tjjcRqp/2M=','Antonio','Saraiva',0,1,'8448125698',2);
/*!40000 ALTER TABLE `avaliauto_api_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliauto_api_user_groups`
--

DROP TABLE IF EXISTS `avaliauto_api_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliauto_api_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `avaliauto_api_user_groups_user_id_group_id_6c7d8748_uniq` (`user_id`,`group_id`),
  KEY `avaliauto_api_user_groups_group_id_05608086_fk_auth_group_id` (`group_id`),
  CONSTRAINT `avaliauto_api_user_g_user_id_30c065d7_fk_avaliauto` FOREIGN KEY (`user_id`) REFERENCES `avaliauto_api_user` (`id`),
  CONSTRAINT `avaliauto_api_user_groups_group_id_05608086_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `avaliauto_api_user_user__user_id_permission_id_a2fb85d9_uniq` (`user_id`,`permission_id`),
  KEY `avaliauto_api_user_u_permission_id_220207f9_fk_auth_perm` (`permission_id`),
  CONSTRAINT `avaliauto_api_user_u_permission_id_220207f9_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `avaliauto_api_user_u_user_id_6bf5be9d_fk_avaliauto` FOREIGN KEY (`user_id`) REFERENCES `avaliauto_api_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliauto_api_user_user_permissions`
--

LOCK TABLES `avaliauto_api_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `avaliauto_api_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliauto_api_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_avaliauto_api_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_avaliauto_api_user_id` FOREIGN KEY (`user_id`) REFERENCES `avaliauto_api_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (6,'admin','logentry'),(8,'auth','group'),(7,'auth','permission'),(1,'authtoken','token'),(2,'authtoken','tokenproxy'),(5,'avaliauto_api','consultancy'),(4,'avaliauto_api','type'),(3,'avaliauto_api','user'),(9,'contenttypes','contenttype'),(10,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-06-24 00:12:47.658401'),(2,'contenttypes','0002_remove_content_type_name','2022-06-24 00:12:48.145893'),(3,'auth','0001_initial','2022-06-24 00:12:49.636922'),(4,'auth','0002_alter_permission_name_max_length','2022-06-24 00:12:49.693174'),(5,'auth','0003_alter_user_email_max_length','2022-06-24 00:12:49.714132'),(6,'auth','0004_alter_user_username_opts','2022-06-24 00:12:49.735365'),(7,'auth','0005_alter_user_last_login_null','2022-06-24 00:12:49.758369'),(8,'auth','0006_require_contenttypes_0002','2022-06-24 00:12:49.766730'),(9,'auth','0007_alter_validators_add_error_messages','2022-06-24 00:12:49.788941'),(10,'auth','0008_alter_user_username_max_length','2022-06-24 00:12:49.803343'),(11,'auth','0009_alter_user_last_name_max_length','2022-06-24 00:12:49.816376'),(12,'auth','0010_alter_group_name_max_length','2022-06-24 00:12:49.849258'),(13,'auth','0011_update_proxy_permissions','2022-06-24 00:12:49.862703'),(14,'auth','0012_alter_user_first_name_max_length','2022-06-24 00:12:49.877788'),(15,'avaliauto_api','0001_initial','2022-06-24 00:12:51.137702'),(16,'admin','0001_initial','2022-06-24 00:12:51.452362'),(17,'admin','0002_logentry_remove_auto_add','2022-06-24 00:12:51.473213'),(18,'admin','0003_logentry_add_action_flag_choices','2022-06-24 00:12:51.504212'),(19,'authtoken','0001_initial','2022-06-24 00:12:51.721490'),(20,'authtoken','0002_auto_20160226_1747','2022-06-24 00:12:51.781790'),(21,'authtoken','0003_tokenproxy','2022-06-24 00:12:51.789789'),(22,'avaliauto_api','0002_alter_user_email','2022-06-24 00:12:51.803789'),(23,'sessions','0001_initial','2022-06-24 00:12:51.890313');
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
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

-- Dump completed on 2022-06-23 21:32:51

