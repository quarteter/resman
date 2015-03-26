<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="func" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>新闻列表</title>
    <link href="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.css" rel="stylesheet">
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.js"></script>
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table-zh-CN.min.js"></script>
    <script>
        function deleteNews(id){
            if(window.confirm("您确定要删除该新闻吗?")){
                $.post("${ctx}/news/delete",{id:id},function(data){
                    if(data.success){
                        window.location = window.location;
                    }else{
                        alert("删除新闻后台错误!")
                    }
                });
            }
        }
        $(document).ready(function(){
            $("#newsTable").bootstrapTable();
        });
    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            新闻管理
            <small>新闻列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">新闻列表</li>
        </ol>
    </section>
    <section class="content">
        <%--<table id="newsTable" class="table">--%>
            <%--<c:forEach items="${news}" var="n">--%>
                <%--<tr>--%>
                    <%--<td></td>--%>
                    <%--<td style="font-weight: bold">${n.title}</td>--%>
                    <%--<td>【<fmt:formatDate value="${n.crtdate}" pattern="yyyy-MM-dd"></fmt:formatDate>】</td>--%>
                    <%--<td>--%>
                        <%--<c:choose>--%>
                            <%--<c:when test="${n.publish==true}">--%>
                                <%--【已发布】--%>
                            <%--</c:when>--%>
                            <%--<c:otherwise>--%>
                                <%--未发布--%>
                            <%--</c:otherwise>--%>
                        <%--</c:choose>--%>
                    <%--</td>--%>
                    <%--<td>${n.crtuser}</td>--%>
                    <%--<td>--%>
                        <%--<a href="#">详情</a><a href="#">删除</a>--%>
                    <%--</td>--%>
                <%--</tr>--%>
            <%--</c:forEach>--%>
        <%--</table>--%>
            <c:choose>
                <c:when test="${func:length(news)>0}">
                    <ul class="list-group">
                        <c:forEach items="${news}" var="n">
                            <li class="list-group-item">
                                <span>【<fmt:formatDate value="${n.crtdate}" pattern="yyyy-MM-dd"></fmt:formatDate>】</span>
                                <a href="" style="font-weight: bold">${n.title}</a>&nbsp;&nbsp;&nbsp; <span><a onclick="deleteNews(${n.id})">[删除]</a>
                    <c:if test="${n.publish==false}"><a href="#">[发布]</a></c:if></span>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p>目前还没有发布的新闻!</p>
                </c:otherwise>
            </c:choose>

    </section>
</aside>

</body>
</html>
