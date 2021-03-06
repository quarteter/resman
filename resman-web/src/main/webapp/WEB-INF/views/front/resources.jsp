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
    <script type="text/javascript" src="${ctx}/asset/js/topanv.js"></script>
    <script src="${ctx}/asset/js/plugins/bsdialog/bootstrap-dialog.js"></script>
    <script src="${ctx}/asset/js/plugins/template/jsrender.min.js"></script>
    <script type="text/javascript" src="${ctx}/asset/js/plugins/lhgDialog/lhgdialog.min.js"></script>
    <script>
        $(function () {
            $("#tit li").click(function () {
                window.location.href = "${ctx}/front/resources/" + $(this).attr('id');
            });

            $("#${func}").attr('class', 'on');

            $("#search_resource").focus(function () {
                $(this).val('');
            });
        });

        function viewFile(uuid, name) {
            $.dialog({
                title: name,
                content: 'url:${ctx}/res/document/view?uuid=' + uuid,
                padding: 0
            });
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
            <li><a href="${ctx}/front/course/list">精品课程</a></li>
            <li><a href="${ctx}/front/resources/classic" class="nav_show">资源库</a></li>
            <li><a href="${ctx}/front/achievements">成果展示</a></li>
            <li><a href="${ctx}/front/teachers">专家团队</a></li>
            <li><a href="${ctx}/front/wss?type=skillContest">师生作品</a></li>
        </ul>
    </div>
</div>
<div class="main_content resources">
    <div class="position">
        <div class="home"><img src="${ctx}/asset/images/home.png" width="19" height="19"/></div>
        <div class="position_nav"> 您现在的位置 : 首页 / <a href="${ctx}/front/resources/${func}">${funcName}</a> / ${path}
        </div>
    </div>
    <div class="resources_search">
        <div class="resources_search_left">
            <form action="${ctx}/front/resources/${func}">
                资源检索 <input id="search_resource" name="search" type="text" class="search_text" value="${search}"/><input
                    type="submit" value="搜索"
                    class="search_button"/>
            </form>
        </div>

    </div>
    <div class="resources_content">
        <div class="boutique">
            <h1>
                <ul id="tit" class="tab1">
                    <li id="classic" style="margin-left:25px;">精品课程</li>
                    <li id="material">精品素材</li>
                    <li id="docs">精品文档</li>
                    <li id="imgs">精品图库</li>
                </ul>
                <div style="clear:both"></div>
            </h1>
            <div class="tables">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="thead">资源名称</td>
                        <td class="thead">发布者</td>
                        <td class="thead">发布时间</td>
                        <td class="thead">资源类型</td>
                        <td class="thead">下载次数</td>
                        <td class="thead">操作</td>
                    </tr>
                    <c:forEach var="res" items="${resList}">
                        <tr>
                            <td class="ta">
                                <c:choose>
                                    <c:when test="${res.type=='目录'}">
                                        <a href="${ctx}/front/resources/${func}?path=${res.realPath}">${res.name}</a>
                                    </c:when>
                                    <c:otherwise>
                                        ${res.name}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="ta">${res.author}</td>
                            <td class="ta">${res.modifyDate}</td>
                            <td class="ta">${res.type}</td>
                            <td class="ta">${res.downCount}</td>
                            <c:choose>
                                <c:when test="${res.type=='目录'}">
                                    <td class="ta">-</td>
                                </c:when>
                                <c:otherwise>
                                    <td class="ta"><a href="javascript:void(0)"
                                                      onclick="viewFile('${res.uuid}','${res.name}')">预览</a> <a
                                            href="${ctx}/res/document/download?uuid=${res.uuid}">下载</a></td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="pages">
                <a href="#">共${total}条记录 </a>
                <c:choose>
                    <c:when test="${curPage-1 >= 0}">
                        <a href="${ctx}/front/resources/${func}?path=${path}&page=${curPage-1}">上一页</a>
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
                        <fmt:parseNumber var="curRange" integerOnly="true"
                                         value="${((curPage+1)/5) +1}"></fmt:parseNumber>
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
                    <a href="${ctx}/front/resources/${func}/?path=${path}&page=${st.current-1}"
                       <c:if test="${st.current-1 == curPage}">class="curr" </c:if> >${st.current}</a>
                </c:forEach>

                <c:choose>
                    <c:when test="${curPage+1 < totalPage}">
                        <a href="${ctx}/front/resources/${func}?path=${path}&page=${curPage+1}">下一页</a>
                    </c:when>
                    <c:otherwise>
                        <a href="#">下一页</a>
                    </c:otherwise>
                </c:choose>

            </div>


        </div>


    </div>


</div>
<div style="clear:both">
</div>
<div class="fooder1"></div>
<jsp:include page="site_footer.jsp"></jsp:include>
</body>
</html>   