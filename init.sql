-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.6.24 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win32
-- HeidiSQL 版本:                  9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 resman 的数据库结构
DROP DATABASE IF EXISTS `resman`;
CREATE DATABASE IF NOT EXISTS `resman` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `resman`;


-- 导出  表 resman.r_anwser 结构
CREATE TABLE IF NOT EXISTS `r_anwser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quesId` bigint(20) DEFAULT NULL COMMENT '问题id',
  `crtuser` varchar(50) DEFAULT NULL COMMENT '回答人',
  `crtdate` datetime DEFAULT NULL COMMENT '回答时间',
  `content` text COMMENT '内容',
  PRIMARY KEY (`id`),
  KEY `fk_r_anwser_r_ques1_idx` (`quesId`),
  CONSTRAINT `fk_r_anwser_r_ques1` FOREIGN KEY (`quesId`) REFERENCES `r_ques` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='答案';

-- 正在导出表  resman.r_anwser 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `r_anwser` DISABLE KEYS */;
/*!40000 ALTER TABLE `r_anwser` ENABLE KEYS */;


-- 导出  表 resman.r_category 结构
CREATE TABLE IF NOT EXISTS `r_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='课程类别';

-- 正在导出表  resman.r_category 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `r_category` DISABLE KEYS */;
INSERT INTO `r_category` (`id`, `name`, `description`) VALUES
	(1, '中学', NULL);
/*!40000 ALTER TABLE `r_category` ENABLE KEYS */;


-- 导出  表 resman.r_comment 结构
CREATE TABLE IF NOT EXISTS `r_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `crtdate` datetime DEFAULT NULL,
  `resourceid` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `userid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_9n4lp3i7erso5qtmb8fwx3r5` (`userid`),
  CONSTRAINT `FK_9n4lp3i7erso5qtmb8fwx3r5` FOREIGN KEY (`userid`) REFERENCES `s_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  resman.r_comment 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `r_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `r_comment` ENABLE KEYS */;


-- 导出  表 resman.r_course 结构
CREATE TABLE IF NOT EXISTS `r_course` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `ntype` varchar(255) DEFAULT NULL,
  `parentid` bigint(20) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ctiq8hwgdj8mb5xhoxyr7uitt` (`category_id`),
  CONSTRAINT `FK_ctiq8hwgdj8mb5xhoxyr7uitt` FOREIGN KEY (`category_id`) REFERENCES `r_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  resman.r_course 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `r_course` DISABLE KEYS */;
/*!40000 ALTER TABLE `r_course` ENABLE KEYS */;


-- 导出  表 resman.r_course_student 结构
CREATE TABLE IF NOT EXISTS `r_course_student` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `score` varchar(255) DEFAULT NULL,
  `course_id` bigint(20) DEFAULT NULL,
  `userid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_6i777kydbtyx0gx28xf4n622r` (`course_id`),
  KEY `FK_q2iu2s0cbg0fg1hgw0bs2xwur` (`userid`),
  CONSTRAINT `FK_6i777kydbtyx0gx28xf4n622r` FOREIGN KEY (`course_id`) REFERENCES `r_course` (`id`),
  CONSTRAINT `FK_q2iu2s0cbg0fg1hgw0bs2xwur` FOREIGN KEY (`userid`) REFERENCES `s_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  resman.r_course_student 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `r_course_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `r_course_student` ENABLE KEYS */;


-- 导出  表 resman.r_doc_courses 结构
CREATE TABLE IF NOT EXISTS `r_doc_courses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `brief` varchar(255) DEFAULT NULL,
  `description` longtext,
  `docUid` varchar(40) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `teacher` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
	ENGINE = InnoDB
	AUTO_INCREMENT = 15
	DEFAULT CHARSET = utf8;

-- 正在导出表  resman.r_doc_courses 的数据：~10 rows (大约)
/*!40000 ALTER TABLE `r_doc_courses` DISABLE KEYS */;
INSERT INTO `r_doc_courses` (`id`, `brief`, `description`, `docUid`, `name`, `teacher`) VALUES
	(1, '著名的高等数学啊高等数学，我爱高等数学著名的高等数学啊高等数学，我爱高等数学著名的高等数学啊高等数学，我爱高等数学著名的高等数学啊高等数学。', '<p><a target="_blank" href="http://baike.baidu.com/view/1284.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">数学</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">是研究现实世界数量关系和空间形式的学科.随着现代科学技术和数学科学的发展，“数量关系”和“空间形式”有了越来越丰富的内涵和更加广泛的外延.数学不仅是一种工具，而且是一种思维模式； 不仅是一种知识，而且是一种素养； 不仅是一门科学，而且是一种文化.数学教育在培养高素质科技人才中具有其独特的、不可替代的作用.对于高等学校工科类专业的本科生而言，高等数学课程是一门非常重要的基础课，它内容丰富，理论严谨，应用广泛，影响深远.不仅为学习后继课程和进一步扩大数学知识面奠定必要的基础，而且在培养学生抽象思维、逻辑推理能力，综合利用所学知识分析问题解决问题的能力，较强的自主学习的能力，创新意识和创新能力上都具有非常重要的作用.</span><br style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);"/><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">　　本教材面对高等教育大众化的现实，以教育部非数学专业数学基础课教学指导分委员会制定的新的“工科类本科数学基础课程教学基本要求”为依据，以“必须够用”为原则确定内容和深度.知识点的覆盖面与“基本要求”相一致，要求度上略高于“基本要求”.本教材对基本概念的叙述清晰准确； 对定理的证明简明易懂，但对难度较大的理论问题则不过分强调论证的严密性，有的仅给出结论而不加证明； 对例题的选配力求典型多样，难度上层次分明，注意解题方法的总结； 强调基本运算能力的培养和理论的实际应用； 注重对学生的思维能力、自学能力和创新意识的培养.</span></p>', '0edd404a-8591-4c55-8b50-64cc7c91704b', '高等数学（一）', '华罗庚'),
	(2, '另每半年出版一期《大学英语》（学术版），征稿范围包括：语言学研究和语言对比研究、翻译研究和英美文学研究、多媒体教学设计与实践、大学英语语言应用能力培养途径、大学英语课程体系改革、大学英语课堂教学方法。接受电子版投稿。', '<p><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">为了配合《大学英语教学大纲》（</span><a target="_blank" href="http://baike.baidu.com/view/647254.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">修订本</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">）的实施，外教社在新世纪初隆重推出《大学英语》（全新版）系列教材，为促进我国大学英语教育再作贡献。全套教材由</span><a target="_blank" href="http://baike.baidu.com/view/1565.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">复旦大学</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">、</span><a target="_blank" href="http://baike.baidu.com/view/1471.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">北京大学</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">、</span><a target="_blank" href="http://baike.baidu.com/view/8835.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">华东师范大学</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">、中国科技大学、</span><a target="_blank" href="http://baike.baidu.com/view/2971.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">华南理工大学</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">、</span><a target="_blank" href="http://baike.baidu.com/view/3143.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">南京大学</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">、</span><a target="_blank" href="http://baike.baidu.com/view/1264.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">武汉大学</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">、</span><a target="_blank" href="http://baike.baidu.com/view/2967.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">南开大学</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">、</span><a target="_blank" href="http://baike.baidu.com/view/4809.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">中山大学</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">、</span><a target="_blank" href="http://baike.baidu.com/view/806216.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">华中理工大学</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">等著名院校的资深教授及英语教学专家合作编写而成。系列教材由综合、听说、阅读（含泛读和快速阅读）三种教程及语法手册组成。另有前三种教程的预备级教材供起点较低的学生使用。系列教材以《</span><a target="_blank" href="http://baike.baidu.com/view/1925918.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">综合教程</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">》为核心，每单元围绕一个反映当代生活实际的</span><a target="_blank" href="http://baike.baidu.com/view/1568506.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">主题展开</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">，配以《听说教程》、《阅读教程》及《快速阅读教程》,指导学生深入全面地获取并掌握与各主题有关的语言文化知识。各课程均设一定量的类似四、</span><a target="_blank" href="http://baike.baidu.com/view/29106.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">六级考试</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">题型的练习，并将《综合教程》的Test Yourself设计成CET的形式，让学生熟悉</span><a target="_blank" href="http://baike.baidu.com/view/14727.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">CET</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">考试的形式与要求。</span></p>', '06bd6037-21c8-43ca-9beb-923ce6945c25', '大学英语-上', '程亮'),
	(3, '大学物理，是大学理工科类的一门基础课程，通过课程的学习，使学生熟悉自然界物质的结构，性质，相互作用及其运动的基本规律，为后继专业基础与专业课程的学习及进一步获取有关知识奠定必要的物理基础。但工科专业以力学基础和电磁学为主要授课', '<p><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">本书属</span><a target="_blank" href="http://baike.baidu.com/view/22667.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">对外经济贸易大学</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">远程教育基础英语教材，由10课组成，每课包括课文、词汇、注释、复习重点、练习及答案、课文译文等内容、注解精辟，知识点全面，课文译文符合信达雅标准，是一本较好的大学英语教材。<span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">本书属</span><a target="_blank" href="http://baike.baidu.com/view/22667.htm" style="text-decoration: none; color: rgb(19, 110, 194); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; white-space: normal; background-color: rgb(255, 255, 255);">对外经济贸易大学</a><span style="color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; text-indent: 28px; background-color: rgb(255, 255, 255);">远程教育基础英语教材，由10课组成，每课包括课文、词汇、注释、复习重点、练习及答案、课文译文等内容、注解精辟，知识点全面，课文译文符合信达雅标准，是一本较好的大学英语教材。</span></span></p>', '5fe07a1d-a2b0-4a70-8296-0a55d0e34ba7', '大学物理（上）', '佟大为'),
	(4, '123', NULL, '3d9f37b9-6da6-4f32-bb53-9e1ca0c2d453', '历史', '刘涛'),
	(5, '三维动画课程', NULL, '249ca9c4-9faf-492e-a093-4725d185f1c3', '三维动画课程', '周小燕'),
	(6, '《漫画绘制技法基础》', '<p><img src="/resman/ueditor/jsp/upload/image/20150721/1437467043388089045.jpg" title="1437467043388089045.jpg" alt="_MG_0748.jpg"/></p>', '41c3993a-c56e-446b-a06f-d97d8e13b101', '《漫画绘制技法基础》', '孟老师'),
	(7, '《视频剪辑》', NULL, '7e5bf6b7-f49e-4831-a733-6b743a2ccc84', '《视频剪辑》', '赵老师'),
	(8, '《影视后期特效》', NULL, '813b0d8d-e57d-4c72-9aa0-5f069c89bd13', '《影视后期特效》', '邢老师'),
	(9, '1', '<p>1111<br/></p>', '7d7fc666-6c4c-49f2-8f9f-b33c84c39c6b', 'yingyue', 'wan'),
	(10, '1111', '', 'b50de5ff-3100-43c7-977e-40a97dae82ea', '11111', '222'),
	(11, '1', '<p>1</p>', 'e1b5e579-aac2-410c-9160-f1b585bf4a24', '11', '1'),
	(12, '123', '<p>123</p>', '75f57dad-3ec7-4824-a783-8b7f2c373809', '123', '123'),
	(13, '11', '<p>11</p>', 'e8bb5f1f-7cab-417a-ae21-6303d1465b17', '11', '11'),
	(14, '1', '<p>1</p>', 'fd09bd2e-a639-48f7-8c33-7abbe9270c29', 'test', '1');
/*!40000 ALTER TABLE `r_doc_courses` ENABLE KEYS */;


-- 导出  表 resman.r_hk_records 结构
CREATE TABLE IF NOT EXISTS `r_hk_records` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `docUid` varchar(60) DEFAULT NULL,
  `fileName` varchar(120) DEFAULT NULL,
  `hkId` bigint(20) DEFAULT NULL,
  `path` varchar(120) DEFAULT NULL,
  `score` float DEFAULT NULL,
  `submitDate` datetime DEFAULT NULL,
  `submitter` varchar(255) DEFAULT NULL,
  `submitterId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- 正在导出表  resman.r_hk_records 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `r_hk_records` DISABLE KEYS */;
