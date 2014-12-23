-- MySQL dump 10.13  Distrib 5.6.15, for Win64 (x86_64)
--
-- Host: localhost    Database: base
-- ------------------------------------------------------
-- Server version	5.6.15-log

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
-- Table structure for table `s_funcs`
--

DROP TABLE IF EXISTS `s_funcs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s_funcs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `level` int(11) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `parent` bigint(20) DEFAULT NULL,
  `seqNo` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `leaf` bit(1) NOT NULL,
  `iconCls` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_PARENT_ID` (`parent`),
  CONSTRAINT `FK_PARENT_ID` FOREIGN KEY (`parent`) REFERENCES `s_funcs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s_funcs`
--

LOCK TABLES `s_funcs` WRITE;
/*!40000 ALTER TABLE `s_funcs` DISABLE KEYS */;
INSERT INTO `s_funcs` VALUES (13,0,'设备管理',NULL,5,'','\0',NULL);
INSERT INTO `s_funcs` VALUES (14,0,'系统管理',NULL,10,'','\0','fa fa-bar-chart-o');
INSERT INTO `s_funcs` VALUES (15,1,'用户管理',14,5,'/sys/user/list','',NULL);
INSERT INTO `s_funcs` VALUES (16,1,'角色管理',14,10,'/sys/role/list','',NULL);
INSERT INTO `s_funcs` VALUES (17,1,'权限管理',14,15,'/sys/perm/list','',NULL);
INSERT INTO `s_funcs` VALUES (18,1,'功能管理',14,20,'/sys/func/list','',NULL);
/*!40000 ALTER TABLE `s_funcs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s_org_user`
--

DROP TABLE IF EXISTS `s_org_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s_org_user` (
  `orgId` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  PRIMARY KEY (`orgId`,`userId`),
  KEY `FK_duts42ru4l41c4a1blbwuk8eo` (`userId`),
  CONSTRAINT `FK_ou17tsfan2bdnw6gtq7btd4dd` FOREIGN KEY (`orgId`) REFERENCES `s_orgs` (`id`),
  CONSTRAINT `FK_duts42ru4l41c4a1blbwuk8eo` FOREIGN KEY (`userId`) REFERENCES `s_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s_org_user`
--

LOCK TABLES `s_org_user` WRITE;
/*!40000 ALTER TABLE `s_org_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `s_org_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s_orgs`
--

DROP TABLE IF EXISTS `s_orgs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s_orgs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `parent` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s_orgs`
--

LOCK TABLES `s_orgs` WRITE;
/*!40000 ALTER TABLE `s_orgs` DISABLE KEYS */;
/*!40000 ALTER TABLE `s_orgs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s_permissions`
--

DROP TABLE IF EXISTS `s_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `perm` varchar(60) NOT NULL,
  `resource` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s_permissions`
--

LOCK TABLES `s_permissions` WRITE;
/*!40000 ALTER TABLE `s_permissions` DISABLE KEYS */;
INSERT INTO `s_permissions` VALUES (2,'修改用户','编辑用户权限','user:edit','user');
INSERT INTO `s_permissions` VALUES (3,'添加用户','添加用户权限','user:add','user');
/*!40000 ALTER TABLE `s_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s_role_func`
--

DROP TABLE IF EXISTS `s_role_func`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s_role_func` (
  `roleId` bigint(20) NOT NULL,
  `funcId` bigint(20) NOT NULL,
  KEY `FK_9u7j7xp6uanr9gb50xpl9bdjd` (`funcId`),
  KEY `FK_bv35saad3hjemyq251brkglkc` (`roleId`),
  CONSTRAINT `FK_9u7j7xp6uanr9gb50xpl9bdjd` FOREIGN KEY (`funcId`) REFERENCES `s_funcs` (`id`),
  CONSTRAINT `FK_bv35saad3hjemyq251brkglkc` FOREIGN KEY (`roleId`) REFERENCES `s_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s_role_func`
--

LOCK TABLES `s_role_func` WRITE;
/*!40000 ALTER TABLE `s_role_func` DISABLE KEYS */;
INSERT INTO `s_role_func` VALUES (4,17);
INSERT INTO `s_role_func` VALUES (4,16);
INSERT INTO `s_role_func` VALUES (4,18);
INSERT INTO `s_role_func` VALUES (4,14);
INSERT INTO `s_role_func` VALUES (4,15);
/*!40000 ALTER TABLE `s_role_func` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s_role_permission`
--

DROP TABLE IF EXISTS `s_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s_role_permission` (
  `roleId` bigint(20) NOT NULL,
  `permId` bigint(20) NOT NULL,
  PRIMARY KEY (`roleId`,`permId`),
  KEY `FK_6ywh0a3ri1rc0l1xn7jv0wgw` (`permId`),
  CONSTRAINT `FK_1mt4jfq878wdva26j0a8cbv04` FOREIGN KEY (`roleId`) REFERENCES `s_roles` (`id`),
  CONSTRAINT `FK_6ywh0a3ri1rc0l1xn7jv0wgw` FOREIGN KEY (`permId`) REFERENCES `s_permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s_role_permission`
--

LOCK TABLES `s_role_permission` WRITE;
/*!40000 ALTER TABLE `s_role_permission` DISABLE KEYS */;
INSERT INTO `s_role_permission` VALUES (4,2);
INSERT INTO `s_role_permission` VALUES (4,3);
/*!40000 ALTER TABLE `s_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s_roles`
--

DROP TABLE IF EXISTS `s_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s_roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `role` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s_roles`
--

LOCK TABLES `s_roles` WRITE;
/*!40000 ALTER TABLE `s_roles` DISABLE KEYS */;
INSERT INTO `s_roles` VALUES (4,'系统管理员',NULL,'admin');
INSERT INTO `s_roles` VALUES (5,'研发部经理',NULL,'manager');
/*!40000 ALTER TABLE `s_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s_sys_users`
--

DROP TABLE IF EXISTS `s_sys_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s_sys_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sysName` varchar(32) NOT NULL,
  `passwd` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `salt` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s_sys_users`
--

LOCK TABLES `s_sys_users` WRITE;
/*!40000 ALTER TABLE `s_sys_users` DISABLE KEYS */;
INSERT INTO `s_sys_users` VALUES (4,'sjzheng','sjzheng','sjzheng@arcie.org','c55a61fa81cfb3d7',0);
INSERT INTO `s_sys_users` VALUES (5,'lcheng','7892304c735b0a0e5ef51f11d933e50b221862e3','chengluren@126.com','9ffc56b90db1b6dc',0);
INSERT INTO `s_sys_users` VALUES (6,'bhuang','bhuang','bhuang@arcie.org','4b882b344787f2fa',0);
INSERT INTO `s_sys_users` VALUES (10,'liangsun','d8435400a43cb747d0a43d6a9bd03ed065a08e64','lsun@126.com','1d044a08fc0d8734',NULL);
/*!40000 ALTER TABLE `s_sys_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s_user_role`
--

DROP TABLE IF EXISTS `s_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s_user_role` (
  `sysUserId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY (`sysUserId`,`roleId`),
  KEY `FK_a9i759h40010y1v5djsvl9c8e` (`roleId`),
  CONSTRAINT `FK_29oeuwxk6kmduysdriumeno64` FOREIGN KEY (`sysUserId`) REFERENCES `s_sys_users` (`id`),
  CONSTRAINT `FK_a9i759h40010y1v5djsvl9c8e` FOREIGN KEY (`roleId`) REFERENCES `s_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s_user_role`
--

LOCK TABLES `s_user_role` WRITE;
/*!40000 ALTER TABLE `s_user_role` DISABLE KEYS */;
INSERT INTO `s_user_role` VALUES (5,4);
/*!40000 ALTER TABLE `s_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s_users`
--

DROP TABLE IF EXISTS `s_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s_users` (
  `id` bigint(20) NOT NULL,
  `name` varchar(60) NOT NULL,
  `sex` int(11) DEFAULT NULL,
  `bod` datetime DEFAULT NULL,
  `phoneNum` varchar(13) DEFAULT NULL,
  `img` longblob,
  `telNum` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s_users`
--

LOCK TABLES `s_users` WRITE;
/*!40000 ALTER TABLE `s_users` DISABLE KEYS */;
INSERT INTO `s_users` VALUES (4,'郑书剑',1,'2014-11-29 00:00:00','13811990979',NULL,NULL);
INSERT INTO `s_users` VALUES (5,'程亮',1,'2014-12-01 00:00:00','18611778463',NULL,NULL);
INSERT INTO `s_users` VALUES (6,'黄波',1,'2014-12-01 00:00:00','13811990979',NULL,NULL);
INSERT INTO `s_users` VALUES (10,'孙亮',1,'1980-02-02 00:00:00','13811990979',NULL,NULL);
/*!40000 ALTER TABLE `s_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-12-22 17:41:16
