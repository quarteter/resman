<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>公告列表</title>
    <script src="${ctx}/asset/js/jNotify.jquery.min.js"></script>
    <script src="${ctx}/asset/js/plugins/bspaginator/bootstrap-paginator.min.js"></script>
    <script src="${ctx}/asset/js/common.js"></script>
    <script>
        function deleteNotice(id){
            if(window.confirm("您确定要删除公告吗?")){
                $.post("${ctx}/res/notice/delete",{ids:id},function(data){
                    if(data.success){
                        window.location.reload();
                        //window.location.href = window.location.href;
                    }else{
                        tipError("删除公告失败!");
                    }
                });
            }
        }
        function audit(id,type){
            $.post("${ctx}/res/notice/audit", {id:id,state:type}, function (data) {
                if (data.success) {
                    //window.location.reload(true);
                    window.location = location;
                } else {
                    tipError(data.msg);
                }
            });
        }
        function editNotice(id){
            window.location.href = "${ctx}/res/notice/edit/" + id;
        }
        function createPaginator(){
            var option={
                bootstrapMajorVersion:3,
                currentPage: ${currentPage+1},
                totalPages: ${totalPages},
                numberOfPages:10,
                alignment:"center",
                pageUrl:function(type, page, current){
                    var p = page-1;
                    return "${ctx}"+"/res/notice/pageList?page="+p;
                }
            };
            $("#paginator").bootstrapPaginator(option);
        }
        $(document).ready(function(){
            createPaginator();
        });
    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            公告管理
            <small>公告列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">公告列表</li>
        </ol>
    </section>
    <section class="content">
        <c:forEach items="${content}" var="notice">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">${notice.title} &nbsp;<small>${notice.crtuser}&nbsp;发布于 <fmt:formatDate value="${notice.crtdate}" pattern="yyyy-MM-dd HH:mm:ss" /></small> </h3>
                </div>
                <div class="box-body">${notice.content}</div>
                <div class="box-footer">
                    <c:if test="${notice.state=='0'}">
                        <a href="javascript:void(0)" onclick="audit('${notice.id}','1');"><span class="text-red">&nbsp;未审核</span></a>
                    </c:if>
                    <c:if test="${notice.state=='1'}">
                        <a href="javascript:void(0)" onclick="audit('${notice.id}','0');">&nbsp;反审核</a>
                    </c:if>
                    <a href="javascript:void(0)" onclick="editNotice('${notice.id}');">&nbsp;编辑</a>
                    <a href="javascript:void(0)" onclick="deleteNotice('${notice.id}');">&nbsp;删除</a>
                </div>
            </div>
        </c:forEach>
        <ul id="paginator"></ul>
    </section>
</aside>
</body>
</html>
</body>
</html>
