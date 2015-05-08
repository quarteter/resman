delete from s_role_func;
delete from s_user_role;
delete from s_role_permission;
delete from s_funcs;
delete from s_roles;
delete from s_sys_users;

delete from r_comment;
delete from r_course_student;
delete from s_users

insert into s_sys_users (id,sysName,email,salt,passwd,state) values(1,'system','system@mail.com','3122926fd2f6f03a','111a044067c9c8bfadca2fb8a992d2ca79dcd2fc',0);
insert into s_sys_users (id,sysName,email,salt,passwd,state) values(2,'teacher','teacher@mail.com','3122926fd2f6f03a','111a044067c9c8bfadca2fb8a992d2ca79dcd2fc',0);
insert into s_sys_users (id,sysName,email,salt,passwd,state) values(3,'student','student@mail.com','3122926fd2f6f03a','111a044067c9c8bfadca2fb8a992d2ca79dcd2fc',0);

insert into s_users (id,name,sex,bod) values (1,'管理员',0,'2014-11-29 00:00:00');
insert into s_users (id,name,sex,bod) values (2,'王家林',0,'2014-11-29 00:00:00');
insert into s_users (id,name,sex,bod) values (3,'李明',0,'2014-11-29 00:00:00');

insert into s_roles (id,name,role) values (1,'系统管理员','admin');
insert into s_roles (id,name,role) values (2,'老师','teacher');
insert into s_roles (id,name,role) values (3,'学生','student');

insert into s_user_role (sysUserId,roleId) values(1,1);
insert into s_user_role (sysUserId,roleId) values(2,2);
insert into s_user_role (sysUserId,roleId) values(3,3);


insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (1,'系统管理','',null,5,0,'fa fa-university',0);
insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (2,'用户管理','/sys/user/list',1,5, 1,'fa fa-users',1);
insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (3,'角色管理','/sys/role/list',1,10,1,'fa fa-user',1);
insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (4,'功能管理','/sys/func/list',1,15,1,'fa fa-sitemap',1);
insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (5,'权限管理','/sys/perm/list',1,20,1,'fa fa-gavel',1);

insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (100,'资源库管理','',null,10,0,'fa fa-tachometer',0);
insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (101,'精品课程','/res/common/classic/list',100,5,1,'fa fa-graduation-cap',1);
insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (102,'教师空间','/res/common/personal/list',100,10,1,'fa fa-th-large',1);
insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (103,'精品素材','/res/common/material/list',100,15,1,'fa fa-asterisk',1);
insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (104,'精品文档','/res/common/docs/list',100,20,1,'fa fa-book',1);
insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (105,'常用图库','/res/common/imgs/list',100,25,1,'fa fa-picture-o',1);

insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (200,'信息发布','',null,15,0,'fa fa-info-circle',0);
insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (201,'信息管理','/info/list',200,10,1,'fa fa-paperclip',1);
insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (202,'公告管理','/res/notice/pageList',200,15,1,'fa fa-bookmark',1);

insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (300,'教师空间','',null,20,0,'fa fa-home',0);
insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (301,'我的资源','/res/space/list',300,5,1,'fa fa-puzzle-piece',1);
insert into s_funcs(id,name,url,parent,seqNo,level,iconCls,leaf) values (302,'我的课程','/res/course/list',300,10,1,'fa fa-file-text',1);

insert into s_role_func(roleId,funcId) values (1,1);
insert into s_role_func(roleId,funcId) values (1,2);
insert into s_role_func(roleId,funcId) values (1,3);
insert into s_role_func(roleId,funcId) values (1,4);
insert into s_role_func(roleId,funcId) values (1,5);
insert into s_role_func(roleId,funcId) values (1,100);
insert into s_role_func(roleId,funcId) values (1,101);
insert into s_role_func(roleId,funcId) values (1,102);
insert into s_role_func(roleId,funcId) values (1,103);
insert into s_role_func(roleId,funcId) values (1,104);
insert into s_role_func(roleId,funcId) values (1,105);
insert into s_role_func(roleId,funcId) values (1,200);
insert into s_role_func(roleId,funcId) values (1,201);

insert into s_role_func(roleId,funcId) values (2,300);
insert into s_role_func(roleId,funcId) values (2,301);
insert into s_role_func(roleId,funcId) values (2,302);




