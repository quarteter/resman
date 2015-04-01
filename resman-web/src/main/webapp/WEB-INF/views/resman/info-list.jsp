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
    <script src="${ctx}/asset/js/plugins/bspaginator/bootstrap-paginator.min.js"></script>
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
        function publishInfo() {
            window.location.href = "${ctx}/info/add";
        }
        function createPaginator() {
            var option = {
                bootstrapMajorVersion: 3,
                currentPage: ${curPage+1},
                totalPages: ${totalPages},
                numberOfPages: 20,
                alignment: "center",
                pageUrl: function (type, page, current) {
                    var p = page - 1;
                    var type = "${type}";
                    if (type && type.length > 0) {
                        return "${ctx}" + "/info/list?type=${type}&page=" + p;
                    } else {
                        return "${ctx}" + "/info/list?page=" + p;
                    }
                }
            };
            $("#paginator").bootstrapPaginator(option);
        }
        function doPublish(id,state){
            $.post("${ctx}/info/update",{
                id:id,
                publish:state
            },function(data){
                if(data.success){
                    location = location ;
                }else{
                    alert("更新失败!");
                }
            });
        }
        $(document).ready(function () {
            //$("#newsTable").bootstrapTable();
            createPaginator();
            $(".dropdown-menu > li").removeClass("active");
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
    <section class="content" style="min-height: 300px">
        <div class="row">
            <div class="col-md-10">

                <button type="button" class="btn btn-primary" onclick="publishInfo()"><span class="fa fa-file-text"> 发布信息</span>
                </button>
                <div class="btn-group">

                    <button type="button" class="btn btn-success"><span class="fa fa-list"> 信息栏目</span></button>
                    <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown"
                            aria-expanded="false">
                        <span class="caret"></span>
                        <span class="sr-only">信息栏目</span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="${ctx}/info/list">所有</a></li>
                        <li class="divider"></li>
                        <c:forEach items="${infoType}" var="type">
                            <li><a href="${ctx}/info/list?type=${type.code}">${type.name}</a></li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>

        <div class="row" style="margin-top: 10px">
            <div class="col-md-10">
                <c:choose>
                    <c:when test="${func:length(news)>0}">
                        <ul class="list-group">
                            <c:forEach items="${news}" var="n">
                                <li class="list-group-item">
                                    <span>【${typeMap[n.type]}】【<fmt:formatDate value="${n.crtdate}"
                                                           pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>】</span>
                                    <a href="${ctx}/info/edit?id=${n.id}" style="font-weight: bold">${n.title}</a>&nbsp;&nbsp;&nbsp; <span><a
                                        onclick="deleteNews(${n.id})">[删除]</a>
                                    <c:if test="${n.publish==false}"><a href="javascript:void(0)" onclick="doPublish(${n.id},'true');">[发布]</a></c:if></span>
                                    <c:if test="${n.publish==true}"><a href="javascript:void(0)" onclick="doPublish(${n.id},'false');">[不发布]</a></c:if>
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
        <ul id="paginator"></ul>
    </section>
</aside>

</body>
</html>