INSERT INTO `r_hk_records` (`id`, `docUid`, `fileName`, `hkId`, `path`, `score`, `submitDate`, `submitter`, `submitterId`) VALUES
	(1, '408369b3-4da6-4dd4-9b29-ca3b0a519b6c', '作业.doc', 4, NULL, 70, '2015-06-15 09:18:34', '王家林', 2),
	(3, 'dea5d095-3724-47b4-bbe0-7837ce0db777', 'cat3.jpg', 4, NULL, NULL, '2015-08-12 21:10:24', '李明', 3);
/*!40000 ALTER TABLE `r_hk_records` ENABLE KEYS */;


-- 导出  表 resman.r_home_works 结构
CREATE TABLE IF NOT EXISTS `r_home_works` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `classNo` varchar(60) DEFAULT NULL,
  `dateFrom` date DEFAULT NULL,
  `dateTo` date DEFAULT NULL,
  `name` varchar(80) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `publishDate` datetime DEFAULT NULL,
  `publisher` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- 正在导出表  resman.r_home_works 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `r_home_works` DISABLE KEYS */;
INSERT INTO `r_home_works` (`id`, `classNo`, `dateFrom`, `dateTo`, `name`, `notes`, `publishDate`, `publisher`) VALUES
	(4, 'SY060732', '2015-06-03', '2015-07-02', '服装设计', 'eeeeee', '2015-06-20 22:18:34', NULL),
	(5, '22', '2015-07-01', '2015-07-21', '11', '', '2015-07-21 16:53:19', NULL);
/*!40000 ALTER TABLE `r_home_works` ENABLE KEYS */;


-- 导出  表 resman.r_info 结构
CREATE TABLE IF NOT EXISTS `r_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bannerNews` bit(1) NOT NULL,
  `content` longtext,
  `crtdate` datetime DEFAULT NULL,
  `crtuser` varchar(255) DEFAULT NULL,
  `imgPath` varchar(255) DEFAULT NULL,
  `publish` bit(1) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `shortContent` varchar(255) DEFAULT NULL,
  `readCount` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- 正在导出表  resman.r_info 的数据：~33 rows (大约)
