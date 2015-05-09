<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>北京市黄庄职业高中：：动漫与游戏专业</title>
    <link href="/asset/css/css.css" rel="stylesheet" type="text/css"/>

    <script src="${ctx}/asset/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="${ctx}/asset/js/jquery.carouFredSel-6.0.4-packed.js" type="text/javascript"></script>
    <script src="${ctx}/asset/js/topanv.js" type="text/javascript"></script>
    <script src="${ctx}/asset/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/messages_zh.min.js"></script>
    <script language="JavaScript" type="text/javascript">
        function ChangeDiv(divId, divName, zDivCount, obj) {
            for (i = 0; i < 4; i++) {
                document.getElementById(divName + i).style.display = "none";//将所有的层都隐藏
            }
            document.getElementById(divName + divId).style.display = "block";//显示当前层
            var $len = document.getElementById("title").getElementsByTagName("li").length;
            for (j = 0; j < $len; j++) {
                if (j == divId) {
                    document.getElementById("title").getElementsByTagName("li")[j].style.background = "images/bou_1.png";
                    document.getElementById("title").getElementsByTagName("li")[j].style.color = "#ffffff";
                } else {
                    document.getElementById("title").getElementsByTagName("li")[j].style.background = "images/bou_1hover.png";
                    document.getElementById("title").getElementsByTagName("li")[j].style.color = "#ffffff";
                }
            }
        }
        $(document).ready(function () {
            $(".selecter li ul").hide();
        })


    </script>

    <script language="javascript">
        function switchmodTag(modtag, modcontent, modk) {
            for (i = 1; i < 4; i++) {
                if (i == modk) {
                    document.getElementById(modtag + i).className = "title_show";
                    document.getElementById(modcontent + i).className = "slidingList";
                }
                else {
                    document.getElementById(modtag + i).className = "menuNo";
                    document.getElementById(modcontent + i).className = "slidingList_none";
                }
            }
        }
    </script>
</head>

<body>
<div class="top">
</div>

<div class="header">
    <div class="logo"><img src="${ctx}/asset/images/logo.jpg" width="222" height="65"/></div>
    <div class="nav">
        <ul>
            <li><a href="${ctx}/front/index" class="nav_show">网站首页</a></li>
            <li><a href="${ctx}/front/news">新闻动态</a></li>
            <li><a href="${ctx}/front/course/list">精品课程</a></li>
            <li><a href="${ctx}/front/resources/classic">资源库</a></li>
            <li><a href="${ctx}/front/achievements">成果展示</a></li>
            <li><a href="${ctx}/front/teachers">专家团队</a></li>
            <li><a href="${ctx}/front/wss?type=skillContest">师生作品</a></li>
        </ul>
    </div>
