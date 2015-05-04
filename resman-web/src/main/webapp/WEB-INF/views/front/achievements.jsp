<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
                document.getElementById(divName + i).style.display = "none";
//将所有的层都隐藏 
            }
            document.getElementById(divName + divId).style.display = "block";


//显示当前层
            var $len = document.getElementById("title").getElementsByTagName("li").length;
            for (j = 0; j < $len; j++) {
                if (j == divId) {
                    document.getElementById("title").getElementsByTagName("li")[j].style.background = "/asset/images/bou_1.png";
                    document.getElementById("title").getElementsByTagName("li")[j].style.color = "#ffffff";
                } else {
                    document.getElementById("title").getElementsByTagName("li")[j].style.background = "/asset/images/bou_1hover.png";
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
    <div class="logo"><img src="/asset/images/logo.jpg" width="222" height="65"/></div>
    <div class="nav">
        <ul>
            <li><a href="${ctx}/front/index">网站首页</a></li>
            <li><a href="${ctx}/front/news" >新闻动态</a></li>
            <li><a href="${ctx}/front/course">精品课程</a></li>
            <li><a href="${ctx}/front/resources/classic" >资源库</a></li>
            <li><a href="${ctx}/front/achievements" class="nav_show">成果展示</a></li>
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

        <div class="students tab">
            <h1>学生专区</h1>
            <ul class="menu">
                <li class="active" style="margin:0;"><a href="javascript:void(0)">知识堂</a></li>
                <li><a href="javascript:void(0)">问答</a></li>
            </ul>
            <div class="con1">

                <ul id="knowledgeUL">
                </ul>


            </div>
            <div class="con2">
                <ul id="quesUL">
                </ul>


            </div>
            <div class="con3">

                <ul id="connUL">
                    <li><a href="#">校财经商贸 "京西杯微课程大智慧——我校组织"微课基 </a></li>
                    <li><a href="#">名师、传承人进课堂，助力黔西南中职 </a></li>
                    <li><a href="#">服装专业召开"馆建设研讨会</a></li>
                    <li><a href="#">我"技能大赛</a></li>
                    <li><a href="#">微课程大智旗袍传习慧——我校组织"微课基础</a></li>
                    <li><a href="#">微课程大智慧——我校组织"微课基 </a></li>
                </ul>


            </div>
            <h2><img src="/asset/images/pic04.jpg" width="214" height="123"/></h2>

        </div>


        <div class="professional">
            <h1>专业简介</h1>

            <p>
                北京市黄庄职业高中位于石景山区鲁谷东街，是一所面向全国招生的国家级重点职业高中。1981年，在北京市黄庄中学的基础上，创办了北京市第一个服装专业职业高中班，1984年成为独立设校的职业高中，正式更名为"北京市黄庄职业高中"。2006年，石景山区为最大限度地发挥区职教资源优势，对职教
                职业高中、古城旅游职业学校进行了资源整合，目前已形成学历教育、社会培训、实训经营等分类设置，学历、非学历并举，产学研有机结合，资源全面统筹，多品牌经营，一体化管理的办学格局。
            </p>

            <h2><a href="#">详细+</a>
            </h2>
        </div>


    </div>
    <div class="content_right">
        <div class="position">
            <div class="home"><img src="/asset/images/home.png" width="19" height="19"/></div>
            <div class="position_nav"> 您现在的位置 : 首页 / 成果展示 / 列表</div>
        </div>
        <div class="news_list">
            <c:if test="${fn:length(infos)>0}">
                <c:forEach items="${infos}" var="n">
                <dl>
                    <dt>
                    <dt><img src="${n.imgPath}" width="200" height="132"/></dt>
                    <dd class="news_first_title"><a href="${ctx}/front/achievements/${n.id}">${n.title}</a></dd>
                    <dd>
                        ${n.shortContent}
                    </dd>
                    <dd class="news_first_more"><a href="${ctx}/front/achievements/${n.id}">查看详细+</a></dd>
                    </dt>

                </dl>
                </c:forEach>
            </c:if>

        </div>
        <div class="pages">
            <a href="#">共${totalCount}条记录 </a>
            <c:choose>
                <c:when test="${curPage-1 >= 0}">
                    <a href="${ctx}/front/achievements?page=${curPage-1}">上一页</a>
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
            <c:forEach begin="${start}" end="${end}" varStatus="st">
                <a href="${ctx}/front/achievements/?page=${st.current-1}" <c:if test="${st.current-1 == curPage}">class="curr" </c:if> >${st.current}</a>
            </c:forEach>

            <c:choose>
                <c:when test="${curPage+1 < totalPage}">
                    <a href="${ctx}/front/achievements?page=${curPage+1}">下一页</a>
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
        <script>
            function createLi(data,url,targetUL){
                $.each(data,function(idx,val){
                    var li ='<li><a href="${c}'+ url+'/'+val.id+'">'+val.title+'</a></li>';
                    $(li).appendTo(targetUL);
                });
            }
            function createStudentAreaData(){
                $.get("${ctx}/front/studentArea",{},function(data){
                    createLi(data['knowledge'],"/front/knowledge","#knowledgeUL");
                    createLi(data['ques'],"/front/ques","#quesUL");
                    createLi(data['conn'],"/front/conn","#connUL");
                });
            }
            $(document).ready(function(){
                createStudentAreaData();
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