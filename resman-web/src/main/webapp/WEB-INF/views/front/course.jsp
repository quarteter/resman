<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            <li><a href="${ctx}/front/index">网站首页</a></li>
            <li><a href="${ctx}/front/news" >新闻动态</a></li>
            <li><a href="${ctx}/front/course" class="nav_show">精品课程</a></li>
            <li><a href="${ctx}/front/resources/classic" >资源库</a></li>
            <li><a href="${ctx}/front/achievements" >成果展示</a></li>
            <li><a href="${ctx}/front/teachers">专家团队</a></li>
            <li><a href="${ctx}/front/wss?type=skillContest">师生作品</a></li>
        </ul>
    </div>
</div>
<div class="main_content">
    <div class="content_left">


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


        <div class="professional works">
            <h1>精品课程</h1>
            <ul>
                <c:if test="${fn:length(folders) > 0}">
                    <c:forEach items="${folders}" var="folder">
                        <li><a href="${ctx}/front/course/list?parent=${folder.uuid}">${folder.name}</a></li>
                    </c:forEach>
                </c:if>
            </ul>
        </div>


    </div>
    <div class="content_right">
        <div class="position">
            <div class="home"><img src="${ctx}/asset/images/home.png" width="19" height="19"/></div>
            <div class="position_nav"> 您现在的位置 : 首页 / 精品课程 / <c:if test="${parentName!=null}">${parentName} / </c:if>列表
            </div>
        </div>
        <div class="news_list works_con">
            <c:if test="${endIdx > 0}">
                <c:forEach begin="${beginIdx}" end="${endIdx}" varStatus="st">
                    <dl>
                        <dt>
                        <dt><img src="${ctx}${files[st.current].imgPath}" width="200" height="132"/></dt>
                        <dd class="news_first_title">
                            <a href="${ctx}/front/course/play?uid=${files[st.current].uuid}">
                                <c:set value="${files[st.current].name}" var="name"></c:set>
                                <c:set value="${name.indexOf('.')}" var="idx"></c:set>
                                <c:set value="${name.substring(0,idx)}" var="n"></c:set>
                                <<${n}>>
                            </a>
                        </dd>
                        <dd>

                        </dd>

                        </dt>

                    </dl>
                </c:forEach>
            </c:if>
            <div style="clear:both"></div>

        </div>
        <div class="pages">

            <a href="#">共${totalCount}条记录 </a>
            <c:choose>
                <c:when test="${curPage-1 >= 0}">
                    <a href="${ctx}/front/course?page=${curPage-1}">上一页</a>
                </c:when>
                <c:otherwise>
                    <a href="#">上一页</a>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${(curPage+1)%5==0}">
                    <%--<c:set var="curRange" value="${ (curPage+1)/5}"/>--%>
                    <fmt:parseNumber var="curRange" integerOnly="true" value="${ (curPage+1)/5}"></fmt:parseNumber>
                </c:when>
                <c:otherwise>
                    <%--<c:set var="curRange" value="${((curPage+1)/5) +1}"/>--%>
                    <fmt:parseNumber var="curRange" integerOnly="true" value="${((curPage+1)/5) +1}"></fmt:parseNumber>
                </c:otherwise>
            </c:choose>
            <c:set var="start" value="${(curRange-1)*5+1}"></c:set>

            <c:choose>
                <c:when test="${curRange*5 >= totalPage}">
                    <c:set var="end" value="${totalPage}"/>
                </c:when>
                <c:otherwise>
                    <c:set var="end" value="${curRange*5}"/>
                </c:otherwise>
            </c:choose>
            <c:if test="${end > 0}">
                <c:forEach begin="${start}" end="${end}" varStatus="st">
                    <a href="${ctx}/front/course/list?page=${st.current-1}<c:if test="${parent!=null}">&parent=${parent}</c:if>"
                       <c:if test="${st.current-1 == curPage}">class="curr" </c:if> >${st.current}</a>
                </c:forEach>
            </c:if>

            <c:choose>
                <c:when test="${curPage+1 < totalPage}">
                    <a href="${ctx}/front/course/list?page=${curPage+1}">下一页</a>
                </c:when>
                <c:otherwise>
                    <a href="#">下一页</a>
                </c:otherwise>
            </c:choose>

        </div>
        <div style="clear:both"></div>

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

        <script>
            $(function () {
                $('.zzsc1 .content1 ul').width(720 * $('.zzsc1 .content1 li').length + 'px');
                $(".zzsc1 .tab2 li").mouseover(function () {
                    $(this).addClass('tit_show').siblings().removeClass('tit_show');
                    var index = $(this).index();
                    number = index;
                    var distance = -720 * index;
                    $('.zzsc1 .content1 ul').stop().animate({
                        left: distance
                    });
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
            });
        </script>


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