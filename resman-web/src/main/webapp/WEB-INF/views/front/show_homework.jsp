<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>黄庄职高动漫与游戏专业</title>

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

            bindHomeWorkSubmitEvent();

        });


        function bindHomeWorkSubmitEvent()
        {
            $("#submithomework").on("click", function () {
                var file = $("#uploadhomework input[name=file]").val();
                var isScore = <c:out value="${isScore}"/>;
                if( isScore )
                {
                    alert("作业已经判分，无法继续提交");
                    return false;
                }
                if( isnull(file) )
                {
                    alert("请先选择需要提交的作业文件");
                    return false;
                }
                return true;
            });

             function isnull(_val) {
                if (_val == null || _val == undefined || _val == "")
                        return true;
                return false;
            }

            function getSelectFileName( filename ) {
                var retName = "";
                if (!isnull(filename)) {
                    var name = filename.split('\\');
                    if (name.length == 1)
                        name = filename.split('/');
                    if (name.length >= 1) {
                        retName = name[name.length - 1];
                    }
                }
                return retName;
            }
        }

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
            <li><a href="${ctx}/front/course/list">精品课程</a></li>
            <li><a href="${ctx}/front/resources/classic" >资源库</a></li>
            <li><a href="${ctx}/front/achievements">成果展示</a></li>
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
            <h2><img src="${ctx}/asset/images/pic04.jpg" width="214" height="123"/></h2>

        </div>
        <jsp:include page="major_des.jsp"></jsp:include>

    </div>
    <div class="content_right">
        <div class="position">
            <div class="home"><img src="${ctx}/asset/images/home.png" width="19" height="19"/></div>
            <div class="position_nav"> 您现在的位置 : 首页 /  <a href="${ctx}/front/homework" >作业上传</a> / 正文</div>
        </div>
        <div class="news_list">
            <h1>${homework.name}</h1>

            <div class="date">发布时间：<fmt:formatDate value="${homework.publishDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
            </div>


                <li>作业名称：${homework.name}</li>



                <li> 起始时间：<fmt:formatDate value="${homework.dateFrom}" pattern="yyyy-MM-dd"></fmt:formatDate></li>



                <li>结束时间：<fmt:formatDate value="${homework.dateTo}" pattern="yyyy-MM-dd"></fmt:formatDate></li>



                <li>作业备注：${homework.notes}</li>



                <c:choose>
                    <c:when test="${isUploadHomework == true}">

                        <li>上传状态：<B>已经上传</B></li>
                        <li>作业分数：<B>${score}</B></li>
                        <li>作业下载：<a target="_blank" href="${ctx}/res/document/download?uuid=${uuid}">${filename}</a></li>
                    </c:when>
                    <c:otherwise>

                            <li>上传状态：<B>没有提交</B></li>

                    </c:otherwise>
                </c:choose>

                <form name="uploadhomework" id="uploadhomework" method="post"  action="${ctx}/res/hw/records/submit" enctype="multipart/form-data">
                    <c:if test="${!isScore }">
                        <li> 选择作业：<input type="file" name = "file" id="file">   </li>
                        <li align="center"><input type="submit" id="submithomework"  value="提交作业">  </li>
                    </c:if>
                    <input type="hidden" name="hwId" id="hwId" value="${homework.id}">
                </form>


            </div>


            <ul class="relevant">
                <c:if test="${pre!=null}">
                    <li><strong>上一篇:</strong>&nbsp;<a href="${ctx}/front/homework/${pre.id}">${pre.name}</a></li>
                </c:if>
                <c:if test="${next!=null}">
                    <li><strong>下一篇:</strong>&nbsp;<a href="${ctx}/front/homework/${next.id}">${next.name}</a></li>
                </c:if>
            </ul>
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
                    var li ='<li><a href="${ctx}'+ url+'/'+val.id+'">'+val.title+'</a></li>';
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
<jsp:include page="site_footer.jsp"></jsp:include>
</body>
</html>   