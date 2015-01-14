INSERT INTO `s_funcs` VALUES (2000, 0, '教师空间', NULL, 10, '', '', 'fa fa-bar-chart-o');
INSERT INTO `s_funcs` VALUES (2001, 1, '我的空间', 2000, 5, '/res/space/list', '', NULL);
INSERT INTO `s_funcs` VALUES (2002, 1, '我的课程', 2000, 10, '/res/course/list', '', NULL);
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

DROP TABLE IF EXISTS `r_ques`;
CREATE TABLE `r_ques` (
  `id` bigint(20) NOT NULL,
  `crtuser` varchar(100) DEFAULT NULL COMMENT '提问人',
  `crtdate` datetime DEFAULT NULL COMMENT '提问时间',
  `state` varchar(1) DEFAULT NULL COMMENT '状态',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问题';

DROP TABLE IF EXISTS `r_anwser`;
CREATE TABLE `r_anwser` (
  `id` bigint(20) NOT NULL,
  `quesId` bigint(20) DEFAULT NULL COMMENT '问题id',
  `crtuser` varchar(50) DEFAULT NULL COMMENT '回答人',
  `crtdate` datetime DEFAULT NULL COMMENT '回答时间',
  `content` text COMMENT '内容',
  PRIMARY KEY (`id`),
  KEY `fk_r_anwser_r_ques1_idx` (`quesId`),
  CONSTRAINT `fk_r_anwser_r_ques1` FOREIGN KEY (`quesId`) REFERENCES `r_ques` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='答案';