<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>北京市黄庄职业高中：：动漫与游戏专业</title>
    <link href="${ctx}/asset/css/css.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/asset/css/news.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/asset/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="${ctx}/asset/js/jquery.carouFredSel-6.0.4-packed.js" type="text/javascript"></script>
    <script src="${ctx}/asset/js/topanv.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/topanv.js"></script>
    <script language="JavaScript" type="text/javascript">
        function ChangeDiv(divId, divName, zDivCount, obj) {
            for (i = 0; i < 4; i++) {
                document.getElementById(divName + i).style.display = "none";
//将所有的层都隐藏
            }
            document.getElementById(divName + divId).style.display = "block";


//显示当前层
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
            <li><a href="javascript:void(0)">网站首页</a></li>
            <li><a href="javascript:void(0)">新闻动态</a></li>
            <li><a href="javascript:void(0)" class="nav_show">精品课程</a></li>
            <li><a href="javascript:void(0)">资源库</a></li>
            <li><a href="javascript:void(0)">成果展示</a></li>
            <li><a href="javascript:void(0)">专家团队</a></li>
            <li><a href="javascript:void(0)">师生作品</a></li>
        </ul>
    </div>
</div>
<div class="main_content video_show">
    <div class="position">
        <div class="home"><img src="${ctx}/asset/images/home.png" width="19" height="19"/></div>
        <div class="position_nav"> 您现在的位置 : 首页 / 精品课程 / ${course.name} / ${docName}</div>
    </div>
    <div class="video">
        <div class="video_left">
            <img src="${ctx}/asset/images/video.jpg" width="620" height="394"/></div>
        <div class="video_right">
            <h1 class="course_name"> 《${course.name}》</h1>

            <h1>讲师：${course.teacher}</h1>

            <p>${course.brief}</p>

            <p>观看次数：${viewCount} 次</p>
        </div>
    </div>
    <div class="video_content">
        <h1 class="video_title">课程简介</h1>

        <div>
            ${course.description}
        </div>
    </div>
</div>
<div style="clear:both">
</div>
<div class="fooder1"></div>
<div class="fooder">
    地址：北京市石景山区鲁谷东街29号 邮编：100040<br/>
    电话：010-68638293 传真：010-68638293 京ICP备07012769号 | 京公网安备11010702001098号


</div>
</body>
</html>   