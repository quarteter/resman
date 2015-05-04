/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50615
Source Host           : localhost:3306
Source Database       : base

Target Server Type    : MYSQL
Target Server Version : 50615
File Encoding         : 65001

Date: 2015-04-17 15:55:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Records of r_res_comments
-- ----------------------------

-- ----------------------------
-- Table structure for s_codes
-- ----------------------------
DROP TABLE IF EXISTS `s_codes`;
CREATE TABLE `s_codes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `seqNo` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_codes
-- ----------------------------
insert into s_codes (id,category,code,name,seqNo) VALUES(1,"info","news","新闻",1);
insert into s_codes (id,category,code,name,seqNo) VALUES(2,"info","knowledge","知识堂",2);
insert into s_codes (id,category,code,name,seqNo) VALUES(3,"info","skillContest","技能大赛",3);
insert into s_codes (id,category,code,name,seqNo) VALUES(4,"info","teacherGroup","师资队伍",4);
insert into s_codes (id,category,code,name,seqNo) VALUES(5,"info","sworks","学生作品",5);
insert into s_codes (id,category,code,name,seqNo) VALUES(6,"info","tworks","老师作品",6);
insert into s_codes (id,category,code,name,seqNo) VALUES(7,"info","contest_works","大赛作品",7);
insert into s_codes (id,category,code,name,seqNo) VALUES(10,"info","strategy","攻略展示",10);
insert into s_codes (id,category,code,name,seqNo) VALUES(11,"info","achievement","成果展示",8);
insert into s_codes (id,category,code,name,seqNo) VALUES(14,"info","notice","通知公告",9);
-- ----------------------------
-- Table structure for s_funcs
-- ----------------------------
DROP TABLE IF EXISTS `s_funcs`;
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
) ENGINE=InnoDB AUTO_INCREMENT=2108 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_funcs
-- ----------------------------
INSERT INTO `s_funcs` VALUES ('14', '0', '系统管理', null, '5', '', '\0', 'fa fa-bar-chart-o');
INSERT INTO `s_funcs` VALUES ('15', '1', '用户管理', '14', '5', '/sys/user/list', '', null);
INSERT INTO `s_funcs` VALUES ('16', '1', '角色管理', '14', '15', '/sys/role/list', '', null);
INSERT INTO `s_funcs` VALUES ('17', '1', '权限管理', '14', '20', '/sys/perm/list', '', null);
INSERT INTO `s_funcs` VALUES ('18', '1', '功能管理', '14', '25', '/sys/func/list', '', null);
INSERT INTO `s_funcs` VALUES ('2000', '0', '教师空间', null, '10', '', '\0', 'fa fa-bar-chart-o');
INSERT INTO `s_funcs` VALUES ('2001', '1', '我的空间', '2000', '5', '/res/space/list', '', 'fa fa-th-large');
INSERT INTO `s_funcs` VALUES ('2002', '1', '我的课程', '2000', '10', '/res/course/list', '', '');
INSERT INTO `s_funcs` VALUES ('2003', '1', '公告管理', '2000', '15', '/res/notice/list', '', null);
INSERT INTO `s_funcs` VALUES ('2100', '0', '超级管理员', null, '15', '', '\0', 'fa fa-tachometer');
INSERT INTO `s_funcs` VALUES ('2101', '1', '精品课程', '2100', '5', '/res/common/classic/list', '', 'fa fa-graduation-cap');
INSERT INTO `s_funcs` VALUES ('2102', '1', '教师空间', '2100', '10', '/res/common/personal/list', '', 'fa fa-th-large');
INSERT INTO `s_funcs` VALUES ('2103', '1', '精品素材', '2100', '15', '/res/common/material/list', '', 'fa fa-asterisk');
INSERT INTO `s_funcs` VALUES ('2104', '1', '精品文档', '2100', '20', '/res/common/docs/list', '', 'fa fa-book');
INSERT INTO `s_funcs` VALUES ('2105', '1', '经常图库', '2100', '25', '/res/common/imgs/list', '', 'fa fa-picture-o');
--INSERT INTO `s_funcs` VALUES ('2106', '1', '公告管理', '2100', '30', '/res/notice/pageList', '', 'fa fa-info-circle');
INSERT INTO `s_funcs` VALUES ('2107', '1', '信息发布', '2100', '35', '/info/list', '', 'fa fa-newspaper-o');

-- ----------------------------
-- Table structure for s_orgs
-- ----------------------------
DROP TABLE IF EXISTS `s_orgs`;
CREATE TABLE `s_orgs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `parent` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_orgs
-- ----------------------------

