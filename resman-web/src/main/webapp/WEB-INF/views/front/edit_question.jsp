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
    <script src="${ctx}/asset/js/plugins/ueditor/ueditor.config.js"></script>
    <script src="${ctx}/asset/js/plugins/ueditor/ueditor.all.min.js"></script>
    <script src="${ctx}/asset/js/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>


    <script language="JavaScript" type="text/javascript">

        var ue = UE.getEditor('editor11');

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

            $("#questionSubmit").on("click", function () {
                var title = $("#addquestion input[name=title]").val();
                var content = ue.getContent();
                if( isnull(title) )
                {
                    alert("标题不能为空！");
                    return false;
                }
                if( isnull(content) )
                {
                    alert("内容不能为空！");
                    return false;
                }
                return true;
            });

            $("#questionCancel").on("click", function () {
                var title = $("#addquestion input[name=title]").val("");
                var content =  ue.setContent("");
            });

        });

        function isnull(_val) {
            if (_val == null || _val == undefined || _val == "")
                return true;
            return false;
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
            <li><a href="${ctx}/front/news" class="nav_show">新闻动态</a></li>
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
            <div class="position_nav"> 您现在的位置 : 首页 / <a href="${ctx}/front/myquestion"> 我的问答 </a> /问答修改</div>
        </div>
        <div class="news_list">
            <form id="addquestion" action="${ctx}/front/question/update" method="post" >
                <div class="tables">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="thead" width="10%" >标题：</td>
                            <td class="ta"><input type="text" style="width:500;" id="title" name="title" value="${question.title}"></td>
                        </tr>

                        <tr>
                            <td class="thead"  width="10%" >内容:</td>
                            <td class="ta" >
                                <script id="editor11" name="content" id="content" style="height: 350px;width:500px;" type="text/plain">${question.content}</script>
                            </td>
                        </tr>

                        <tr>
                            <td class="thead" colspan="2" align="center">
                                <input type="submit" id="questionSubmit" value="更改">
                                &nbsp; &nbsp;
                                <input type="button" id="questionCancel" value="清除">

                                <input type="hidden"  name="id" id="id" value="${question.id}">
                            </td>
                        </tr>
                    </table>
                </div>


                <div>

                </div>
            </form>
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