</div>
<div class="main_content">
    <div class="content_left">
        <div class="notice">
            <h1><span><a href="${ctx}/front/news?type=notice">更多>></a></span>通知公告</h1>
            <ul>
                <c:forEach items="${notices_list}" var="n">
                   <li><a href="${ctx}/front/news/${n.id}?type=notice">${n.title} </a></li>
                </c:forEach>
            </ul>
        </div>
        <div class="login">
            <h1><a href="#"><img src="${ctx}/asset/images/login_01.jpg" width="240" height="137"/></a></h1>
            <ul>
                <!--个人中心登录前-->
                <shiro:notAuthenticated>
                    <form name="LoginForm" id="LoginForm" action="${ctx}/login" method="post">
                        <li class="user">
                            用户名 <input id="username" name="username" type="text"/>
                        </li>
                        <li class="psw">
                            密&nbsp;&nbsp;&nbsp; 码 <input name="password" id="password" type="password"/>
                        </li>
                        <li class="sub">
                            <input type="submit" id="btnLogin" value="登 录"/>
                        </li>
                    </form>
                </shiro:notAuthenticated>

                <!--个人中心登录后-->
                <shiro:authenticated>
                    <shiro:hasRole name="student">
                        <div class="login_message"><a href="#" class="a1">欢迎您 <span> wangsanir </span>(学生) 登录</a></div>

                        <li><a href="#" class="a5">作业管理</a></li>
                        <li><a href="#" class="a4">我的问答</a></li>

                        <li><a href="${ctx}/logout" class="a6">退出登录</a></li>
                    </shiro:hasRole>
                    
                    <shiro:hasAnyRoles name="admin,teacher">
                        <div class="login_message"><a href="#" class="a1">欢迎您 <span name="logintip">  </span>登录</a></div>
                        <li><a href="${ctx}/main" class="a5" target="_blank">后台管理</a></li>
                        <li><a href="${ctx}/logout" class="a6" name="btnLogOut">退出登录</a></li>
                    </shiro:hasAnyRoles>
                </shiro:authenticated>

            </ul>
        </div>
        <script type="text/javascript">
            $(function () {
                $('.tab ul.menu li').click(function () {
                    //获得当前被点击的元素索引值
                    var Index = $(this).index();
                    //给菜单添加选择样式
                    $(this).addClass('active').siblings().removeClass('active');
                    //显示对应的div
                    $('.tab').children('div').eq(Index).show().siblings('div').hide();
                });
            });
        </script>

        <div class="students tab">
            <h1>学生专区</h1>
            <ul class="menu">
                <li class="active" style="margin:0;"><a href="${ctx}/front/news?type=knowledge">知识堂</a></li>
                <li><a href="javascript:void(0)">问答</a></li>
                <!--		<li><a href="javascript:void(0)">交流</a></li> -->
            </ul>
            <div class="con1">
                <!--知识堂-->
                <ul>
                    <c:forEach items="${knowledge_list}" var="n">
                        <li><a href="news/${n.id}">${n.title}</a></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="con2">
                <ul>
                    <c:forEach items="${question_list}" var="n">
                        <li><a href="news/${n.id}">${n.title}</a></li>
                    </c:forEach>
                </ul>
            </div>

            <!--
            <div class="con3">

              <ul>
           <li><a href="#">校财经商贸 "京西杯微课程大智慧——我校组织"微课基 </a></li>
           <li><a href="#">名师、传承人进课堂，助力黔西南中职 </a></li>
           <li><a href="#">服装专业召开"馆建设研讨会</a></li>
           <li><a href="#">我"技能大赛</a></li>
           <li><a href="#">微课程大智旗袍传习慧——我校组织"微课基础</a></li>
           <li><a href="#">微课程大智慧——我校组织"微课基 </a></li>
            </ul>


          </div>
          -->

            <h2><img src="/asset/images/pic04.jpg" width="214" height="123"/></h2>

        </div>
        <div class="link">

            <div id="anvlfteb">
                <div selec="bbs" class="posbox"><a href="#">友情链接</a></div>

                <div id="seledbox" class="posiabox" style=" display:none;  ">
                    <div>
                    </div>
                </div>

            </div>

        </div>
        <div class="contact"><a href="#">联系方式</a></div>
        <jsp:include page="major_des.jsp"></jsp:include>

    </div>
    <div class="content_right">

        <div class="banner">
            <div id="focus">
                <ul>
                    <c:forEach items="${bannerinfo_list}" var="n">
                        <li><a href="news/${n.id}?type=${n.type}"><img src="${n.imgPath}"/></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <div class="new_data">
            <div class="new ">
                <h3>
                    <ul id="tit">
                        <li class="title_show" id="mod1"
                            onmouseover="$('#listmoretag').attr('href','${ctx}/front/news'); switchmodTag('mod','slidingList','1');this.blur();">
                            新闻动态
                        </li>
                        <li id="mod2"
                            onmouseover="$('#listmoretag').attr('href','${ctx}/front/achievements'); switchmodTag('mod','slidingList','2');this.blur();">
                            成果展示
                        </li>
                        <li class="float" style="background:none;"><span><a id="listmoretag" href="${ctx}/front/news">更多>></a></span>
                        </li>
                    </ul>
                </h3>
                <!--新闻列表-->
                <ul id="slidingList1">
                    <c:if test="${fn:length(news_list)>0}">
                        <h1><a href="${ctx}/front/news/${news_list[0].id} ">${news_list[0].title}</a></h1>
                    </c:if>
                    <c:if test="${fn:length(news_list)>1}">
                        <c:forEach items="${news_list}" var="n" begin="1">
                            <li><span>[<fmt:formatDate value="${n.crtdate}" pattern="yyyy-MM-dd"/>  ]</span> <a
                                    href="${ctx}/front/news/${n.id}">${n.title}</a></li>
                        </c:forEach>
                    </c:if>
                </ul>
                <!--研究成果-->
                <ul class="slidingList_none" id="slidingList2">
                    <c:if test="${fn:length(achievement_list)>0}">
                        <h1>
                            <a href="${ctx}/front/achievements/${achievement_list[0].id} ">${achievement_list[0].title}</a>
                        </h1>
                    </c:if>
                    <c:if test="${fn:length(achievement_list)>1}">
                        <c:forEach items="${achievement_list}" var="n" begin="1">
                            <li><span>[<fmt:formatDate value="${n.crtdate}" pattern="yyyy-MM-dd"/>  ]</span> <a
                                    href="${ctx}/front/achievements/${n.id}">${n.title}</a></li>
                        </c:forEach>
                    </c:if>

                </ul>


            </div>
            <div class="data">
                <h1>资料库</h1>

                <div class="search">
                    <input id="resourcesearchvalue" type="text" class="infor_text" value="站内搜索"
                           onblur="if (value ==''){value='站内搜索'}" onclick="if(this.value=='站内搜索')this.value=''"/><input
                        name="resourcesearch" id="resourcesearch" type="button" value=" " class="infor_button"/>
                </div>
                <ul>
                    <li>
                        资源类型：
                    </li>
                    <select id="resourcetype" style="width: 140px;">
                        <option value="resources/classic">精品课程</option>
                        <option value="resources/material">精品素材</option>
                        <option value="resources/docs">精品文档</option>
                        <option value="resources/imgs">经常图库</option>
                    </select>

                    <!--
                    <li><a href="#">精品课资源</a></li>
                 <li><a href="#">图库资源</a></li>
                 <li><a href="#">课件资源</a></li>
                 <li><a href="#">素材资源</a></li>
                 <li><a href="#">文档资源</a></li>
                 <li><a href="#">其他资源</a></li>
                 -->
                </ul>
                <div style="clear:both"></div>
                <dl>

                    <c:if test="${fn:length(strategy_list)>0}">
                        <c:forEach items="${strategy_list}" var="n">
                            <dt>【攻略】</dt>
                            <dd><a href="${ctx}/front/news/${n.id}?type=strategy">${n.title}</a></dd>
                        </c:forEach>
                    </c:if>


                </dl>
                <h2><img src="/asset/images/pic03.jpg" width="218" height="90"/></h2>
            </div>


        </div>
        <div style="clear:both"></div>
        <div class="boutique  zzsc">
            <h1>
                <ul id="tit" class="tab1">
                    <li class="on" style="margin-left:25px;">精品课程</li>
                    <li> 精品素材</li>
                    <li> 精品文档</li>
                    <li> 经常图库</li>
                </ul>
                <div style="clear:both"></div>
            </h1>
            <div class="content">
                <ul>
                    <li style="display:block;">
                        <div class="slid">
                            <div class="bout_left">
                                <h2><img src="/asset/images/pic01.jpg" width="280" height="139"/></h2>

                                <h3><a href="#">资料</a><a href="#">资讯</a><a href="#">攻略</a><a href="#">视频</a><a href="#">动漫</a><a
                                        href="#">萌妹</a><a href="#">囧图</a></h3>

                                <div style="clear:both"></div>
                                <dl>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                </dl>

                            </div>
                            <div class="bout_right">
                                <dl>
                                    <dt><a href="#" class="avatar"><img src="/asset/images/pic02.jpg" width="165"
                                                                        height="105"/></a></dt>
                                    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>

                                </dl>
                                <dl>
                                    <dt><a href="#" class="avatar"><img src="/asset/images/pic02.jpg" width="165"
                                                                        height="105"/></a></dt>
                                    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>

                                </dl>
                                <dl>
                                    <dt><a href="#" class="avatar"><img src="/asset/images/pic02.jpg" width="165"
                                                                        height="105"/></a></dt>
                                    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>

                                </dl>
                                <dl>
                                    <dt><a href="#" class="avatar"><img src="/asset/images/pic02.jpg" width="165"
                                                                        height="105"/></a></dt>
                                    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>

                                </dl>


                            </div>
                        </div>
                    </li>
                    <li class="bout_none">
                        <div class="slid">
                            <div class="bout_left">
                                <h2><img src="/asset/images/pic01.jpg" width="280" height="139"/></h2>

                                <h3><a href="#">资料</a><a href="#">资讯</a><a href="#">攻略</a><a href="#">视频</a><a href="#">动漫</a><a
                                        href="#">萌妹</a><a href="#">囧图</a></h3>

                                <div style="clear:both"></div>
                                <dl>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                </dl>

                            </div>
                            <div class="bout_right">
                                <dl>
                                    <dt><a href="#" class="avatar"><img src="/asset/images/pic1.jpg" width="165"
                                                                        height="105"/></a></dt>
                                    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>

                                </dl>
                                <dl>
                                    <dt><a href="#" class="avatar"><img src="/asset/images/pic1.jpg" width="165"
                                                                        height="105"/></a></dt>
                                    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>

                                </dl>
                                <dl>
                                    <dt><a href="#" class="avatar"><img src="/asset/images/pic1.jpg" width="165"
                                                                        height="105"/></a></dt>
                                    <dd><a href="#">【热门】 </a></dd>

                                </dl>
                                <dl>
                                    <dt><a href="#" class="avatar"><img src="/asset/images/pic1.jpg" width="165"
                                                                        height="105"/></a></dt>
                                    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>

                                </dl>


                            </div>
                        </div>
                    </li>
                    <li class="bout_none">
                        <div class="slid">
                            <div class="bout_left">
                                <h2><img src="/asset/images/pic01.jpg" width="280" height="139"/></h2>

                                <h3><a href="#">资料</a><a href="#">资讯</a><a href="#">攻略</a><a href="#">视频</a><a href="#">动漫</a><a
                                        href="#">萌妹</a><a href="#">囧图</a></h3>

                                <div style="clear:both"></div>
                                <dl>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                </dl>

                            </div>
                            <div class="bout_right"></div>
                        </div>
                    </li>
                    <li class="bout_none">
                        <div class="slid">
                            <div class="bout_left">
                                <h2><img src="/asset/images/pic01.jpg" width="280" height="139"/></h2>

                                <h3><a href="#">资料</a><a href="#">资讯</a><a href="#">攻略</a><a href="#">视频</a><a href="#">动漫</a><a
                                        href="#">萌妹</a><a href="#">囧图</a></h3>

                                <div style="clear:both"></div>
                                <dl>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                    <dd><a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
                                </dl>

                            </div>
                            <div class="bout_right">
                                <dl>
                                    <dt><a href="#" class="avatar"><img src="/asset/images/pic3.jpg" width="165"
                                                                        height="105"/></a></dt>
                                    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>

                                </dl>
                                <dl>
                                    <dt><a href="#" class="avatar"><img src="/asset/images/pic3.jpg" width="165"
                                                                        height="105"/></a></dt>
                                    <dd><a href="#">【 刃加点推荐</a></dd>

                                </dl>
                                <dl>
                                    <dt><a href="#" class="avatar"><img src="/asset/images/pic3.jpg" width="165"
                                                                        height="105"/></a></dt>
                                    <dd><a href="#">【 民拳刃加点推荐</a></dd>

                                </dl>
                                <dl>
                                    <dt><a href="#" class="avatar"><img src="/asset/images/pic3.jpg" width="165"
                                                                        height="105"/></a></dt>
                                    <dd><a href="#">【热门 刃加点推荐</a></dd>

                                </dl>


                            </div>
                        </div>
                    </li>

                </ul>
            </div>

        </div>

        <script>
            $(function () {
                $(".zzsc .tab1 li").mouseover(function () {
                    $(this).addClass('on').siblings().removeClass('on');
                    var index = $(this).index();
                    number = index;
                    $('.zzsc .content li').hide();
                    $('.zzsc .content li:eq(' + index + ')').show();
                });

                var auto = 1;  //等于1则自动切换，其他任意数字则不自动切换
                if (auto == 1) {
                    var number = 0;
                    var maxNumber = $('.zzsc .tab1 li').length;

                    function autotab() {
                        number++;
                        number == maxNumber ? number = 0 : number;
                        $('.zzsc .tab1 li:eq(' + number + ')').addClass('on').siblings().removeClass('on');
                        $('.zzsc .content ul li:eq(' + number + ')').show().siblings().hide();
                    }

                    //鼠标悬停暂停切换


                }
            });
        </script>
        <div class="skills  zzsc1">
            <h1>
                <ul id="tit" class="tab2">
                    <li class="tit_show" style="margin-left:25px;">技能大赛</li>
                    <li>师生作品</li>
                    <li>师资团队</li>
                    <span class="float" style="background:none;"><a id="skill_more_link" href="./news">更多>></a></span>

                </ul>
                <div style="clear:both"></div>
            </h1>
            <div class="content1">
                <ul>
                    <li><p>

                        <div class="slid">
                            <div class="bout_left">
                                <h2><a href="wss/${skill_banner.id}?type=skillContest" alt="${skill_banner.title}"><img
                                        src="${skill_banner.imgPath}" width="280" height="139"/></a></h2>

                                <div style="clear:both"></div>
                                <dl>
                                    <!--skill-->
                                    <c:forEach items="${sikll_list}" var="n">
                                        <dd><a href="wss/${n.id}?type=skillContest">${n.title}</a></dd>
                                    </c:forEach>
                                </dl>

                            </div>
                            <div class="bout_right">
                                <!--skill-->
                                <c:if test="${fn:length(sikll_hot)>0}">
                                    <c:forEach items="${sikll_hot}" var="n">
                                        <dl>
                                            <dt><a href="wss/${n.id}?type=skillContest" class="avatar"><img
                                                    src="${n.imgPath}" width="165" height="105" alt="${n.title}"/></a>
                                            </dt>
                                            <dd><a href="wss/${n.id}?type=skillContest">【热门】${n.title}</a></dd>
                                        </dl>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                        </p>
                    </li>
                    <li><p>

                        <div class="slid">
                            <div class="bout_left">
                                <h2><a href="${ctx}/front/wss/${stworks_banner.id}?type=${stworks_banner.type}"
                                       alt="${stworks_banner.title}"> <img src="${stworks_banner.imgPath}" width="280"
                                                                           height="139"/></a></h2>
                                <dl>
                                    <!--stworks_list-->
                                    <c:if test="${fn:length(stworks_list)>0}">
                                        <c:forEach items="${stworks_list}" var="n">
                                            <c:choose>
                                                <c:when test="${n.type=='sworks'}">
                                                    <dd><a href="${ctx}/front/wss/${n.id}?type=sworks">${n.title}</a>
                                                    </dd>
                                                </c:when>
                                                <c:otherwise>
                                                    <dd><a href="${ctx}/front/wss/${n.id}?type=tworks">${n.title}</a>
                                                    </dd>
                                                </c:otherwise>
                                            </c:choose>


                                        </c:forEach>
                                    </c:if>
                                </dl>

                            </div>
                            <div class="bout_right">

                                <c:if test="${fn:length(stworks_hot)>0}">
                                    <c:forEach items="${stworks_hot}" var="n">
                                        <dl>

                                            <c:choose>
                                                <c:when test="${n.type=='sworks'}">
                                                    <dt><a href="${ctx}/front/wss/${n.id}?type=sworks"
                                                           class="avatar"><img src="${n.imgPath}" width="165"
                                                                               height="105" alt="${n.title}"/></a></dt>
                                                    <dd>
                                                        <a href="${ctx}/front/wss/${n.id}?type=sworks">【热门】${n.title}</a>
                                                    </dd>
                                                </c:when>
                                                <c:otherwise>
                                                    <dt><a href="${ctx}/front/wss/${n.id}?type=tworks"
                                                           class="avatar"><img src="${n.imgPath}" width="165"
                                                                               height="105" alt="${n.title}"/></a></dt>
                                                    <dd>
                                                        <a href="${ctx}/front/wss/${n.id}?type=tworks">【热门】${n.title}</a>
                                                    </dd>
                                                </c:otherwise>
                                            </c:choose>
                                        </dl>
                                    </c:forEach>
                                </c:if>


                            </div>
                        </div>
                        </p>
                    </li>
                    <li><p>

                        <div class="slid">
                            <div class="bout_left">
                                <h2><a href="${ctx}/front/teachers/${teachergroup_banner.id}"
                                       alt="${teachergroup_banner.title}"><img src="${teachergroup_banner.imgPath}"
                                                                               width="280" height="139"
                                                                               alt="${skill_banner.title}"/></a></h2>
                                <dl>
                                    <dl>
                                        <!--teachergroup_list-->
                                        <c:if test="${fn:length(teachergroup_list)>0}">
                                            <c:forEach items="${teachergroup_list}" var="n">
                                                <dd><a href="${ctx}/front/teachers/${n.id}">${n.title}</a></dd>
                                            </c:forEach>
                                        </c:if>
                                    </dl>
                                </dl>

                            </div>
                            <div class="bout_right">
                                <!--teachergroup_hotlist-->
                                <c:if test="${fn:length(teachergroup_hot)>0}">
                                    <c:forEach items="${teachergroup_hot}" var="n">
                                        <dl>
                                            <dt><a href="${ctx}/front/teachers/${n.id}" class="avatar"><img
                                                    src="${n.imgPath}" width="165" height="105"/></a></dt>
                                            <dd><a href="${ctx}/front/teachers/${n.id}">【热门】${n.title}</a></dd>
                                        </dl>
                                    </c:forEach>
                                </c:if>


                            </div>
                        </div>
                        </p>
                    </li>

                </ul>
            </div>

        </div>
        <script>
            $(function () {
                /**
                 x chage more link url
                 */
                function changeMoreLink(idx) {
                    var surl = '${ctx}/front/wss?type=skillContest';
                    if (idx == 0) surl = '${ctx}/front/wss?type=skillContest';
                    else if (idx == 1) surl = '${ctx}/front/wss?type=sworks';
                    else  surl = '${ctx}/front/news?type=teacherGroup';
                    $('#skill_more_link').attr('href', surl);
                }

                $('.zzsc1 .content1 ul').width(720 * $('.zzsc1 .content1 li').length + 'px');
                $(".zzsc1 .tab2 li").mouseover(function () {
                    $(this).addClass('tit_show').siblings().removeClass('tit_show');
                    var index = $(this).index();
                    number = index;
                    var distance = -720 * index;
                    $('.zzsc1 .content1 ul').stop().animate({
                        left: distance
                    });
                    changeMoreLink(index);
                });

                var auto = 1;  //等于1则自动切换，其他任意数字则不自动切换
                if (auto == 1) {
                    var number = 0;
                    var maxNumber = $('.zzsc1 .tab2 li').length;

                    function autotab() {
                        number++;
                        number == maxNumber ? number = 0 : number;
                        $('.zzsc1 .tab2 li:eq(' + number + ')').addClass('tit_show').siblings().removeClass('tit_show');
                        var distance = -720 * number;
                        $('.zzsc1 .content1 ul').stop().animate({
                            left: distance
                        });

                        changeMoreLink(index);
                    }

                    var tabChange = setInterval(autotab, 3000);
                    //鼠标悬停暂停切换
                    $('.zzsc1').mouseover(function () {
                        clearInterval(tabChange);
                    });
                    $('.zzsc1').mouseout(function () {
                        tabChange = setInterval(autotab, 3000);
                    });
                }


                topBanner();
            });

            function topBanner() {
                var sWidth = $("#focus").width(); //获取焦点图的宽度（显示面积）
                var len = $("#focus ul li").length; //获取焦点图个数
                var index = 0;
                var picTimer;

                //以下代码添加数字按钮和按钮后的半透明条，还有上一页、下一页两个按钮
                var btn = "<div class='btnBg'></div><div class='btn'>";
                for (var i = 0; i < len; i++) {
                    btn += "<span></span>";
                }
                btn += "</div><div class='preNext pre'></div><div class='preNext next'></div>";
                $("#focus").append(btn);
                $("#focus .btnBg").css("opacity", 0.5);

                //为小按钮添加鼠标滑入事件，以显示相应的内容
                $("#focus .btn span").css("opacity", 0.4).mouseenter(function () {
                    index = $("#focus .btn span").index(this);
                    showPics(index);
                }).eq(0).trigger("mouseenter");

                //上一页、下一页按钮透明度处理
                $("#focus .preNext").css("opacity", 0.2).hover(function () {
                    $(this).stop(true, false).animate({"opacity": "0.5"}, 300);
                }, function () {
                    $(this).stop(true, false).animate({"opacity": "0.2"}, 300);
                });

                //上一页按钮
                $("#focus .pre").click(function () {
                    index -= 1;
                    if (index == -1) {
                        index = len - 1;
                    }
                    showPics(index);
                });

                //下一页按钮
                $("#focus .next").click(function () {
                    index += 1;
                    if (index == len) {
                        index = 0;
                    }
                    showPics(index);
                });

                //本例为左右滚动，即所有li元素都是在同一排向左浮动，所以这里需要计算出外围ul元素的宽度
                $("#focus ul").css("width", sWidth * (len));

                //鼠标滑上焦点图时停止自动播放，滑出时开始自动播放
                $("#focus").hover(function () {
                    clearInterval(picTimer);
                }, function () {
                    picTimer = setInterval(function () {
                        showPics(index);
                        index++;
                        if (index == len) {
                            index = 0;
                        }
                    }, 4000); //此4000代表自动播放的间隔，单位：毫秒
                }).trigger("mouseleave");

                //显示图片函数，根据接收的index值显示相应的内容
                function showPics(index) { //普通切换
                    var nowLeft = -index * sWidth; //根据index值计算ul元素的left值
                    $("#focus ul").stop(true, false).animate({"left": nowLeft}, 300); //通过animate()调整ul元素滚动到计算出的position
                    //$("#focus .btn span").removeClass("on").eq(index).addClass("on"); //为当前的按钮切换到选中的效果
                    $("#focus .btn span").stop(true, false).animate({"opacity": "0.4"}, 300).eq(index).stop(true, false).animate({"opacity": "1"}, 300); //为当前的按钮切换到选中的效果
                }
            }


            //sync post
            function syncPost(url, data, onSuccess) {
                $.ajax({
                    type: "post",
                    url: url,
                    data: data,
                    async: false,
                    success: function (data) {
                        // data = eval("(" + data + ")");
                        if (onSuccess != null && onSuccess != undefined) {
                            onSuccess(data);
                        }
                    }
                });
            }

            function checkLoginValid() {
                var user = $("#user").val();
                var pass = $("#pass").val();
                if (user == null || user == "") {
                    alert("用户名不能为空！");
                    return false;
                }

                if (pass == null || pass == "") {
                    alert("密码不能为空！");
                    return false;
                }
                return true;
            }
            /**
             *登录动作
             */
            function LoginIn() {
                var user = $("#user").val();
                var pass = $("#pass").val();
                syncPost("${ctx}/login", {username: user, password: pass});

            }

            function checkLoginStatus(bLogAction) {
                var userInfo = null;
                syncPost("${ctx}/front/getUserInfo", null,
                        function (data) {
                            userInfo = data;
                        }
                );
                showLoginPage(userInfo);
                //未登录或者登录失败,并且点击登录按钮
                if ((userInfo == null || userInfo == "" ) && bLogAction == true) {
                    alert('登陆失败,用户名或密码不正确!');

                }
            }

            /**
             * 签出
             */
            function LoginOut() {
                syncPost("${ctx}/logout");
                loginLayer_init();
            }

            function loginLayer_init() {
                $("#loginlayer").show();
                $("#studentlayer").hide();
                $("#teacherlayer").hide();
            }

            function loginLayer_student() {
                $("#loginlayer").hide();
                $("#studentlayer").show();
                $("#teacherlayer").hide();
            }

            function loginLayer_teacher() {
                $("#loginlayer").hide();
                $("#studentlayer").hide();
                $("#teacherlayer").show();
            }

            function loginLayer_showlogintip(userInfo) {
                $("span[name=logintip]").text(userInfo.userName + " (" + userInfo.roleName + ") ");
            }

            /*
             *主页左侧登录页面切换
             * */
            function showLoginPage(userInfo) {
                //未登录，显示登录框
                loginLayer_init();


                //管理员或者老师
                if (userInfo.roleId == 4) {
                    loginLayer_teacher();
                    loginLayer_showlogintip(userInfo);
                }
                //学生
                else if (userInfo.roleId == 6) {
                    loginLayer_student();
                    loginLayer_showlogintip(userInfo);
                }
            }

            function bindLoginAction() {
                $("#btnLogin").on("click", function () {
                    //if ($("#LoginForm").valid())
                    if (checkLoginValid()) {
                        LoginIn();
                        checkLoginStatus(true);
                    }
                    return false;
                });
            }

            function bindLogoutAction() {
                $("a[name=btnLogOut]").on("click", function () {
                    LoginOut();
                });
            }

            function addValidator() {
                $("#LoginForm").validate({
                    rules: {
                        "user": {
                            required: true,
                            minlength: 4,
                            maxlength: 40
                        },
                        "pass": {
                            required: true,
                            minlength: 4,
                            maxlength: 40
                        }
                    }
                });
            }
            function bindResourceSearchAction() {
                $("#resourcesearch").on("click", function () {
                    var sval = $("#resourcesearchvalue").val();

                    if (sval == "" || sval == "站内搜索" || sval == null) {
                        alert("请输入搜索内容！");
                        return;
                    }
                    var url = $("#resourcetype").val() + "?search=" + sval;
                    window.open(url, '资源管理');

                });
            }


            //      $(document).ready(function(){
            //        loginLayer_init();
            //        // addValidator();
            //        LoginIn();
            //        checkLoginStatus(false);
            //        bindLoginAction();
            //        bindLogoutAction();
            //
            //        bindResourceSearchAction();
            //      });


        </script>


    </div>
</div>
<div style="clear:both">
</div>
<div class="fooder1"></div>
<jsp:include page="site_footer.jsp"></jsp:include>
</body>
</html>   