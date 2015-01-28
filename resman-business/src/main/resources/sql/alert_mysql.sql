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

-- ----------------------------
-- Table structure for `r_category`
-- ----------------------------
DROP TABLE IF EXISTS `r_category`;
CREATE TABLE `r_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程类别';

-- ----------------------------
-- Records of r_category
-- ----------------------------

-- ----------------------------
-- Table structure for `r_course`
-- ----------------------------
DROP TABLE IF EXISTS `r_course`;
CREATE TABLE `r_course` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT '名称',
  `description` text COMMENT '描述',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `category_id` bigint(20) DEFAULT NULL COMMENT '课程类别',
  `parentid` bigint(20) DEFAULT NULL COMMENT '父节点',
  `ntype` char(1) DEFAULT NULL COMMENT '0：课程，1：作业',
  PRIMARY KEY (`id`),
  KEY `fk_r_course_r_category1_idx` (`category_id`),
  KEY `fk_r_course_r_course1_idx` (`parentid`),
  CONSTRAINT `fk_r_course_r_category1` FOREIGN KEY (`category_id`) REFERENCES `r_category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='课程/作业（通过ntype进行区分）';

-- ----------------------------
-- Records of r_course
-- ----------------------------

-- ----------------------------
-- Table structure for `r_course_student`
-- ----------------------------
CREATE TABLE `r_course_student` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` bigint(20) NOT NULL COMMENT '用户',
  `path` varchar(45) DEFAULT NULL COMMENT '作业路径',
  `score` varchar(45) DEFAULT NULL COMMENT '成绩',
  `course_id` bigint(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`),
  KEY `fk_r_student_job_r_course1_idx` (`course_id`),
  KEY `FK_q2iu2s0cbg0fg1hgw0bs2xwur` (`userid`),
  CONSTRAINT `FK_q2iu2s0cbg0fg1hgw0bs2xwur` FOREIGN KEY (`userid`) REFERENCES `s_users` (`id`),
  CONSTRAINT `fk_r_student_job_r_course1` FOREIGN KEY (`course_id`) REFERENCES `r_course` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;