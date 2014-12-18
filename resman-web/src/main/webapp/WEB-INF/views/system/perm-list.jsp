<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>权限管理</title>
    <link href="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.css" rel="stylesheet">
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.js"></script>
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table-zh-CN.min.js"></script>
    <script src="${ctx}/asset/js/common.js"></script>
    <script>

        function bindToolBtnEvent() {
            $("#btnAdd").on("click", function (e) {
                window.location.href = "${ctx}/sys/perm/add"
            });
            $("#btnDel").on("click", function (e) {
                var sel = $("#permList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var ids = "";
                    for (var i = 0; i < sel.length; i++) {
                        ids = ids + sel[i].id + ",";
                    }
                    $.post("${ctx}/sys/perm/del", {
                        ids: ids
                    }, function (data) {
                        if (data.success) {
                            window.location.href = "${ctx}/sys/perm/list"
                        } else {
                            alert("删除数据失败！");
                        }
                    });
                }
            });
            $("#btnEdit").on("click", function (e) {
                var sel = $("#permList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var uid = sel[0].id;
                    window.location.href = "${ctx}/sys/perm/edit?uid=" + uid;
                }
            });
        }
        $(document).ready(function () {
            <%--createBootstrapTable("#permList",--%>
                    <%--"${ctx}/sys/perm/query", true);--%>
            $("#permList").createBootstrapTable({
                url:"${ctx}/sys/perm/query",
                cudBtn: true
            });
            bindToolBtnEvent();
        });
    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            权限管理
            <small>权限列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">权限列表</li>
        </ol>
    </section>
    <section class="content">
        <table id="permList">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="name" data-align="center">权限名称</th>
                <th data-field="resource" data-align="center">资 源</th>
                <th data-field="permission" data-align="center">权限标识</th>
                <th data-field="notes" data-align="center">备 注</th>
            </tr>
            </thead>
        </table>
    </section>
</aside>
</body>
</html>

