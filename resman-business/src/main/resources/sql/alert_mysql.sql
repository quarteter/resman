INSERT INTO `s_funcs` VALUES (2000, 0, '教师空间', NULL, 10, '', '', 'fa fa-bar-chart-o');
INSERT INTO `s_funcs` VALUES (2001, 1, '我的空间', 2000, 5, '/sys/user/list', '', NULL);
INSERT INTO `s_funcs` VALUES (2002, 1, '我的课程', 2000, 10, '/sys/role/list', '', NULL);
INSERT INTO `s_funcs` VALUES (2003, 1, '公告管理', 2000, 15, '/res/notice/list', '', NULL);

INSERT INTO `s_role_func` VALUES (4, 2002);
INSERT INTO `s_role_func` VALUES (4, 2003);
INSERT INTO `s_role_func` VALUES (4, 2000);
INSERT INTO `s_role_func` VALUES (4, 2001);

DROP TABLE IF EXISTS `r_notice`;
CREATE TABLE `r_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `crtuser` varchar(100) DEFAULT NULL COMMENT '发布者',
  `crtdate` datetime DEFAULT NULL COMMENT '发布时间',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `state` char(1) DEFAULT NULL COMMENT '审批状态，0：待发布，1：已发布',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='公告';