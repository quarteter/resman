<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="func" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>信息列表</title>
    <link href="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.css" rel="stylesheet">
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.js"></script>
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table-zh-CN.min.js"></script>
    <script>
        function deleteNews(id) {
            if (window.confirm("您确定要删除该新闻吗?")) {
                $.post("${ctx}/info/delete", {id: id}, function (data) {
                    if (data.success) {
                        window.location = window.location;
                    } else {
                        alert("删除新闻后台错误!")
                    }
                });
            }
        }
        function publishInfo(){
            window.location.href = "${ctx}/info/add";
        }
        $(document).ready(function () {
            $("#newsTable").bootstrapTable();
        });
    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            信息管理
            <small>信息列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">信息列表</li>
        </ol>
    </section>
    <section class="content">
        <div class="row">
            <div class="col-md-10">

                <button type="button" class="btn btn-primary" onclick="publishInfo()"><span class="fa fa-file-text"> 发布信息</span></button>
                <div class="btn-group">

                    <button type="button" class="btn btn-success"><span class="fa fa-list"> 信息栏目</span></button>
                    <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown"
                            aria-expanded="false">
                        <span class="caret"></span>
                        <span class="sr-only">信息栏目</span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <c:forEach items="${infoType}" var="type">
                            <li><a href="${ctx}/info/list?type=${type.code}">${type.name}</a></li>
                        </c:forEach>
                        <%--<li><a href="${ctx}/info/list?type=news">新闻</a></li>--%>
                        <%--<li><a href="${ctx}/info/list?type=knowledge">知识堂</a></li>--%>
                        <%--<li><a href="${ctx}/info/list?type=skillContest">技能大赛</a></li>--%>
                        <%--<li><a href="${ctx}/info/list?type=teacherGroup">师资队伍</a></li>--%>
                    </ul>
                </div>
            </div>
        </div>

        <div class="row" style="margin-top: 10px">
            <div class="col-md-10" style="min-height: 300px">
                <c:choose>
                    <c:when test="${func:length(news)>0}">
                        <ul class="list-group">
                            <c:forEach items="${news}" var="n">
                                <li class="list-group-item">
                                    <span>【<fmt:formatDate value="${n.crtdate}"
                                                           pattern="yyyy-MM-dd"></fmt:formatDate>】</span>
                                    <a href="" style="font-weight: bold">${n.title}</a>&nbsp;&nbsp;&nbsp; <span><a
                                        onclick="deleteNews(${n.id})">[删除]</a>
                                    <c:if test="${n.publish==false}"><a href="#">[发布]</a></c:if></span>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <p>目前还没有发布的信息!</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>
</aside>

</body>
</html>