/*!40000 ALTER TABLE `r_info` DISABLE KEYS */;
INSERT INTO `r_info` (`id`, `bannerNews`, `content`, `crtdate`, `crtuser`, `imgPath`, `publish`, `title`, `type`, `shortContent`, `readCount`) VALUES
	(1, b'1', '<p><span style="color: rgb(51, 51, 51);font-size: 14px;line-height: 22px;text-indent: 28px;font-family: 宋体">&nbsp;&nbsp;&nbsp;&nbsp;学校定于</span><span style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;text-indent: 28px;"><span style="font-family:Calibri">5</span></span><span style="color: rgb(51, 51, 51);font-size: 14px;line-height: 22px;text-indent: 28px;font-family: 宋体">月</span><span style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;text-indent: 28px;"><span style="font-family:Calibri">16</span></span><span style="color: rgb(51, 51, 51);font-size: 14px;line-height: 22px;text-indent: 28px;font-family: 宋体">日进行</span><span style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;text-indent: 28px;"><span style="font-family:Calibri">2015</span></span><span style="color: rgb(51, 51, 51);font-size: 14px;line-height: 22px;text-indent: 28px;font-family: 宋体">年大型招生咨询会，届时将有行业、企业专家、高级技师亲临现场，对招生政策、专业知识和就业前景进行详细解答。</span></p><p><span style="color: rgb(51, 51, 51);font-size: 14px;line-height: 22px;text-indent: 28px;font-family: 宋体"></span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;white-space: normal"><strong><span style="font-family: 宋体;color: red">当天咨询报名的学生有奖励政策！</span></strong></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;white-space: normal"><span style="font-family:Calibri">&nbsp;</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;white-space: normal"><strong><span style="font-family: 宋体">时间：</span></strong><span style="font-family:Calibri">8:30----16:30&nbsp;&nbsp;</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;white-space: normal"><strong><span style="font-family: 宋体">地点：</span></strong><span style="font-family: 宋体">北京市黄庄职业高中</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;white-space: normal"><span style="font-family:Calibri"><img border="0" alt="" src="/ueditor/jsp/upload/image/20150509/1431131292874034283.gif" width="528" height="373" style="height: 251px;width: 331px"/>&nbsp;&nbsp;</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;white-space: normal"><strong><span style="font-family: 宋体">乘车路线：</span></strong><span style="font-family: 宋体">乘地铁、</span><span style="font-family:Calibri">337</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">1</span><span style="font-family: 宋体">八宝山地铁站下车，</span><span style="font-family:Calibri">598</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">354</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">76</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">851</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">959</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">436</span><span style="font-family: 宋体">、运通</span><span style="font-family:Calibri">114</span><span style="font-family: 宋体">吴庄站下车，</span><span style="font-family:Calibri">472</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">663</span><span style="font-family: 宋体">、莲芳东桥东站下车，</span><span style="font-family:Calibri">334</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">527</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">531</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">545</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">481</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">046</span><span style="font-family: 宋体">吴庄公交场下车，</span><span style="font-family:Calibri">597</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">308</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">373</span><span style="font-family: 宋体">鲁谷西口站下车，</span><span style="font-family:Calibri">574</span><span style="font-family: 宋体">、</span><span style="font-family:Calibri">612</span><span style="font-family: 宋体">莲芳东桥南站下车。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;white-space: normal"><span style="font-family:Calibri">&nbsp;</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;white-space: normal"><strong><span style="font-family: 宋体">联系电话：</span></strong><span style="font-family:Calibri">010-68666475&nbsp;</span><span style="font-family: 宋体">，</span><span style="font-family:Calibri">68664670</span><span style="font-family: 宋体">，史老师</span><span style="font-family:Calibri">15801030393</span><span style="font-family: 宋体">，孙老师</span><span style="font-family:Calibri">18701108365</span></p><p><span style="color: rgb(51, 51, 51);font-size: 14px;line-height: 22px;text-indent: 28px;font-family: 宋体"><br/></span><br/></p>', '2015-05-09 08:28:19', 'system', '/ueditor/jsp/upload/image/20150509/pic01_509.jpg', b'1', '我校将于5月16日举办校园开放日', 'news', '学校定于5月16日进行2015年大型招生咨询会，届时将有行业、企业专家、高级技师亲临现场，对招生政策、专业知识和就业前景进行详细解答。', 10),
	(2, b'1', '<p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">4</span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">月24-26日，历时三天的“北京市中等职业学校&quot;晨晓阳&quot;杯服装设计与制作专业技能大赛暨全国职业技能大赛选拔赛”落下帷幕，我校服装专业6名学生再次斩获佳绩，荣获服装工艺项目的一等奖1名，服装设计项目的二等奖2名，团体总成绩第一名的优异成绩，骆臣但、王维维两名同学获得“国赛”资格，将代表北京队进军全国大赛。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 24px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">4</span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">月25日，北京市中等职业学校计算机应用专业技能比赛在北京市信息管理学校（清河校区）如期举行。我校计算机网络技术专业5名学生组成两个团队，参加了“企业网络搭建及应用”、“网络综合布线技术”两个赛项的比赛。4月26日，北京市中等职业学校物联网专业技能比赛在丰台职业教育中心校举行，我校计算机网络技术专业6名学生组成两个团队，参加了“物联网技术应用与维护”“智能家居安装与维护”两个赛项的比赛。经过三个小时的紧张比赛，荣获智能家居安装维护项目二等奖，网络搭建与应用、网络综合布线技术两个项目的三等奖。</span></p><p><br/></p>', '2015-05-09 08:29:27', 'system', '/ueditor/jsp/upload/image/20150509/pic_771.jpg', b'1', '我校服装专业学生再获“国赛”入场资格', 'news', '历时三天的“北京市中等职业学校"晨晓阳"杯服装设计与制作专业技能大赛暨全国职业技能大赛选拔赛”落下帷幕，我校服装专业6名学生再次斩获佳绩，荣获服装工艺项目的一等奖1名，服装设计项目的二等奖2名，团体总成绩第一名的优异成绩，骆臣但、王维维两名同学获得“国赛”资格，将代表北京队进军全国大赛', 6),
	(3, b'1', '<p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 37px"><span style="line-height: 24px;font-family: 宋体;color: black;font-size: 16px">4</span><span style="line-height: 24px;font-family: 宋体;color: black;font-size: 16px">月28日上午，黄庄职高在鲁谷校区操场举行赴台湾学习考察汇报会。石景山区台办副主任牛利华、石景山区委教工委副书记王鑫等领导出席会议。汇报会由北京市黄庄职业高中招就办主任史勃和学生会主席金宛茹主持。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 37px"><span style="line-height: 24px;font-family: 宋体;color: black;font-size: 16px">参访团团长、黄庄职高吴世霞书记首先总结了我校3月22-28日赴台考察学习的基本情况。</span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">作为北京市青少年涉台教育基地中唯一一所职业学校，学校一直积极探索和完善涉台教育的模式。</span><span style="line-height: 24px;font-family: 宋体;color: black;font-size: 16px">此次访台是黄庄职业高中第一次带领学生走出境外，学生们第一次在境外展示自己的技能，第一次与境外师生面对面深入交流，吴书记用“圆满完成破冰之旅”总结此次台湾之行，此次破冰之旅为今后两岸师生“常态化”互访、学习搭建了平台，同时台湾职业学校开放办学的理念、国际化办学水准的追求、德育教育的实效性等也给学校带来收获和启发。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 37px"><span style="line-height: 24px;font-family: 宋体;color: black;font-size: 16px"><img border="0" src="/ueditor/jsp/upload/image/20150509/1431131449333018857.jpg" style="border-color: rgb(0, 0, 0)"/></span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 37px"><span style="line-height: 24px;font-family: 宋体;color: black;font-size: 16px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 吴世霞书记总结赴台活动情况</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 37px"><span style="line-height: 24px;font-family: 宋体;color: black;font-size: 16px">此次出访台湾的服装设计与工艺、中餐烹饪与营养膳食、美容与形象设计三个专业的师生代表分别发言，汇报了他们在台湾地区的考察成果。美容美发专业以“自信源于实力”、 服装专业以“一粒盘扣思故土，两岸交融共圆梦” 为主题，与现场观众分享了他们的所学、所感、所悟。此次台湾之行，大家更加坚定了学校在专业建设、教学改革、传统技艺继承和创新等方面的信心。同时台湾职业学校在注重专业综合素养、注重国际交流与合作等方面给专业带来诸多构想和思路。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 37px"><span style="line-height: 24px;font-family: 宋体;color: black;font-size: 16px"><img border="0" src="/ueditor/jsp/upload/image/20150509/1431131449415080425.jpg" style="border-color: rgb(0, 0, 0)"/></span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 37px"><span style="line-height: 24px;font-family: 宋体;color: black;font-size: 16px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 黄庄职高服装专业师生汇报赴台心得</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 37px"><span style="line-height: 24px;font-family: 宋体;color: black;font-size: 16px">行政后勤副校长冯宏霞在汇报中谈到，两岸职业教育不仅“在校企合作、理实一体和探索学历教育和职业资格证书的融合方面具有共通之处”，在“培养和市场零距离的复合型人才”方面具有相同定位，两岸职业教育同样处在“大洗牌和转轨关键时期”，同样肩负着培养技能型人才的重任，任重而道远。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 37px"><span style="line-height: 24px;font-family: 宋体;color: black;font-size: 16px">听取汇报后，区台办副主任牛利华对此次学习考察的成果给予了高度评价。</span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">校长倪晓辉在总结赴台师生汇报成果时指出，此次赴台交流的师生都取得了较大的成果，拓展了职业教育对台交流合作的层面，进一步推进学校对外开放办学向纵深发展。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 37px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px"><img border="0" src="/ueditor/jsp/upload/image/20150509/1431131449745080118.jpg" style="border-color: rgb(0, 0, 0)"/></span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 37px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 区台办牛利华副主任发言</span></p><p><br/></p>', '2015-05-09 08:30:51', 'system', '/ueditor/jsp/upload/image/20150509/pic_841.jpg', b'1', '用传统文化技艺架起两岸职教沟通的桥梁', 'news', '黄庄职高在鲁谷校区操场举行赴台湾学习考察汇报会。石景山区台办副主任牛利华、石景山区委教工委副书记王鑫等领导出席会议。汇报会由北京市黄庄职业高中招就办主任史勃和学生会主席金宛茹主持', 6),
	(4, b'0', '<p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">“</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">努力让每个人都有人生出彩的机会</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">”</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">。习近平总书记在全国职业教育工作会议召开之时的重要指示，为中职德育指明了方向。</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">2015</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">年</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">4</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">月</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">28</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">日下午，黄职师生</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">1000</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">余人汇聚在田径场上，迎来了第</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">20</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">届体育文化节，学校举办了隆重的开幕式，今年的开幕式上与往年不同，学校将主席台变成了舞台，入场式变成了表演，别看这不大不小的变化，蕴含着意义却深远——黄庄职高的舞台属于每一名有梦想的中职学生。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">目前学校共有</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">32</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">个社团，主要是学校引导、教师指导为主要方式的组建模式，已成为校园文化建设的重要载体，其中体育健身类</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">5</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">个、美育、心育类</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">6</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">个、语言文学类</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">6</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">个、生活技巧类</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">7</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">个、专业技术类</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">9</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">个，共有</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">36</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">个社团辅导老师。</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">100%</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">的在校学生有自己的社团课堂，社团文化已成为校园文化建设中一个非常重要的内容。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">本次社团展示活动，以静态、动态、表演、竞技及宣传五种方式进行展示，开幕式上合唱社、舞蹈社、曲艺社及部分专业进行表演类展示。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">我们的社团不仅仅是大家选择的课堂，很多学生还通过社团认识社会，走向更高的舞台，如民族舞社团已参加了两届北京市职教系统运动会的开幕式，并于今年</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">3</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">月参加了石景山区第</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">18</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">届文化艺术节舞蹈类比赛</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">;</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">；青春镜界”微电影社穿梭于校园里的各个角落，用艺术去展现校园里丰富多彩的生活</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">;</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">新成立的话剧社，第一个目标将参加</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">2016</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">年北京市青少年话剧节。</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">&nbsp;</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">学校还将发展更多的社团，打造更有影响力的社团，并走向国际舞台。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">本届活动学校初步尝试利用微信的扫一扫，在网上进行投票。每一块社团展板上都有一个二维码，大家可以扫描任意一块展板上的二维码，进入投票界面，进行投票，可以评选你心目中的优秀社团，为保证公平，每个手机、每个微信账号只能投一次票，每次可以选择</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Calibri">10</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">个您喜爱的社团，最后学校将对数据进行整理，将统计结果在全校公布。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-size: 16px"><span style="font-family:宋体"><img border="0" src="/ueditor/jsp/upload/image/20150509/1431131761488068899.jpg" style="border-color: rgb(0, 0, 0)"/></span></span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-size: 16px"><span style="font-family:宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;美甲社作品</span></span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-size: 16px"><img border="0" src="/ueditor/jsp/upload/image/20150509/1431131761672080140.jpg" style="border-color: rgb(0, 0, 0)"/></span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-size: 16px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;烹饪专业改编《小苹果》</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-size: 16px"><img border="0" src="/ueditor/jsp/upload/image/20150509/1431131762064094341.jpg" style="border-color: rgb(0, 0, 0)"/></span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-size: 16px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;云裳社作品团扇</span></p><p><br/></p>', '2015-05-09 08:36:03', 'system', '', b'1', '努力让每一名学生都有人生出彩的机会', 'news', '习近平总书记在全国职业教育工作会议召开之时的重要指示，为中职德育指明了方向。2015年4月28日下午，黄职师生1000余人汇聚在田径场上，迎来了第20届体育文化节，学校举办了隆重的开幕式，今年的开幕式上与往年不同，学校将主席台变成了舞台，入场式变成了表演，别看这不大不小的变化，蕴含着意义却深远——黄庄职高的舞台属于每一名有梦想的中职学生。', 1),
	(5, b'0', '<p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">4</span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">月3日，“人才培养与产业协同发展研讨会”在我校召开，石景山区教委职成科科长朱志学一行三人、用友新道科技有限公司北京分公司总经理宋健、石景山区业余大学杨文霞校长、我校吴世霞书记、倪晓辉校长以及相关主管校长及处室主任参会。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">研讨会上，宋健总经理首先做了《深化新型校企合作，共谈实践育人新道》的专题讲座。宋健总经理以“培训．教育双轨体验学习中心建设”为主题，对建立双轨体验中心的时代紧迫性、建设方案设计的理论依据、内涵要求、预期目标、成果转化等内容进行了深入阐述，尤其对目前校企合作的广阔空间，人才培养模式的时代跟进、课程开发以及产品研发的创新性、示范性提出了诸多前瞻性的设想，为把企业搬进校园，打造职业梦想社区提供了崭新的研究思路。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">朱志学科长对黄职搭建的职业教育与成人教育联盟平台表示赞扬，对我区未来“政府统筹，资源共享，功能多样，服务社会”的大教育体系充满期待，他鼓励两所学校做好顶层设计，发挥各自优势，调动多方资源，与企业联手打造石景山区会计金融人才培养基地，更好的为区域经济发展服务。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">杨文霞校长向参会嘉宾介绍了石景山区业余大学未来的发展思路和会计专业近年来取得的优异成绩，并表明了与黄庄职高和企业深度合作的真诚意愿。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">吴世霞书记代表校领导发言，她强调教育既要适应时代变革，也要突出育人本色，要依据国家形势变化，找准市场需求和专业发展定位，提高人才培养质量，为社会输送优质资源，为学生终身发展创造条件。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">本次研讨会以企业为媒介，搭建“校校联盟、服务区域”新路径，为进一步完善石景山区教育配套资源，促进优秀资源在区域间的流动和交流，提升职业教育在社会的辐射带动力发挥了积极的作用。</span></p><p><br/></p>', '2015-05-09 08:37:06', 'system', '', b'1', '校企合力，职成联盟，开辟教育发展新天地', 'news', '4月3日，“人才培养与产业协同发展研讨会”在我校召开，石景山区教委职成科科长朱志学一行三人、用友新道科技有限公司北京分公司总经理宋健、石景山区业余大学杨文霞校长、我校吴世霞书记、倪晓辉校长以及相关主管校长及处室主任参会', 1),
	(6, b'0', '<p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">在新修订的《中等职业学校德育大纲中》明确提出：“要加强互联网等新媒体的建设与管理，优化校园网络环境，加强正面信息的网络传播”。在我们被网络包围的时代里，网络已成为学生获取信息的主渠道，学校进一步完善网络平台建设，丰富网站内容，特成特色教育板块。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">4</span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">月1日，校园文化特色项目组再次组织网络德育平台建设研讨会，校园文化特色项目组组长刘荣、特色办王向阳主任、科研室古春燕主任以及部分德育教师及班主任参加研讨会，北京四合天地科技有限公司的网络设计师介绍了&nbsp;“社会主义核心价值观虚拟三维课堂”、“国防知识虚拟三维课堂”等网络虚拟课堂的建设情况，参会教师结合学校实际，从课程内容、教学形式等方面对网络德育平台建设提出中肯的意见和建议。下一步，网络设计师将对网络德育平台进行进一步的完善，真正把网站建设成为面向师生、服务师生的良好平台。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px"><img border="0" src="/ueditor/jsp/upload/image/20150509/1431131872642011502.jpg" style="border-color: rgb(0, 0, 0)"/></span></p><p><br/></p>', '2015-05-09 08:37:54', 'system', '', b'1', '黄庄职高召开网络德育平台建设研讨会', 'news', '在新修订的《中等职业学校德育大纲中》明确提出：“要加强互联网等新媒体的建设与管理，优化校园网络环境，加强正面信息的网络传播”。在我们被网络包围的时代里，网络已成为学生获取信息的主渠道，学校进一步完善网络平台建设，丰富网站内容，特成特色教育板块。', 9),
	(7, b'0', '<p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">在新修订的《中等职业学校德育大纲中》明确提出：“要加强互联网等新媒体的建设与管理，优化校园网络环境，加强正面信息的网络传播”。在我们被网络包围的时代里，网络已成为学生获取信息的主渠道，学校进一步完善网络平台建设，丰富网站内容，特成特色教育板块。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">4</span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">月1日，校园文化特色项目组再次组织网络德育平台建设研讨会，校园文化特色项目组组长刘荣、特色办王向阳主任、科研室古春燕主任以及部分德育教师及班主任参加研讨会，北京四合天地科技有限公司的网络设计师介绍了&nbsp;“社会主义核心价值观虚拟三维课堂”、“国防知识虚拟三维课堂”等网络虚拟课堂的建设情况，参会教师结合学校实际，从课程内容、教学形式等方面对网络德育平台建设提出中肯的意见和建议。下一步，网络设计师将对网络德育平台进行进一步的完善，真正把网站建设成为面向师生、服务师生的良好平台。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px"><img border="0" src="/ueditor/jsp/upload/image/20150509/1431131945466037124.jpg" style="border-color: rgb(0, 0, 0)"/></span></p><p><br/></p>', '2015-05-09 08:39:07', 'system', '', b'1', '黄庄职高召开网络德育平台建设研讨会', 'news', '在新修订的《中等职业学校德育大纲中》明确提出：“要加强互联网等新媒体的建设与管理，优化校园网络环境，加强正面信息的网络传播”。在我们被网络包围的时代里，网络已成为学生获取信息的主渠道，学校进一步完善网络平台建设，丰富网站内容，特成特色教育板块', 5),
	(8, b'1', '<p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">3</span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">月</span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">7</span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">日，由北京市总工会、北京市教育委员会主办的“首都女职工庆三八服装时尚风采大赛”在北京服装学院隆重举行，我校曲颖、龙丹、刘荣等</span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">13</span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">名女职工荣幸地代表石景山区总工会参加比赛，荣获三等奖。我校</span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">吴世霞书记及石景山区总工会领导亲临现场观赛。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">在现场展示中，她们身着8套青花瓷主题旗袍和5套中式礼服旗袍，伴随着优美和谐的韵律向观众款款走来，优美流畅的线条不仅充分展现了女性的形体美，也尽显女性端正典雅和华丽高贵的仪态美，这13套“京式”旗袍均由我校旗袍工作室的师生设计制作，广受评委和观众的赞叹和好评。不仅充分展现了黄职女教师风采，也让更多的人了解了我校“京式”旗袍这一非物质文化遗产项目。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px"></span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px"></span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 黄职女教师参加庆三八服装风采大赛</span></p><p><br/></p>', '2015-07-21 15:47:48', 'system', '/ueditor/jsp/upload/image/20150509/news_pic_258.png', b'1', '庆三八服装表演，黄职女教师展风采', 'achievement', '“首都女职工庆三八服装时尚风采大赛”在北京服装学院隆重举行，我校曲颖、龙丹、刘荣等13名女职工荣幸地代表石景山区总工会参加比赛，荣获三等奖。我校吴世霞书记及石景山区总工会领导亲临现场观赛。', 9),
	(9, b'0', '<p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">直升机常常被小孩子们叫作蜻蜓飞机，在他们眼里直升机是灵巧可爱的。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">在夏季大雨来临前，蜻蜓就会成群结对在空中穿梭飞舞着。它们好像一架架直升机忽上忽下、忽快忽慢地飞行,它们时而抖动翅膀来一个一百八十度的急转弯，时而在空中悬停,时而降落在尖尖的枝梢和花丛中，时而又飞得无影无踪。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;"><br/></p><p><img src="/ueditor/jsp/upload/image/20150509/1431133206064055366.jpg" width="440" height="292" border="0" hspace="0" vspace="0" title="竹蜻蜓" style="border: 0px; display: block; width: 440px; height: 292px;"/><span class="d-detail-imgTitle" style="display: block; padding: 5px 0px; line-height: 1.5; font-size: 12px; color: rgb(111, 111, 111); width: 440px;">竹蜻蜓</span></p><p><br/></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">古代流转至今的一种叫“竹蜻蜓”的玩具，传说就是在蜻蜓的启发下被制作出来的。后来竹蜻蜓传入欧洲，被称为“中国陀螺”，它开拓了科学家们的研究思路，为直升机的诞生提供了灵感。《简明不列颠百科全书》记载道：“直升机是人类最早的飞行设想之一，多年来人们一直相信最早提出这一想法的是达·芬奇，但现在都知道，中国人比中世纪的欧洲人更早做出了叫‘中国陀螺’的直升机玩具。”</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">说到达·芬奇，他不但是一位杰出的画家，还是一位发明家，早在15世纪，他就着手研究飞行器。他画过一张飞行器的草图，设想中的飞行器以弹簧为旋转动力，当达到一定转速时，就会把机体带到空中。驾驶员拉动钢丝绳，掌握着飞行方向。这被认为是最早的直升机设计蓝图。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">可惜的是，达·芬奇对于直升机的构想，只是在纸上画画而已，并没有付诸于实际行动。但他的行为却为后来直升飞机的发明提供了灵感，引领了正确的思维方向，它被公认是直升飞机发展史的起点。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;"><br/></p><p><img src="/ueditor/jsp/upload/image/20150509/1431133206321056627.jpg" width="440" height="350" border="0" hspace="0" vspace="0" title="达芬奇设计的直升机的概念图" style="border: 0px; display: block; width: 440px; height: 350px;"/><span class="d-detail-imgTitle" style="display: block; padding: 5px 0px; line-height: 1.5; font-size: 12px; color: rgb(111, 111, 111); width: 440px;">达芬奇设计的直升机的概念图</span></p><p><br/></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">世界上第一个制造出载人直升飞机的人，是法国利济厄市的工程师保罗·科努（Paul Cornu）。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">科努小时候就喜爱搞小发明，尤其对莱特兄弟的飞行器研究特别感兴趣，希望有一天也能够像他们那样设计出自己的飞行器，像蜻蜓和小鸟一样在蔚蓝的天空上自由地飞翔。长大以后，科努全身心地投入到了飞机的研制工作中，追寻自己蔚蓝色的飞天梦。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">1906年，保罗·科努开始实施他的直升机发明计划。他设计出了飞机的两副旋翼，又在旋翼上安装了桨叶，再用钢管做成飞机的主构架，而后又安装了驾驶员座椅、发动机、水箱、油箱等。直到1907年8月，他才制造出了世界上第一架载人直升飞机。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">当他为自己的杰作诞生长出了一口气的时候，却意外得知法国科学家布雷盖和李歇也研制出了一架直升飞机。自己的直升飞机还没有真正地飞上蓝天，别人的飞机已研制出来，科努的心里真不是滋味。多年的努力将前功尽弃，因为发明创造一旦落在了别人的后面，就没有什么价值可言了。</p><p><br/></p>', '2015-05-09 09:00:09', 'system', '', b'1', '直升机是如何被发明的？', 'knowledge', '', 3),
	(10, b'0', '<p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">4月25日的尼泊尔大地震不仅给该国带来重大的伤亡和损失，也使得首都加德满都移动了3米，珠峰高度下降2.5厘米。纵观历史和现在，地震、海啸和火山等大型自然灾难从来没有停止过改变地貌的脚步，仿佛大自然的搬运工和魔术师，不仅能让高山变矮，让国土变大，还能把岛屿变没，令地轴偏移，令人惊叹。<br/></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);"><strong>挪窝了：尼泊尔地震让加德满都移动3米</strong></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;"><br/></p><p><img src="/ueditor/jsp/upload/image/20150509/1431133971257036781.jpg" width="440" height="297" border="0" hspace="0" vspace="0" title=" 图为尼泊尔强震后的情景。 中新社发 张浩 摄" style="border: 0px; display: block; width: 440px; height: 297px;"/><span class="d-detail-imgTitle" style="display: block; padding: 5px 0px; line-height: 1.5; font-size: 12px; color: rgb(111, 111, 111); width: 440px;">图为尼泊尔强震后的情景。 中新社发 张浩 摄</span></p><p><br/></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">专家说，尼泊尔大地震让首都加德满都地面向南移动了多达3米。地震专家根据本次地震发生后从地壳声波录得的早期地震数据，测算出加德满都底下的地基可能向南移动了约3米。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);"><strong>变矮了：尼泊尔地震后珠峰高度降2.5厘米</strong></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;"><br/></p><p><img src="/ueditor/jsp/upload/image/20150509/1431133971492014360.jpg" width="440" height="246" border="0" hspace="0" vspace="0" title="图为直升机在珠峰上准备降落" style="border: 0px; display: block; width: 440px; height: 246px;"/><span class="d-detail-imgTitle" style="display: block; padding: 5px 0px; line-height: 1.5; font-size: 12px; color: rgb(111, 111, 111); width: 440px;">图为直升机在珠峰上准备降落</span></p><p><br/></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">UNAVCO科学家确认，尼泊尔地震后，世界最高峰高度下降1英寸（2.5厘米）。其证据来自欧洲航天局Sentinel-1A卫星4月29日在珠穆朗玛峰上放采集到的数据。专家称：“地震引起的印度板块和欧亚板块移动后造成了地壳松动。这导致珠峰高度稍稍下降。”</p><p><br/></p>', '2015-05-09 09:12:53', 'system', '', b'1', '地震对地球的影响有多大？', 'knowledge', '', 3),
	(11, b'0', '<p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">大众心理学已经成为我们社会的重要组成部分，以格言、真理和半真理的形式充斥着我们日常生活的每一天，为我们提供了成堆的建议，引导我们走过人生的坎坷。每年大约有3 500本自助类图书出版，每月有大量的心理健康网站涌现（朋友圈的分享就更别提了）。<br/></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">其中一些信息是准确、有用的，但也有些大众心理学文章充斥着我们所谓的“心理学谬论”（psychomythology）。由于在辨别心理学事实与虚构信息时缺乏可靠的专业指引，公众只好任由自助大师、脱口秀电视节目主持人以及自诩的心理健康专家摆布，而这些人当中，有许多都是在传播不可靠的心理学信息和指导。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;"><br/></p><p><img src="/ueditor/jsp/upload/image/20150509/1431134045461049690.jpg" width="440" height="293" style="border: 0px; display: block;"/></p><p><br/></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">比如，下面这些普遍认同的观点就基本上或者完全是错误的：<br/></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">■ 大多数人只使用了全部脑力的10%。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">■ 恋爱时，迥然不同的两个人更容易相互吸引。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">■ 我们的大脑会像摄像机那样如实地记忆事件。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">■ 精神分裂症患者有多重人格。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">■ 只有抑郁的人才会自杀。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">■ 所有成功的心理疗法都强迫人们面对源自童年时期的问题根源。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">有一些观点，比如“大多数人只使用了10%的脑力”，似乎是源于对盛行数十年、当前仍不足为信的断言“科学家不知道另外90%的大脑在做什么”的扭曲诠释。其他错误观点很可能是由选择性注意和记忆引起。例如，我们所有人都倾向于注意或者回想起不寻常的偶发事件，因此相比于记住两个相似的人彼此看对眼，我们更可能记住个性迥异的两个人坠入爱河。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">还有一些荒诞观念可能源于我们日常经验的强势诱导。例如，我们主观上认为记忆是真实的，这种真实性毫无疑问。然而事实上，众多研究表明，我们的记忆会随着时间的流逝而扭曲变形。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">我们将在本文中揭露以下6个大众心理学谬论的真相：</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);"><strong>谬论一：发泄比压抑更健康</strong></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">人们总是认为发泄比压抑更健康。在一项调查中，66%的大学本科生认为，把憋在心中的怒火发泄出来是控制攻击情绪的一个好办法。这一观点要追溯到亚里士多德，他发现，观看悲剧表演有助于宣泄情绪、熄灭怒火、消除其他负面情绪。</p><p><br/></p>', '2015-05-09 09:15:18', 'system', '', b'1', '6个大众心理学谬论，真相是什么？', 'knowledge', '', 3),
	(12, b'0', '<p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">当有导弹或是陨石撞击地面，对地表造成的巨大的冲击是显而易见的，但地表以下究竟发生了什么，就很难一窥究竟了。来自杜克大学的物理学家已经研究出了这样一种技术，能够在实验室中模拟人工土壤和砂地遭受高速撞击的情境，随后可以利用超慢动作回放对地表以下的状况进行近距离的观察。<br/></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;"><br/></p><p><img src="/ueditor/jsp/upload/image/20150509/1431134078647041070.jpg" width="330" height="500" style="border: 0px; display: block;"/></p><p><br/></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">一项发表在学术期刊《物理学评论》（Physical Review Letters）上的研究报告称，类似于土壤和砂质的物质在经受撞击后强度会变高，而且撞击越猛烈强度就越高。研究人员称，这一发现解释了为什么如果要使探地导弹进入地下更深的位置，仅靠猛烈和高速的对地射击效果反而非常有限。抛射物进入土壤和砂地的速度越是快，就会遭遇越强的抵抗并越快停止前进。由于该项研究是由美国五角大厦的防恐怖威胁署（DTRA）出资，所以可能最终的研究方向会致力于更有效地控制地面穿透型导弹的穿透力，该类导弹的设计初衷是用于破坏被深埋在地底的目标，如敌对方的地堡或地下武器物料储备。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">为了模拟撞击进入地表的导弹或陨石，研究人员从7英尺高（213.36米）的天花板上向一个布满各种小珠的坑中投掷带有圆锥形尖头的金属抛射物。在碰撞过程中，抛射物的动能被转移到了这些小珠子上，并且由于坑中表层以下的小珠子们紧密地首尾相接，动能被分散，冲击形成的力量因此被吸收掉了。</p><p><br/></p>', '2015-05-09 09:15:39', 'system', '', b'1', '当导弹或陨石撞击地面时，地面以下是什么状况？', 'knowledge', '', 6),
	(13, b'0', '<p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">一些极为简单的动物已经成功“摆脱”它们的大脑，例如海绵，因为大脑对它们的存活没有任何作用。摆脱对大脑的依赖可能就是它们生存至今的关键所在。 英国伦敦大学国王学院的弗兰克-希尔斯表示：“如果你坐在海床上，只滤食从你身旁流过的食物，你就不需要一个大脑。在这种情况下，有一个大脑是对能量的一 种浪费，你无法让身体保持所需的能量水平。”</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;"><br/></p><p><img src="/ueditor/jsp/upload/image/20150509/1431134199735057550.jpg" width="440" height="247" border="0" hspace="0" vspace="0" title="海绵是一种极为简单的动物，没有大脑，甚至没有任何神经细胞，但它们仍活的好好的。" style="border: 0px; display: block; width: 440px; height: 247px;"/><span class="d-detail-imgTitle" style="display: block; padding: 5px 0px; line-height: 1.5; font-size: 12px; color: rgb(111, 111, 111); width: 440px;">海绵是一种极为简单的动物，没有大脑，甚至没有任何神经细胞，但它们仍活的好好的。</span></p><p><br/></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);"><strong>无脑或是生存优势</strong></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">海绵不会思索生命的意义或者起源这样的哲学命题。但从某种程度上说，它们的生存能力超过我们人类。这个神奇的家族已经在地球上生存了数亿年之久，利用多孔身体吸取海床上的营养物质存活。它们是一种极为简单的动物，在我们人类看来已经达到可笑的程度。更令人感到惊奇的是，海绵没有大脑，甚至没有任何神经细胞，但它们仍活的好好的。海绵的无脑可能是一个生存优势，是长时间的进化让它们放弃了大脑。一些科学家认为它们一度拥有大脑或者至少拥有一个与大脑非常接近的 器官，但随着时间的推移，它们摆脱了大脑。海绵并不是唯一一种没有大脑的动物。对我们人类来说，大脑是一个必需品，但对于一些动物来说，没有大脑反而生活的更好。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;"><br/></p><p><img src="/ueditor/jsp/upload/image/20150509/1431134199855010532.jpg" width="440" height="247" border="0" hspace="0" vspace="0" title="对我们人类来说，大脑是一个必需品，但对于这些动物来说，没有大脑反而生活的更好。" style="border: 0px; display: block; width: 440px; height: 247px;"/><span class="d-detail-imgTitle" style="display: block; padding: 5px 0px; line-height: 1.5; font-size: 12px; color: rgb(111, 111, 111); width: 440px;">对我们人类来说，大脑是一个必需品，但对于这些动物来说，没有大脑反而生活的更好。</span></p><p><br/></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">大脑是无数神经细胞的集合体。很多生物并没有真正的大脑，但它们拥有一张“神经网”，遍布身体各处。然而，海绵并没有这样一张网。人类的大脑起源于40亿年前，当时地球上出现第一批生命。我们最早的祖先是单细胞生物，几十亿年后，更为复杂的生物出现。现在尚不清楚这些更为复杂的动物是否拥有任何神经细胞。</p><p><br/></p>', '2015-05-09 09:16:41', 'system', '', b'1', '有些动物的大脑为何丢了？', 'knowledge', '', 9),
	(14, b'0', '<p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">创可贴由于其方便、易用，是家庭常备的医疗用品之一。但最近网上一则“使用创可贴导致女童截肢”的消息引起了大家对创可贴使用的讨论。据报道，本月4日苏州一家医院收治了一名4岁女童雯雯，在送医时发现雯雯的左手中指末节发黑，已经坏死多日，需要进行截肢手术来防止病情进一步恶化。报道指出，雯雯的手指坏死，是因为受伤后，贴了张创可贴所致。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">那么，为何贴了一张小小的创可贴会导致手指截肢这样严重的后果呢？在平时的生活中，如何安全、正确的使用创可贴呢？</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;"><br/></p><p><img src="/ueditor/jsp/upload/image/20150509/1431134237219064616.jpg" width="440" height="293" style="border: 0px; display: block;"/></p><p><br/></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);"><strong>创可贴其实是躺枪</strong></p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">这则新闻公布后，引得大家纷纷表示“创可贴真可怕”。但其实仔细分析一下报道可以发现，创可贴在这一事件中只是“躺枪”，而“主凶”则另有其物。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">我们来看看报道中的描写：“大约10天前，雯雯左手中指末端受伤，当时就用了一张创可贴包扎了一下。后来，担心创可贴松掉脱落，雯雯就自己又用布条将手指上的创可贴包扎了起来。”此外雯雯的奶奶在事后也表示“为防止布条松掉脱落，雯雯又在布条上，用牛皮筋进行缠裹。”可见，除了直接接触皮肤的创可贴外，雯雯的手指上至少还捆扎上了一根布条和牛皮筋，而后两者，更可能是造成雯雯中指截肢的真凶。</p><p style="margin-top: 0px; margin-bottom: 20px; padding: 0px; text-indent: 2em; color: rgb(53, 53, 53); font-family: &#39;microsoft yahei&#39;; line-height: 28px; white-space: normal; background-color: rgb(255, 255, 255);">对于创可贴来说，其主要结构是一节具有粘性的胶布，胶布的粘性是其附着在皮肤和创面上的主要因素。同时由于创可贴宽度较大，因此对皮肤的压强较小，虽然过度缠紧会造成血流不畅，但很难绷紧到使得组织缺血甚至坏死的程度。而对于布条和牛皮筋来说就不同了：由于二者不具有粘性，因此需要依靠紧扎时产生的足够大的摩擦力才不至于滑脱，这就意味这需要将布条或皮筋紧紧的扎住。而由于布条较细，压迫面积小，因此同样的捆扎力下对皮肤压强更大；而牛皮筋由于具有很强的弹性，因此捆扎是产生的压迫更为严重。在这一事件中，雯雯是为了防止创可贴送掉而捆扎的布条，而橡皮筋则又是防止布条滑落缠上的，由此可见创可贴本身缠绕的并不紧实。因此说，造成雯雯手指坏死的元凶，并不是创可贴，而是布条和牛皮筋。而牛皮筋，则又是主凶中的主凶。</p><p><br/></p>', '2015-05-09 09:17:19', 'system', '', b'1', '创可贴何以至截肢？', 'knowledge', '', 13),
	(15, b'0', '<p><span style="color: rgb(51, 51, 51);font-size: 14px;line-height: 22px;text-indent: 28px;font-family: 宋体">学校定于</span><span style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;text-indent: 28px;"><span style="font-family:Calibri">5</span></span><span style="color: rgb(51, 51, 51);font-size: 14px;line-height: 22px;text-indent: 28px;font-family: 宋体">月</span><span style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;text-indent: 28px;"><span style="font-family:Calibri">16</span></span><span style="color: rgb(51, 51, 51);font-size: 14px;line-height: 22px;text-indent: 28px;font-family: 宋体">日进行</span><span style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;text-indent: 28px;"><span style="font-family:Calibri">2015</span></span><span style="color: rgb(51, 51, 51);font-size: 14px;line-height: 22px;text-indent: 28px;font-family: 宋体">年大型招生咨询会，届时将有行业、企业专家、高级技师亲临现场，对招生政策、专业知识和就业前景进行详细解答。</span></p>', '2015-05-09 09:32:44', 'system', '', b'1', '我校将于5月16日举办校园开放日', 'notice', '', 8),
	(16, b'0', '<p><span style="color: rgb(51, 51, 51);text-indent: 32px;line-height: 24px;font-family: Arial, sans-serif;font-size: 16px">3</span><span style="color: rgb(51, 51, 51);text-indent: 32px;line-height: 24px;font-family: 宋体;font-size: 16px">月</span><span style="color: rgb(51, 51, 51);text-indent: 32px;line-height: 24px;font-family: Arial, sans-serif;font-size: 16px">11</span><span style="color: rgb(51, 51, 51);text-indent: 32px;line-height: 24px;font-family: 宋体;font-size: 16px">日，黄庄职高会计专业</span><span style="color: rgb(51, 51, 51);text-indent: 32px;line-height: 24px;font-family: Arial, sans-serif;font-size: 16px">“</span><span style="color: rgb(51, 51, 51);text-indent: 32px;line-height: 24px;font-family: 宋体;font-size: 16px">曹明工作室</span><span style="color: rgb(51, 51, 51);text-indent: 32px;line-height: 24px;font-family: Arial, sans-serif;font-size: 16px">”</span><span style="color: rgb(51, 51, 51);text-indent: 32px;line-height: 24px;font-family: 宋体;font-size: 16px">在校内实训基地记账公司开始了新学期第一次</span><span style="color: rgb(51, 51, 51);text-indent: 32px;line-height: 24px;font-family: Arial, sans-serif;font-size: 16px">“</span><span style="color: rgb(51, 51, 51);text-indent: 32px;line-height: 24px;font-family: 宋体;font-size: 16px">会计真实业务引进校园，提升学生实践能力</span><span style="color: rgb(51, 51, 51);text-indent: 32px;line-height: 24px;font-family: Arial, sans-serif;font-size: 16px">”</span><span style="color: rgb(51, 51, 51);text-indent: 32px;line-height: 24px;font-family: 宋体;font-size: 16px">的主题活动。曹明是黄职会计专业优秀毕业生，目前是北京市悦铭缘企业管理顾问有限公司经理、“曹明工作室”主要负责人。她自去年与学校会计专业合作，将工作室与课堂教学结合，引入小规模纳税企业、一般纳税企业最前沿的真实业务，以此提高学生的职业能力。</span></p>', '2015-05-09 10:07:11', 'system', '', b'1', '会计专业“曹明工作室” 又开课了', 'notice', '', 5),
	(17, b'0', '<p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 36px"><span style="font-family:宋体"><span style="line-height: 27px;font-size: 18px">为帮助全体教师尽快了解掌握微课设计制作的新技术、新理念，提升教师信息化教学素养和教育技术应用能力，1月28日，学校教科研处组织全校107名教师参加了“微课基础理论与制作技术”专题培训。</span></span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 36px"><span style="line-height: 27px;font-size: 18px"><span style="font-family:宋体">本次培训分为基础理论学习和制作技术学习两个部分。学校分别邀请教育部全国职业院校信息化教学大赛评委、北京市首届职教名师、北京信息职业技术学院教学处处长贾清水老师，第一、二届全国微课大赛评委、北京市朝阳区教育研究中心信息技术教研员庞博老师为老师们进行讲解。</span></span></p><p><br/></p>', '2015-05-09 10:14:28', 'system', '', b'1', '“微课基础理论与制作技术” 培训', 'notice', '', 3),
	(18, b'0', '<p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;white-space: normal"><span style="font-family: 宋体">&nbsp;烹饪专业教师郭文义被评为北京市十佳班主任。</span><span style="font-family:Times New Roman">2008</span><span style="font-family: 宋体">年</span><span style="font-family:Times New Roman">11</span><span style="font-family: 宋体">月</span><span style="font-family:Times New Roman">10</span><span style="font-family: 宋体">日</span><span style="font-family:Times New Roman">20</span><span style="font-family: 宋体">：</span><span style="font-family:Times New Roman">10</span><span style="font-family: 宋体">——</span><span style="font-family:Times New Roman">21</span><span style="font-family: 宋体">：</span><span style="font-family:Times New Roman">00</span><span style="font-family: 宋体">分，广播电视台对我校烹饪专业郭文义老师进行了</span><span style="font-family:Times New Roman">50</span><span style="font-family: 宋体">分钟的专访。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;white-space: normal"><span style="font-family: 宋体">郭</span><span style="font-family: 宋体">老师从班级管理、学生教育、烹饪技术等方面和主持人、听众朋友互动。宣传了我校烹饪专业。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;line-height: 22px;white-space: normal"><span style="font-family: 宋体">&nbsp;&nbsp; 郭</span><span style="font-family: 宋体">老师的学生刘健和他的母亲作为嘉宾，与主持人、听众朋友互动。给于了我校领导和老师高度的评价。</span></p><p><br/></p>', '2015-05-09 10:15:21', 'system', '', b'1', '郭文义被评为北京市十佳班主任', 'notice', '', 1),
	(19, b'0', '<p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;text-indent: 32px;line-height: 21px"><span style="font-size: 16px;line-height: 24px"><span style="font-family:Times New Roman">2009</span></span><span style="font-size: 16px;line-height: 24px;font-family: 宋体">年</span><span style="font-size: 16px;line-height: 24px"><span style="font-family:Times New Roman">1</span></span><span style="font-size: 16px;line-height: 24px;font-family: 宋体">月</span><span style="font-size: 16px;line-height: 24px"><span style="font-family:Times New Roman">19</span></span><span style="font-size: 16px;line-height: 24px;font-family: 宋体">日—</span><span style="font-size: 16px;line-height: 24px"><span style="font-family:Times New Roman">1</span></span><span style="font-size: 16px;line-height: 24px;font-family: 宋体">月</span><span style="font-size: 16px;line-height: 24px"><span style="font-family:Times New Roman">24</span></span><span style="font-size: 16px;line-height: 24px;font-family: 宋体">日和</span><span style="font-size: 16px;line-height: 24px"><span style="font-family:Times New Roman">2009</span></span><span style="font-size: 16px;line-height: 24px;font-family: 宋体">年</span><span style="font-size: 16px;line-height: 24px"><span style="font-family:Times New Roman">1</span></span><span style="font-size: 16px;line-height: 24px;font-family: 宋体">月</span><span style="font-size: 16px;line-height: 24px"><span style="font-family:Times New Roman">31</span></span><span style="font-size: 16px;line-height: 24px;font-family: 宋体">日—</span><span style="font-size: 16px;line-height: 24px"><span style="font-family:Times New Roman">2</span></span><span style="font-size: 16px;line-height: 24px;font-family: 宋体">月</span><span style="font-size: 16px;line-height: 24px"><span style="font-family:Times New Roman">13</span></span><span style="font-size: 16px;line-height: 24px;font-family: 宋体">日，烹饪专业安排学生杨利飞、李旭、赵杰、康迪、杨欢等</span><span style="font-size: 16px;line-height: 24px"><span style="font-family:Times New Roman">5</span></span><span style="font-size: 16px;line-height: 24px;font-family: 宋体">人利用寒假到北京射击场宾馆进行短期实训。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;text-indent: 32px;line-height: 21px"><span style="font-size: 16px;line-height: 24px;font-family: 宋体">学生在工作中虚心好学，任劳任怨，受到宾馆领导和厨师长的好评，并且表示愿意与我校烹饪专业长期合作。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;text-indent: 32px;line-height: 21px"><span style="font-size: 16px;line-height: 24px;font-family: 宋体">此举，既是对烹饪专业教学内容、教学水平的检验，也为该专业形成校内实习与企业实训相结合的教学特色增添了一份宝贵经验。</span></p><p><br/></p>', '2015-05-09 10:16:45', 'system', '', b'1', '烹饪专业校企结合特色添新章', 'notice', '', 6),
	(20, b'0', '<p>静怡夕阳</p>', '2015-07-21 10:49:31', 'system', '/ueditor/jsp/upload/image/20150721/cat3_455.jpg', b'1', '         教师设计作品', 'tworks', '静怡夕阳', 9),
	(22, b'1', '<p style="text-align: center;"><img src="/resman/ueditor/jsp/upload/image/20150721/1437470440020085372.jpg" title="1437470440020085372.jpg" alt="_MG_0748.jpg" width="361" height="230" style="width: 361px; height: 230px;"/></p>', '2015-11-10 12:08:30', 'system', '/ueditor/jsp/upload/image/20150721/_MG_0748_540.JPG', b'1', '资深三维教师——周小燕老师', 'teacherGroup', '周小燕老师', 0),
	(23, b'0', '<p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;text-align: center;line-height: 21px"><strong><span style="line-height: 28px;font-family: 宋体;font-size: 19px">——我校参加北京市技能大赛系列报道二</span></strong></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-size: 16px"><span style="font-family:Times New Roman">2012</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">北京市中等职业学校技能大赛大赛传来喜讯：在计算机应用专业比赛中，我校动漫专业七名学生参赛，全部获奖，团体总成绩第一名！其中一等奖</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Times New Roman">5</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">名、二等奖</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Times New Roman">1</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">名、三等奖</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Times New Roman">1</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">名，陈建强、李煜同学在工业产品设计</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Times New Roman">16</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">名参赛选手中夺得第一名、第二名，王国庆、赵志国在数字影音后期制作</span><span style="line-height: 24px;font-size: 16px"><span style="font-family:Times New Roman">17</span></span><span style="line-height: 24px;font-family: 宋体;font-size: 16px">名参赛选手中夺得第一名、第二名的好成绩。</span></p><p style="color: rgb(51, 51, 51);font-family: Simsun;font-size: 14px;white-space: normal;line-height: 21px;text-indent: 32px"><span style="line-height: 24px;font-family: 宋体;font-size: 16px">感谢动漫专业的参赛学生和指导教师的辛勤努力，对他们取得的优异成绩表示祝贺。希望他们继续发挥黄职人勇于拼搏、不断超越自我的精神，备战国赛，再创佳绩！</span></p><p><img src="/resman/ueditor/jsp/upload/image/20151022/1445497009038053109.jpg" title="1445497009038053109.jpg" alt="default.jpg"/></p>', '2015-10-22 14:56:50', 'system', '/ueditor/jsp/upload/image/20151022/default_457.jpg', b'1', '技能大赛风云再起 动漫专业捷报连连', 'skillContest', '感谢动漫专业的参赛学生和指导教师的辛勤努力，对他们取得的优异成绩表示祝贺。希望他们继续发挥黄职人勇于拼搏、不断超越自我的精神，备战国赛，再创佳绩！', 0),
	(24, b'1', '<p>北京市黄庄职业高中计算机动漫与游戏制作专业，为国家示范校重点建设专业，图为校领导朱宁校长、专业陈亚军主任及各位专业教师出席精品课研讨会，友邦佳通公司为精品课拍摄团队出席。</p>', '2015-07-21 17:23:53', 'system', '/ueditor/jsp/upload/image/20150721/IMG_0071_274.JPG', b'1', '北京市黄庄职业高中计算机动漫与游戏制作专业精品课启动会', 'news', '北京市黄庄职业高中计算机动漫与游戏制作专业，为国家示范校重点建设专业，校级各领导、专业主任及各位老师出席精品课研讨会。', 3),
	(25, b'1', '<p><img src="/resman/ueditor/jsp/upload/image/20150721/1437470084926027375.jpg" title="1437470084926027375.jpg" alt="_MG_0757.jpg"/></p>', '2015-11-10 12:08:48', 'system', '/ueditor/jsp/upload/image/20150721/_MG_0757_693.JPG', b'1', '资深影视剪辑教师——赵丽坤老师', 'teacherGroup', '资深影视剪辑教师——赵丽坤老师', 0),
	(26, b'1', '<p><img src="/resman/ueditor/jsp/upload/image/20150721/1437470361145034307.jpg" title="1437470361145034307.jpg" alt="_MG_0746.jpg"/></p>', '2015-11-10 12:11:04', 'system', '/ueditor/jsp/upload/image/20151110/_MG_0746_772_209.JPG', b'1', '资深漫画教师——孟凡潮', 'teacherGroup', 'test', 0),
	(27, b'0', '<p><img src="/resman/ueditor/jsp/upload/image/20150721/1437470396448072832.jpg" title="1437470396448072832.jpg" alt="_MG_0752.jpg"/></p>', '2015-07-21 17:19:58', 'system', '/ueditor/jsp/upload/image/20150721/_MG_0752_570.JPG', b'0', '资深专业教师——史凤玲', 'teacherGroup', '', 2),
	(28, b'1', '<p><img src="/ueditor/jsp/upload/image/20151020/1445331338426045246.jpg" title="1445331338426045246.jpg" alt="_MG_0730_78.jpg"/></p>', '2015-10-20 16:59:09', 'system', '/ueditor/jsp/upload/image/20151020/_MG_0730_78_378.JPG', b'1', '师资队伍', 'news', '计算机动漫与游戏制作专业全体教师', 0),
	(29, b'0', '<p style="text-align:center"><img src="/resman/ueditor/jsp/upload/image/20150721/1437470848056095423.jpg" title="1437470848056095423.jpg" alt="图01.jpg"/></p><p style="text-align:center"><img src="/resman/ueditor/jsp/upload/image/20150721/1437470853876015013.jpg" title="1437470853876015013.jpg" alt="图02.jpg"/></p><p style="text-align:center"><img src="/resman/ueditor/jsp/upload/image/20150721/1437470858734075446.jpg" title="1437470858734075446.jpg" alt="图03.jpg"/></p><p style="text-align:center"><img src="/resman/ueditor/jsp/upload/image/20150721/1437470864066078915.jpg" title="1437470864066078915.jpg" alt="图04.jpg"/></p><p style="text-align:center"><img src="/resman/ueditor/jsp/upload/image/20150721/1437470868648072908.jpg" title="1437470868648072908.jpg" alt="图05.jpg"/></p><p style="text-align: center;"><img src="/resman/ueditor/jsp/upload/image/20150721/1437470873234093976.jpg" title="1437470873234093976.jpg" alt="图06.jpg"/></p>', '2015-07-21 17:31:27', 'system', '/ueditor/jsp/upload/image/20150721/图03_641.JPG', b'1', '教师与学生体育活动', 'news', '教师与学生参加体育活动，一起合作完成游戏，特别开心。', 4),
	(30, b'1', '<p>11<img src="/ueditor/jsp/upload/image/20151020/1445331596684003974.jpg" title="1445331596684003974.jpg" alt="_MG_0730_78.jpg"/></p>', '2015-10-20 16:59:58', 'system', '/ueditor/jsp/upload/image/20151020/_MG_0730_78_359.JPG', b'1', '11', 'news', '1', 2),
	(31, b'0', '<p><img src="/ueditor/jsp/upload/image/20151022/1445481433233064871.jpg" title="1445481433233064871.jpg" alt="7.jpg"/>asdfasdf</p>', '2015-10-22 11:01:13', 'system', '/ueditor/jsp/upload/image/20151022/7_410.jpg', b'1', '学生作品', 'sworks', 'asdfasdf', 0),
	(32, b'0', '<p><img src="/ueditor/jsp/upload/image/20151022/1445479856266030051.jpg" title="1445479856266030051.jpg" alt="7.jpg"/></p>', '2015-10-22 10:10:58', 'system', '/ueditor/jsp/upload/image/20151022/7_171.jpg', b'1', 'asdf', 'news', 'asdf', 0),
	(33, b'0', '<p><img src="/resman/ueditor/jsp/upload/image/20151022/1445483973230095766.jpg" title="1445483973230095766.jpg" alt="default.jpg"/></p>', '2015-10-22 11:19:45', 'system', '/ueditor/jsp/upload/image/20151022/default_590.jpg', b'1', 'test', 'tworks', 'test', 0),
	(34, b'0',
	 '<p>1<img src="/resman/ueditor/jsp/upload/image/20151022/1445484013867057254.jpg" title="1445484013867057254.jpg" alt="default.jpg"/></p>',
	 '2015-10-22 14:56:37', 'system', '/ueditor/jsp/upload/image/20151022/default_524.jpg', b'1', 'ttt1', 'skillContest',
	 '1', 0);
