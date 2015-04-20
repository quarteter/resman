<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>系统编码管理</title>
    <link href="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.css" rel="stylesheet">
    <link href="${ctx}/asset/js/plugins/multiselect/css/multi-select.css" rel="stylesheet">
    <link href="${ctx}/asset/js/plugins/bsdialog/bootstrap-dialog.min.css" rel="stylesheet">
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.js"></script>
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table-zh-CN.min.js"></script>
    <script src="${ctx}/asset/js/plugins/bsdialog/bootstrap-dialog.js"></script>
    <script src="${ctx}/asset/js/plugins/template/jsrender.min.js"></script>
    <script src="${ctx}/asset/js/plugins/multiselect/js/jquery.multi-select.js"></script>
    <script src="${ctx}/asset/js/jquery.quicksearch.js"></script>
    <script src="${ctx}/asset/js/common.js"></script>
    <script>

        function bindToolBtnEvent() {
            $("#btnAdd").on("click", function (e) {
                window.location.href = "${ctx}/sys/code/add"
            });
            $("#btnDel").on("click", function (e) {
                var sel = $("#codeList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var ids = "";
                    for (var i = 0; i < sel.length; i++) {
                        ids = ids + sel[i].id + ",";
                    }
                    $.post("${ctx}/sys/code/del", {
                        ids: ids
                    }, function (data) {
                        if (data.success) {
                            window.location.href = "${ctx}/sys/code/list"
                        } else {
                            alert("删除数据失败！");
                        }
                    });
                }
            });
            $("#btnEdit").on("click", function (e) {
                var sel = $("#codeList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var uid = sel[0].id;
                    window.location.href = "${ctx}/sys/code/edit?uid=" + uid;
                }
            });
        }
        $(document).ready(function () {
            $("#codeList").createBootstrapTable({
                url: "${ctx}/sys/code/query",
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
            系统管理
            <small>编码列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">编码列表</li>
        </ol>
    </section>
    <section class="content">
        <table id="codeList">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="category" data-align="center">分类标识</th>
                <th data-field="code" data-align="center">编 码</th>
                <th data-field="name" data-align="center">编码名称</th>
                <%--<th data-field="email" data-align="right">电子邮件</th>--%>
                <th data-field="seqNo" data-align="center">序 号</th>
            </tr>
            </thead>
        </table>
    </section>
</aside>
</body>
</html>