-- ----------------------------
-- Table structure for s_org_user
-- ----------------------------
DROP TABLE IF EXISTS `s_org_user`;
CREATE TABLE `s_org_user` (
  `orgId` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  PRIMARY KEY (`orgId`,`userId`),
  KEY `FK_duts42ru4l41c4a1blbwuk8eo` (`userId`),
  CONSTRAINT `FK_duts42ru4l41c4a1blbwuk8eo` FOREIGN KEY (`userId`) REFERENCES `s_users` (`id`),
  CONSTRAINT `FK_ou17tsfan2bdnw6gtq7btd4dd` FOREIGN KEY (`orgId`) REFERENCES `s_orgs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_org_user
-- ----------------------------

-- ----------------------------
-- Table structure for s_permissions
-- ----------------------------
DROP TABLE IF EXISTS `s_permissions`;
CREATE TABLE `s_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `perm` varchar(60) NOT NULL,
  `resource` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_permissions
-- ----------------------------
INSERT INTO `s_permissions` VALUES ('2', '修改用户', '编辑用户权限', 'user:edit', 'user');
INSERT INTO `s_permissions` VALUES ('3', '添加用户', '添加用户权限', 'user:add', 'user');

-- ----------------------------
-- Table structure for s_roles
-- ----------------------------
DROP TABLE IF EXISTS `s_roles`;
CREATE TABLE `s_roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `role` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_roles
-- ----------------------------
INSERT INTO `s_roles` VALUES ('4', '系统管理员', null, 'admin');
INSERT INTO `s_roles` VALUES ('5', '研发部经理', null, 'manager');
INSERT INTO `s_roles` VALUES ('6', '学生', null, 'student');
-- ----------------------------
-- Table structure for s_role_func
-- ----------------------------
DROP TABLE IF EXISTS `s_role_func`;
CREATE TABLE `s_role_func` (
  `roleId` bigint(20) NOT NULL,
  `funcId` bigint(20) NOT NULL,
  KEY `FK_9u7j7xp6uanr9gb50xpl9bdjd` (`funcId`),
  KEY `FK_bv35saad3hjemyq251brkglkc` (`roleId`),
  CONSTRAINT `FK_9u7j7xp6uanr9gb50xpl9bdjd` FOREIGN KEY (`funcId`) REFERENCES `s_funcs` (`id`),
  CONSTRAINT `FK_bv35saad3hjemyq251brkglkc` FOREIGN KEY (`roleId`) REFERENCES `s_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_role_func
-- ----------------------------
INSERT INTO `s_role_func` VALUES ('4', '17');
INSERT INTO `s_role_func` VALUES ('4', '16');
INSERT INTO `s_role_func` VALUES ('4', '18');
INSERT INTO `s_role_func` VALUES ('4', '14');
INSERT INTO `s_role_func` VALUES ('4', '15');
INSERT INTO `s_role_func` VALUES ('4', '2002');
INSERT INTO `s_role_func` VALUES ('4', '2003');
INSERT INTO `s_role_func` VALUES ('4', '2000');
INSERT INTO `s_role_func` VALUES ('4', '2001');
INSERT INTO `s_role_func` VALUES ('4', '2100');
INSERT INTO `s_role_func` VALUES ('4', '2101');
INSERT INTO `s_role_func` VALUES ('4', '2102');
INSERT INTO `s_role_func` VALUES ('4', '2103');
INSERT INTO `s_role_func` VALUES ('4', '2104');
INSERT INTO `s_role_func` VALUES ('4', '2105');
--INSERT INTO `s_role_func` VALUES ('4', '2106');
INSERT INTO `s_role_func` VALUES ('4', '2107');



delete from s_role_func where roleid = 4 and funcid = 2106;
delete from s_funcs where id = 2106;


-- ----------------------------
-- Table structure for s_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `s_role_permission`;
CREATE TABLE `s_role_permission` (
  `roleId` bigint(20) NOT NULL,
  `permId` bigint(20) NOT NULL,
  PRIMARY KEY (`roleId`,`permId`),
  KEY `FK_6ywh0a3ri1rc0l1xn7jv0wgw` (`permId`),
  CONSTRAINT `FK_1mt4jfq878wdva26j0a8cbv04` FOREIGN KEY (`roleId`) REFERENCES `s_roles` (`id`),
  CONSTRAINT `FK_6ywh0a3ri1rc0l1xn7jv0wgw` FOREIGN KEY (`permId`) REFERENCES `s_permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_role_permission
-- ----------------------------
INSERT INTO `s_role_permission` VALUES ('4', '2');
INSERT INTO `s_role_permission` VALUES ('4', '3');

-- ----------------------------
-- Table structure for s_sys_users
-- ----------------------------
DROP TABLE IF EXISTS `s_sys_users`;
CREATE TABLE `s_sys_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sysName` varchar(32) NOT NULL,
  `passwd` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `salt` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_sys_users
-- ----------------------------
INSERT INTO `s_sys_users` VALUES ('4', 'sjzheng', 'sjzheng', 'sjzheng@arcie.org', 'c55a61fa81cfb3d7', '0');
INSERT INTO `s_sys_users` VALUES ('5', 'lcheng', '7892304c735b0a0e5ef51f11d933e50b221862e3', 'chengluren@126.com', '9ffc56b90db1b6dc', '0');
INSERT INTO `s_sys_users` VALUES ('6', 'bhuang', 'bhuang', 'bhuang@arcie.org', '4b882b344787f2fa', '0');
INSERT INTO `s_sys_users` VALUES ('10', 'liangsun', 'd8435400a43cb747d0a43d6a9bd03ed065a08e64', 'lsun@126.com', '1d044a08fc0d8734', null);

-- ----------------------------
-- Table structure for s_users
-- ----------------------------
DROP TABLE IF EXISTS `s_users`;
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

-- ----------------------------
-- Records of s_users
-- ----------------------------
INSERT INTO `s_users` VALUES ('4', '郑书剑', '1', '2014-11-29 00:00:00', '13811990979', null, null);
INSERT INTO `s_users` VALUES ('5', '程亮', '1', '2014-12-01 00:00:00', '18611778463', null, null);
INSERT INTO `s_users` VALUES ('6', '黄波', '1', '2014-12-01 00:00:00', '13811990979', null, null);
INSERT INTO `s_users` VALUES ('10', '孙亮', '1', '1980-02-02 00:00:00', '13811990979', null, null);

-- ----------------------------
-- Table structure for s_user_role
-- ----------------------------
DROP TABLE IF EXISTS `s_user_role`;
CREATE TABLE `s_user_role` (
  `sysUserId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY (`sysUserId`,`roleId`),
  KEY `FK_a9i759h40010y1v5djsvl9c8e` (`roleId`),
  CONSTRAINT `FK_29oeuwxk6kmduysdriumeno64` FOREIGN KEY (`sysUserId`) REFERENCES `s_sys_users` (`id`),
  CONSTRAINT `FK_a9i759h40010y1v5djsvl9c8e` FOREIGN KEY (`roleId`) REFERENCES `s_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_user_role
-- ----------------------------
INSERT INTO `s_user_role` VALUES ('5', '4');