/*!40000 ALTER TABLE `r_info` ENABLE KEYS */;


-- 导出  表 resman.r_notice 结构
CREATE TABLE IF NOT EXISTS `r_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `crtuser` varchar(100) DEFAULT NULL COMMENT '发布者',
  `crtdate` datetime DEFAULT NULL COMMENT '发布时间',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `state` char(1) DEFAULT NULL COMMENT '审批状态，0：待发布，1：已发布',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公告';

-- 正在导出表  resman.r_notice 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `r_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `r_notice` ENABLE KEYS */;


-- 导出  表 resman.r_ques 结构
CREATE TABLE IF NOT EXISTS `r_ques` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `crtuser` varchar(100) DEFAULT NULL COMMENT '提问人',
  `crtdate` datetime DEFAULT NULL COMMENT '提问时间',
  `state` varchar(1) DEFAULT NULL COMMENT '状态',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='问题';

-- 正在导出表  resman.r_ques 的数据：~7 rows (大约)
/*!40000 ALTER TABLE `r_ques` DISABLE KEYS */;
INSERT INTO `r_ques` (`id`, `crtuser`, `crtdate`, `state`, `title`, `content`) VALUES
	(1, '1', '2015-04-18 18:47:57', '', '华清池杨贵妃雕像的历史由来', '华清池杨贵妃雕像的历史由来'),
	(2, '1', '2015-04-18 18:47:57', '', '现在小米5出来没', '现在小米5出来没'),
	(3, '1', '2015-04-18 18:47:57', '', '无纸化初级助理会计师考试从哪一年开始实施', '无纸化初级助理会计师考试从哪一年开始实施'),
	(4, '1', '2015-04-18 18:47:57', '', '佳能小长焦能连拍吗?', '佳能小长焦能连拍吗?'),
	(5, '1', '2015-04-18 18:47:57', '', '金属手机壳会影响手机信号', '金属手机壳会影响手机信号'),
	(6, '1', '2015-04-18 18:47:57', '', '地震对地球的影响有多大？', '地震对地球的影响有多大？'),
	(7, '3', '2015-08-29 10:36:58', '1', '能否针对某人进行提问', '能否针对某一位老师进行提问。<p><br/></p>');
