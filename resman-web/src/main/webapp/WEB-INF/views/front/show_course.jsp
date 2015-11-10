<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>黄庄职高动漫与游戏专业</title>
    <link href="${ctx}/asset/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/asset/css/css.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/asset/css/news.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/asset/js/plugins/jplayer/skin/blue.monday/css/jplayer.blue.monday.min.css" rel="stylesheet"
          type="text/css"/>

    <script src="${ctx}/asset/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="${ctx}/asset/js/jquery.carouFredSel-6.0.4-packed.js" type="text/javascript"></script>
    <script src="${ctx}/asset/js/topanv.js" type="text/javascript"></script>
    <script src="${ctx}/asset/js/plugins/bspaginator/bootstrap-paginator.min.js"></script>
    <script src="${ctx}/asset/js/plugins/template/jsrender.min.js"></script>
    <script src="${ctx}/asset/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/asset/js/topanv.js"></script>
    <script type="text/javascript" src="${ctx}/asset/js/plugins/validate/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${ctx}/asset/js/plugins/validate/messages_zh.min.js"></script>

    <%--<script type="text/javascript" src="${ctx}/asset/js/jquery-2.1.1.min.js"></script>--%>
    <script type="text/javascript" src="${ctx}/asset/js/plugins/jplayer/jquery.jplayer.min.js"></script>

    <script id="commentTpl" type="text/x-jsrender">
        <dl>
            <dt><img src="${ctx}/asset/images/face.jpg" width="40" height="40"/></dt>
            <dd>{{:crtuser.name}}</dd>
            <dd>{{:content}}</dd>
            <dd class="pinglun_time">时间: {{:crtdate}}</dd>
        </dl>

    </script>
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
        function getCommentAndRender(page, recreatePaginator) {
            $.get("${ctx}/res/comment/get", {resUid: "${doc.uuid}", page: page}, function (data) {
                var tpl = $.templates("#commentTpl"),
                        html = tpl.render(data.content);
                $(".pingluns dl").remove();
                $(html).insertBefore("#paginator");
                if (recreatePaginator) {
                    if(data.totalPage>=1){
                        createPaginator(1, data.totalPages);
                    }
                }
            });
        }
        function createPaginator(curPage, totalPage) {
            var options = {
                bootstrapMajorVersion: 3,
                currentPage: curPage,
                totalPages: totalPage,
                onPageClicked: function (e, originalEvent, type, page) {
                    <%--$.get("${ctx}/res/comment/get",{resUid:"${doc.uuid}",page:(page-1)},function(data){--%>
                    <%--var tpl = $.templates("#commentTpl"),--%>
                    <%--html = tpl.render(data.content);--%>
                    <%--$(".pingluns dl").remove();--%>
                    <%--$(html).insertBefore("#paginator");--%>
                    <%--});--%>
                    getCommentAndRender(page - 1, false);
                }
            }
            if(totalPage>0 && curPage<=totalPage){
                $('#paginator').bootstrapPaginator(options);
            }
        }
        function bindPublishEvent() {
            $("#commentForm").validate({
                rules: {
                    "comment": {
                        required: true,
                        minlength: 5,
                        maxlength: 50
                    }
                }
            });
            $("#commentBtn").on("click", function () {
                if ($("#commentForm").valid()) {
                    var content = $("#comment").val();
                    $.post("${ctx}/res/comment/save", {
                        content: content,
                        resourceid: "${doc.uuid}",
                        type: "1"
                    }, function (data) {
                        if (data.success) {
                            getCommentAndRender(0, true);
                            $("#comment").val("");
                        }
                    });
                }
            });
        }
        function initPlayer() {
            $("#jquery_jplayer_1").jPlayer({
                ready: function () {
                    $(this).jPlayer("setMedia", {
                        m4v: "${videoServer}${doc.storedPath}"
                    });
                },
                swfPath: "${ctx}/asset/js/plugins/jplayer",
//                solutions: "flash, html",
                supplied: "webmv, ogv, m4v,flv",
                size: {
                    width: "640px",
                    height: "360px",
                    cssClass: "jp-video-360p"
                },
                useStateClassSkin: true,
                autoBlur: false,
                smoothPlayBar: true,
                keyEnabled: true,
                remainingDuration: true,
                toggleDuration: true
            });
        }
        $(document).ready(function () {
            $(".selecter li ul").hide();
            createPaginator(1, ${totalPage});
            bindPublishEvent();
            initPlayer();
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
            <li><a href="${ctx}/front/news">新闻动态</a></li>
            <li><a href="${ctx}/front/course/list" class="nav_show">精品课程</a></li>
            <li><a href="${ctx}/front/resources/classic">资源库</a></li>
            <li><a href="${ctx}/front/achievements">成果展示</a></li>
            <li><a href="${ctx}/front/teachers">专家团队</a></li>
            <li><a href="${ctx}/front/wss?type=skillContest">师生作品</a></li>
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
            <div id="jp_container_1" class="jp-video jp-video-360p" role="application" aria-label="media player">
                <div class="jp-type-single">
                    <div id="jquery_jplayer_1" class="jp-jplayer"></div>
                    <div class="jp-gui">
                        <div class="jp-video-play">
                            <button class="jp-video-play-icon" role="button" tabindex="0">play</button>
                        </div>
                        <div class="jp-interface">
                            <div class="jp-progress">
                                <div class="jp-seek-bar">
                                    <div class="jp-play-bar"></div>
                                </div>
                            </div>
                            <div class="jp-current-time" role="timer" aria-label="time">&nbsp;</div>
                            <div class="jp-duration" role="timer" aria-label="duration">&nbsp;</div>
                            <div class="jp-controls-holder">
                                <div class="jp-controls">
                                    <button class="jp-play" role="button" tabindex="0">play</button>
                                    <button class="jp-stop" role="button" tabindex="0">stop</button>
                                </div>
                                <div class="jp-volume-controls">
                                    <button class="jp-mute" role="button" tabindex="0">mute</button>
                                    <button class="jp-volume-max" role="button" tabindex="0">max volume</button>
                                    <div class="jp-volume-bar">
                                        <div class="jp-volume-bar-value"></div>
                                    </div>
                                </div>
                                <div class="jp-toggles">
                                    <button class="jp-repeat" role="button" tabindex="0">repeat</button>
                                    <button class="jp-full-screen" role="button" tabindex="0">full screen</button>
                                </div>
                            </div>
                            <div class="jp-details" style="height: 0">
                                <div class="jp-title" aria-label="title">&nbsp;</div>
                            </div>
                        </div>
                    </div>
                    <div class="jp-no-solution">
                        <span>Update Required</span>
                        To play the media you will need to either update your browser to a recent version or update your
                        <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
                    </div>
                </div>
            </div>
        </div>
        <div class="video_right" style="word-break:break-all">
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
    <div class="video_content">
        <h1 class="video_title">用户评论</h1>
        <shiro:authenticated>
            <%--<h1 class="video_title">用户评论</h1>--%>

            <form id="commentForm">
                <div>
                    <textarea class="pinglun" placeholder="表扬、支持、吐槽、迷惑，想说啥说啥....." id="comment"
                              name="comment"></textarea>
                </div>
                <div class="pinglun_but">
                    <input type="button" id="commentBtn" value="发表评论"/>
                </div>
            </form>
        </shiro:authenticated>

        <div class="pingluns">
            <c:if test="${fn:length(comments) > 0}">
                <c:forEach items="${comments}" var="c">
                    <dl>
                        <dt><img src="${ctx}/asset/images/face.jpg" width="40" height="40"/></dt>
                        <dd>${c.crtuser.name}</dd>
                        <dd>${c.content}</dd>
                        <dd class="pinglun_time"><fmt:formatDate value="${c.crtdate}"
                                                                 pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></dd>
                    </dl>
                </c:forEach>
            </c:if>

            <ul id="paginator" class="pagination"></ul>
        </div>
    </div>
</div>
<div style="clear:both">
</div>
<div class="fooder1"></div>
<jsp:include page="site_footer.jsp"></jsp:include>
</body>
</html>   