/*!40000 ALTER TABLE `r_ques` ENABLE KEYS */;


-- 导出  表 resman.r_res_comments 结构
CREATE TABLE IF NOT EXISTS `r_res_comments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `crtdate` datetime DEFAULT NULL,
  `crtuser` varchar(255) DEFAULT NULL,
  `resId` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  resman.r_res_comments 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `r_res_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `r_res_comments` ENABLE KEYS */;


-- 导出  表 resman.r_res_count 结构
CREATE TABLE IF NOT EXISTS `r_res_count` (
  `id` varchar(255) NOT NULL,
  `down_count` int(11) DEFAULT NULL,
  `view_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  resman.r_res_count 的数据：~105 rows (大约)
/*!40000 ALTER TABLE `r_res_count` DISABLE KEYS */;
INSERT INTO `r_res_count` (`id`, `down_count`, `view_count`) VALUES
	('03bf75a9-2fc6-4a12-98ed-a73f40529e24', 0, 1),
	('06ec0a8d-8a89-4ac3-90d7-b7618eac33b9', 0, 22),
	('091968eb-7397-4c5d-b4c3-f32d26b44b77', 1, 1),
	('0edfa1e8-d58c-4db5-8a43-0e8ee4667100', 0, 15),
	('10374954-18f4-44e1-b65d-0027f6784ca5', 0, 9),
	('1155a716-3c6c-4fb2-8f87-fab73b58f6e0', 0, 4),
	('139d87f9-103a-4253-8c3e-d7aff9eef8fa', 0, 1),
	('207ec1bc-2211-4592-8263-d303449fb6de', 0, 4),
	('257159bc-d448-4040-a5ec-3108db5d92db', 0, 9),
	('26f7834e-0f10-4688-9cab-4958905573ad', 0, 1),
	('26fba4dd-a2fe-4ba9-9e3a-2f660f31eaae', 0, 19),
	('2bf9fb84-979e-4255-ac5a-7a9dc66009b4', 0, 3),
	('2e7e895d-a81d-435b-ba69-d64dc5617474', 0, 1),
	('34054582-33c9-4aea-8c3b-4c1ab5054cd4', 0, 1),
	('379da6e0-e4bc-44c4-a86b-4b84dc32d092', 0, 1),
	('37da102a-3127-495a-8522-7404e3f35681', 0, 2),
	('381d7eee-c865-462e-9f88-af76ab823cd9', 0, 2),
	('3aa90490-8add-4552-b037-007b65aee61b', 0, 1),
	('3c1d7e99-34a7-4314-913a-205198a671c6', 0, 1),
	('3dad0ce1-a66f-4c85-bd6c-72dcacf425dc', 0, 3),
	('40316a6a-3e20-41a9-b9fd-251679780347', 0, 2),
	('408369b3-4da6-4dd4-9b29-ca3b0a519b6c', 4, 2),
	('42383cd9-c368-4d85-9840-6fe9e06839b6', 0, 3),
	('47aeef5e-79bc-4896-9197-062a2cd10d25', 0, 1),
	('4bd852b8-71c5-490a-95ea-9d2bcf835833', 0, 1),
	('4c6d7cb4-a87a-4f26-bb77-65fc75571b07', 0, 2),
	('5051e7bb-6728-4791-aa64-8e9a83d5f675', 0, 2),
	('5596c25d-5c47-400c-8b26-858e0e586288', 0, 2),
	('572775cc-1282-478f-9428-278150de1526', 0, 1),
	('575d9f63-67bc-4a1c-8300-996daff9ed18', 0, 17),
	('5db7d76b-4fae-4077-9f64-ec5b24d7ffa3', 0, 2),
	('6081663d-1712-48cb-81aa-6bb5c2c7df7f', 0, 1),
	('60cbf685-20c3-425f-9679-4057d3470553', 0, 12),
	('616a254e-803d-48a5-b2fa-d0c197e1ce64', 0, 1),
	('63bf25dd-ad1f-45e6-926a-761179e58141', 0, 1),
	('64c8873b-191c-4c27-97b2-05d3f9179cba', 0, 4),
	('6600ad77-6f07-4772-8bac-25dda0071617', 0, 1),
	('688eecd4-40ea-419d-8184-48285b72d69d', 0, 8),
	('6b839f60-7c3a-402d-b0a0-642c04b950a0', 0, 1),
	('6bba60f2-c325-48b1-9ad8-06b60f4d1c15', 0, 1),
	('6fa46639-53a1-456f-b370-f84c0c603e3a', 0, 1),
	('7130f27c-4aeb-4854-91dd-56b959782033', 0, 2),
	('7208bac5-e297-4dde-8db2-ff61f64d08e4', 0, 1),
	('73dae2c9-6ffa-4fb9-9ac1-4bcdc9060d67', 0, 6),
	('74c25ef0-2115-4b15-aea3-8e19e18e412c', 0, 6),
	('776cc489-09a8-449a-9a01-28711af1f08d', 0, 1),
	('78fcd9cd-aac9-4622-82a1-981ff6365703', 0, 25),
	('7a622771-9282-4d22-92fb-e3b21be63b72', 0, 2),
	('7c912d4e-4fbd-4c8f-a0d9-47a390c297c6', 0, 3),
	('80c8997b-87ad-4511-8fcc-6d0d1b344f83', 0, 1),
	('81a5c224-4135-43de-a090-4e4a236c3fdc', 0, 1),
	('889967c9-37d7-470b-a504-a065ab1f1b4d', 0, 2),
	('8b5d3ff1-9a03-48b5-977d-faa12d06c0f0', 0, 1),
	('8e20f1d5-c3d7-4bee-956b-2b4d82a79c22', 0, 2),
	('8e971c9b-77d4-4c10-af0a-414709ac643a', 0, 2),
	('91c621a3-50e3-4e83-b8bf-7265a68dedea', 0, 3),
	('93d1dca6-5da2-4493-bc9e-a7e17ab6f57b', 0, 10),
	('95001c8c-5c59-40ad-96b2-d52f46c09bf0', 0, 3),
	('95f21ebf-71ab-4663-8d4b-0b7e6c02572b', 0, 2),
	('974ddf24-83fc-40f4-ae7d-1773ebdc3b34', 0, 4),
	('99a2d7e8-6473-4194-82fb-30d102f1f1c2', 0, 1),
	('99bba223-9e46-4518-8ae2-587eaf064a67', 0, 1),
	('9bf56bf7-6598-429f-97ac-3a24bb2aa898', 0, 1),
	('9da6fb7b-f187-486b-8c1f-bdfd9376e021', 0, 1),
	('9f0731d8-be0f-415c-9544-5e4df5127f66', 0, 2),
	('a1771eb4-f130-485f-a891-4568bf54b559', 0, 1),
	('a2f49edd-ee2f-4d5c-94b2-89f2d6059f00', 0, 1),
	('a4c8c2ca-ebba-4dd8-a4da-50f11a78913c', 0, 5),
	('a861cc60-51fc-40c8-bfa0-a6aabb7db10a', 0, 2),
	('add7a05d-c26e-4b64-87f8-4349078216cf', 0, 2),
	('b29966db-c797-4f15-b3a7-62eccd041f61', 0, 1),
	('b2dc904f-6d6a-48a8-9226-19c8c1c6e1f2', 0, 1),
	('b5bb4f67-bb13-4708-9adb-321e857507bb', 0, 1),
	('b70a00aa-b79d-4016-81d2-ae3f5de943eb', 0, 2),
	('ba7e0b3b-e998-4377-957e-5730408fcb9a', 0, 1),
	('be20f37a-af3f-4b0b-89c6-ada598dd1ea8', 0, 1),
	('c0c7181d-2112-448f-a7ba-ccfcb6a8c1a1', 0, 1),
	('c40180dc-9c5d-46fe-a70e-d79ede1442d4', 0, 3),
	('cd185b1e-300e-48e3-a7b3-34961482cfcb', 0, 1),
	('d070fc93-2cdf-42f4-95ea-46c764aa0cc2', 0, 1),
	('d4abe2cf-1b45-4969-b437-1859c2ef4c2a', 0, 2),
	('da2dc195-0d61-499e-8216-dfb83addf716', 0, 7),
	('dc42dae8-e115-451c-ae7f-3b81001dfa22', 0, 1),
	('dc6bec62-d717-4019-9f50-fd108791791d', 0, 1),
	('dda73043-2c43-456a-a137-ad7994c88b14', 0, 1),
	('de20c325-72ee-449a-9415-f9e347f8c062', 0, 3),
	('dea5d095-3724-47b4-bbe0-7837ce0db777', 2, 0),
	('dsfsdf', 0, 1),
	('e12d371b-d99f-4429-a984-b373c1783156', 0, 1),
	('e15ac22f-2dd0-4164-9941-69f8c7820135', 0, 4),
	('e470a972-133f-4497-8176-cfb5721c9ebc', 0, 6),
	('e4efca3f-e347-4147-8245-f19267892ca6', 0, 2),
	('e578cc75-e73d-4afc-9313-b388e43424aa', 0, 1),
	('e828a4b2-4e4a-411d-9d19-eede22ab0342', 0, 2),
	('e9a7392b-b458-4feb-baa9-8bc7c72c9b1a', 0, 1),
	('ea2f9656-c88e-4f92-94c0-e98e676577ea', 0, 3),
	('eac4a513-d05d-4be6-94e8-019c2a75a690', 0, 1),
	('eb5add1e-31c1-4950-886b-f73d72de585b', 0, 2),
	('f1820eb8-6252-4765-8628-81777a1880d1', 0, 5),
	('f2e151de-e2cd-4bbb-a719-843719fce77e', 0, 7),
	('f93a448b-86c2-44ce-b7bc-2a257cc92a9a', 0, 2),
	('ff4ccde5-09f9-4598-a1e4-d0d75c1acf94', 0, 2),
	('ff550424-d3f2-4068-b9cf-ce1da84312d5', 1, 13),
	('ffa71a9b-94bd-46b6-910f-a1c77d2fe8c9', 0, 4),
	('undefined', 0, 2);
/*!40000 ALTER TABLE `r_res_count` ENABLE KEYS */;


-- 导出  表 resman.s_codes 结构
CREATE TABLE IF NOT EXISTS `s_codes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `seqNo` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- 正在导出表  resman.s_codes 的数据：~10 rows (大约)
/*!40000 ALTER TABLE `s_codes` DISABLE KEYS */;
INSERT INTO `s_codes` (`id`, `category`, `code`, `name`, `seqNo`) VALUES
	(1, 'info', 'news', '新闻', 1),
	(2, 'info', 'knowledge', '知识堂', 2),
	(3, 'info', 'skillContest', '技能大赛', 3),
	(4, 'info', 'teacherGroup', '师资队伍', 4),
	(5, 'info', 'sworks', '学生作品', 5),
	(6, 'info', 'tworks', '老师作品', 6),
	(7, 'info', 'contest_works', '大赛作品', 7),
	(8, 'info', 'achievement', '成果展示', 8),
	(9, 'info', 'notice', '通知公告', 9),
	(10, 'info', 'strategy', '攻略展示', 10);
/*!40000 ALTER TABLE `s_codes` ENABLE KEYS */;


-- 导出  表 resman.s_funcs 结构
CREATE TABLE IF NOT EXISTS `s_funcs` (
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
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=utf8;

-- 正在导出表  resman.s_funcs 的数据：~25 rows (大约)
/*!40000 ALTER TABLE `s_funcs` DISABLE KEYS */;
INSERT INTO `s_funcs` (`id`, `level`, `name`, `parent`, `seqNo`, `url`, `leaf`, `iconCls`) VALUES
	(1, 0, '系统管理', NULL, 5, '', b'0', 'fa fa-university'),
	(2, 1, '用户管理', 1, 5, '/sys/user/list', b'1', 'fa fa-users'),
	(3, 1, '角色管理', 1, 10, '/sys/role/list', b'1', 'fa fa-user'),
	(4, 1, '功能管理', 1, 15, '/sys/func/list', b'1', 'fa fa-sitemap'),
	(5, 1, '权限管理', 1, 20, '/sys/perm/list', b'1', 'fa fa-gavel'),
	(100, 0, '资源库管理', NULL, 10, '', b'0', 'fa fa-tachometer'),
	(101, 1, '精品课程', 100, 5, '/res/common/classic/list', b'1', 'fa fa-graduation-cap'),
	(102, 1, '教师空间', 100, 10, '/res/common/personal/list', b'1', 'fa fa-th-large'),
	(103, 1, '精品素材', 100, 15, '/res/common/material/list', b'1', 'fa fa-asterisk'),
	(104, 1, '精品文档', 100, 20, '/res/common/docs/list', b'1', 'fa fa-book'),
	(105, 1, '精品图库', 100, 25, '/res/common/imgs/list', b'1', 'fa fa-picture-o'),
	(200, 0, '信息发布', NULL, 15, '', b'0', 'fa fa-info-circle'),
	(201, 1, '信息管理', 200, 10, '/info/list', b'1', 'fa fa-paperclip'),
	(202, 1, '公告管理', 200, 15, '/res/notice/pageList', b'1', 'fa fa-bookmark'),
	(203, 1, '所有问答', 200, 20, '/res/question/list', b'1', 'fa fa-bookmark'),
	(300, 0, '教师空间', NULL, 20, '', b'0', 'fa fa-home'),
	(301, 1, '我的资源', 300, 5, '/res/space/list', b'1', 'fa fa-puzzle-piece'),
	(302, 1, '我的课程', 300, 10, '/res/course/list', b'1', 'fa fa-file-text'),
	(303, 1, '作业管理', 300, 15, '/res/hw/list', b'1', 'fa fa-file-text'),
	(304, 2, '文档类', 101, 5, '', b'1', NULL),
	(305, 2, '图片类', 101, 6, '', b'1', NULL),
	(306, 0, '文档类', NULL, 50, '', b'0', NULL),
	(307, 1, '文档1', 306, 51, '', b'1', ''),
	(308, 1, '我的问答', 300, 20, '/res/question/teacher/myAnswerList', b'1', 'fa fa-file-text'),
	(309, 1, '所有问答', 300, 25, '/res/question/teacher/list', b'1', 'fa fa-file-text');
/*!40000 ALTER TABLE `s_funcs` ENABLE KEYS */;


-- 导出  表 resman.s_orgs 结构
CREATE TABLE IF NOT EXISTS `s_orgs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `parent` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  resman.s_orgs 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `s_orgs` DISABLE KEYS */;
/*!40000 ALTER TABLE `s_orgs` ENABLE KEYS */;


-- 导出  表 resman.s_org_user 结构
CREATE TABLE IF NOT EXISTS `s_org_user` (
  `orgId` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  PRIMARY KEY (`orgId`,`userId`),
  KEY `FK_duts42ru4l41c4a1blbwuk8eo` (`userId`),
  CONSTRAINT `FK_duts42ru4l41c4a1blbwuk8eo` FOREIGN KEY (`userId`) REFERENCES `s_users` (`id`),
  CONSTRAINT `FK_ou17tsfan2bdnw6gtq7btd4dd` FOREIGN KEY (`orgId`) REFERENCES `s_orgs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  resman.s_org_user 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `s_org_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `s_org_user` ENABLE KEYS */;


-- 导出  表 resman.s_permissions 结构
CREATE TABLE IF NOT EXISTS `s_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `perm` varchar(60) NOT NULL,
  `resource` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- 正在导出表  resman.s_permissions 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `s_permissions` DISABLE KEYS */;
INSERT INTO `s_permissions` (`id`, `name`, `notes`, `perm`, `resource`) VALUES
	(2, '修改用户', '编辑用户权限', 'user:edit', 'user'),
	(3, '添加用户', '添加用户权限', 'user:add', 'user');
/*!40000 ALTER TABLE `s_permissions` ENABLE KEYS */;


-- 导出  表 resman.s_roles 结构
CREATE TABLE IF NOT EXISTS `s_roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `role` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- 正在导出表  resman.s_roles 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `s_roles` DISABLE KEYS */;
INSERT INTO `s_roles` (`id`, `name`, `notes`, `role`) VALUES
	(1, '系统管理员', NULL, 'admin'),
	(2, '老师', NULL, 'teacher'),
	(3, '学生', NULL, 'student');
/*!40000 ALTER TABLE `s_roles` ENABLE KEYS */;


-- 导出  表 resman.s_role_func 结构
CREATE TABLE IF NOT EXISTS `s_role_func` (
  `roleId` bigint(20) NOT NULL,
  `funcId` bigint(20) NOT NULL,
  KEY `FK_9u7j7xp6uanr9gb50xpl9bdjd` (`funcId`),
  KEY `FK_bv35saad3hjemyq251brkglkc` (`roleId`),
  CONSTRAINT `FK_9u7j7xp6uanr9gb50xpl9bdjd` FOREIGN KEY (`funcId`) REFERENCES `s_funcs` (`id`),
  CONSTRAINT `FK_bv35saad3hjemyq251brkglkc` FOREIGN KEY (`roleId`) REFERENCES `s_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  resman.s_role_func 的数据：~20 rows (大约)
/*!40000 ALTER TABLE `s_role_func` DISABLE KEYS */;
INSERT INTO `s_role_func` (`roleId`, `funcId`) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 100),
	(1, 101),
	(1, 102),
	(1, 103),
	(1, 104),
	(1, 105),
	(1, 200),
	(2, 300),
	(2, 301),
	(2, 302),
	(2, 303),
	(1, 201),
	(1, 203),
	(2, 308),
	(2, 309);
/*!40000 ALTER TABLE `s_role_func` ENABLE KEYS */;


-- 导出  表 resman.s_role_permission 结构
CREATE TABLE IF NOT EXISTS `s_role_permission` (
  `roleId` bigint(20) NOT NULL,
  `permId` bigint(20) NOT NULL,
  PRIMARY KEY (`roleId`,`permId`),
  KEY `FK_6ywh0a3ri1rc0l1xn7jv0wgw` (`permId`),
  CONSTRAINT `FK_1mt4jfq878wdva26j0a8cbv04` FOREIGN KEY (`roleId`) REFERENCES `s_roles` (`id`),
  CONSTRAINT `FK_6ywh0a3ri1rc0l1xn7jv0wgw` FOREIGN KEY (`permId`) REFERENCES `s_permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  resman.s_role_permission 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `s_role_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `s_role_permission` ENABLE KEYS */;


-- 导出  表 resman.s_sys_users 结构
CREATE TABLE IF NOT EXISTS `s_sys_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sysName` varchar(32) NOT NULL,
  `passwd` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `salt` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- 正在导出表  resman.s_sys_users 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `s_sys_users` DISABLE KEYS */;
INSERT INTO `s_sys_users` (`id`, `sysName`, `passwd`, `email`, `salt`, `state`) VALUES
	(1, 'system', '111a044067c9c8bfadca2fb8a992d2ca79dcd2fc', 'system@mail.com', '3122926fd2f6f03a', 0),
	(2, 'teacher', '111a044067c9c8bfadca2fb8a992d2ca79dcd2fc', 'teacher@mail.com', '3122926fd2f6f03a', 0),
	(3, 'student', '111a044067c9c8bfadca2fb8a992d2ca79dcd2fc', 'student@mail.com', '3122926fd2f6f03a', 0);
/*!40000 ALTER TABLE `s_sys_users` ENABLE KEYS */;


-- 导出  表 resman.s_users 结构
CREATE TABLE IF NOT EXISTS `s_users` (
  `id` bigint(20) NOT NULL,
  `name` varchar(60) NOT NULL,
  `sex` int(11) DEFAULT NULL,
  `bod` datetime DEFAULT NULL,
  `phoneNum` varchar(13) DEFAULT NULL,
  `img` longblob,
  `telNum` varchar(13) DEFAULT NULL,
  `className` varchar(50) DEFAULT NULL,
  `empNo` varchar(255) DEFAULT NULL,
  `major` varchar(50) DEFAULT NULL,
  `phone_num` varchar(13) DEFAULT NULL,
  `studentNo` varchar(20) DEFAULT NULL,
  `tel_num` varchar(13) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `userType` int(11) DEFAULT NULL,
  `college` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  resman.s_users 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `s_users` DISABLE KEYS */;
INSERT INTO `s_users` (`id`, `name`, `sex`, `bod`, `phoneNum`, `img`, `telNum`, `className`, `empNo`, `major`, `phone_num`, `studentNo`, `tel_num`, `title`, `userType`, `college`) VALUES
	(1, '管理员', 0, '2014-11-29 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, '王家林', 1, '2014-11-29 00:00:00', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, '李明', 0, '2014-11-29 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `s_users` ENABLE KEYS */;


-- 导出  表 resman.s_user_role 结构
CREATE TABLE IF NOT EXISTS `s_user_role` (
  `sysUserId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY (`sysUserId`,`roleId`),
  KEY `FK_a9i759h40010y1v5djsvl9c8e` (`roleId`),
  CONSTRAINT `FK_29oeuwxk6kmduysdriumeno64` FOREIGN KEY (`sysUserId`) REFERENCES `s_sys_users` (`id`),
  CONSTRAINT `FK_a9i759h40010y1v5djsvl9c8e` FOREIGN KEY (`roleId`) REFERENCES `s_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  resman.s_user_role 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `s_user_role` DISABLE KEYS */;
INSERT INTO `s_user_role` (`sysUserId`, `roleId`) VALUES
	(1, 1),
	(2, 2),
	(3, 3);
/*!40000 ALTER TABLE `s_user_role` ENABLE KEYS */;


-- 导出  视图 resman.v_homework 结构
-- 创建临时表以解决视图依赖性错误
CREATE TABLE `v_homework` (
	`id` BIGINT(20) NOT NULL,
	`name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`description` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`coursename` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`coursedesc` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`starttime` DATETIME NULL,
	`endtime` DATETIME NULL,
	`categoryid` BIGINT(20) NULL,
	`categoryname` VARCHAR(45) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- 导出  视图 resman.v_question 结构
-- 创建临时表以解决视图依赖性错误
CREATE TABLE `v_question` (
	`id` BIGINT(20) NOT NULL,
	`username` VARCHAR(60) NULL COLLATE 'utf8_general_ci',
	`crtuser` VARCHAR(100) NULL COMMENT '提问人' COLLATE 'utf8_general_ci',
	`title` VARCHAR(100) NULL COMMENT '标题' COLLATE 'utf8_general_ci',
	`crtdate` DATETIME NULL COMMENT '提问时间',
	`content` TEXT NULL COMMENT '内容' COLLATE 'utf8_general_ci',
	`rescount` BIGINT(21) NOT NULL,
	`state` VARCHAR(1) NULL COMMENT '状态' COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- 导出  视图 resman.v_user 结构
-- 创建临时表以解决视图依赖性错误
CREATE TABLE `v_user` (
	`id` BIGINT(20) NOT NULL,
	`sysName` VARCHAR(32) NOT NULL COLLATE 'utf8_general_ci',
	`passwd` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`email` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`salt` VARCHAR(32) NULL COLLATE 'utf8_general_ci',
	`state` INT(11) NULL,
	`name` VARCHAR(60) NULL COLLATE 'utf8_general_ci',
	`sex` INT(11) NULL,
	`bod` DATETIME NULL,
	`phoneNum` VARCHAR(13) NULL COLLATE 'utf8_general_ci',
	`telNum` VARCHAR(13) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- 导出  视图 resman.v_homework 结构
-- 移除临时表并创建最终视图结构
DROP TABLE IF EXISTS `v_homework`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_homework` AS select
        `hw`.`id` AS `id`,
        `hw`.`name` AS `name`,
        `hw`.`description` AS `description`,
        `cr`.`name` AS `coursename`,
        `cr`.`description` AS `coursedesc`,
        `hw`.`start_time` AS `starttime`,
        `hw`.`end_time` AS `endtime`,
        `cr`.`category_id` AS `categoryid`,
        `cg`.`name` AS `categoryname`
    from
        ((`r_course` `hw`
        join `r_course` `cr`)
        join `r_category` `cg`)
    where
        ((`hw`.`ntype` = '1')
            and (`hw`.`parentid` = `cr`.`id`)
            and (`cg`.`id` = `cr`.`category_id`))
    order by `hw`.`id` desc , `cr`.`category_id` ;


-- 导出  视图 resman.v_question 结构
-- 移除临时表并创建最终视图结构
DROP TABLE IF EXISTS `v_question`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_question` AS select
        `rq`.`id` AS `id`,
        `va`.`name` AS `username`,
        `rq`.`crtuser` AS `crtuser`,
        `rq`.`title` AS `title`,
        `rq`.`crtdate` AS `crtdate`,
        `rq`.`content` AS `content`,
        count(`ra`.`quesId`) AS `rescount`,
        `rq`.`state` AS `state`
    from
        ((`r_ques` `rq`
        left join `r_anwser` `ra` ON ((`rq`.`id` = `ra`.`quesId`)))
        left join `v_user` `va` ON ((`va`.`id` = `rq`.`crtuser`)))
    group by `rq`.`id` , `rq`.`crtuser` , `rq`.`title` , `rq`.`crtdate` , `rq`.`content`
    order by `rq`.`crtdate` desc ;


-- 导出  视图 resman.v_user 结构
-- 移除临时表并创建最终视图结构
DROP TABLE IF EXISTS `v_user`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_user` AS select
        `us`.`id` AS `id`,
        `us`.`sysName` AS `sysName`,
        `us`.`passwd` AS `passwd`,
        `us`.`email` AS `email`,
        `us`.`salt` AS `salt`,
        `us`.`state` AS `state`,
        `ue`.`name` AS `name`,
        `ue`.`sex` AS `sex`,
        `ue`.`bod` AS `bod`,
        `ue`.`phoneNum` AS `phoneNum`,
        `ue`.`telNum` AS `telNum`
    from
        (`s_sys_users` `us`
        left join `s_users` `ue` ON ((`us`.`id` = `ue`.`id`))) ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
