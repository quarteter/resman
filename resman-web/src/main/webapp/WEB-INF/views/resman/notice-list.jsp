<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>公告管理</title>
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
    <script src="${ctx}/asset/js/jNotify.jquery.min.js"></script>
    <style>
        input.search-input {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            width: 100%;
            margin-bottom: 5px;
            height: auto;
        }
    </style>

    <script>
        function bindToolBtnEvent() {
            $("#btnAdd").on("click", function (e) {
                window.location.href = "${ctx}/res/notice/add"
            });
            $("#btnDel").on("click", function (e) {
                var sel = $("#noticeList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    BootstrapDialog.confirm('确认要删除吗?', function (result) {
                        if (result) {
                            var ids = "";
                            for (var i = 0; i < sel.length; i++) {
                                ids = ids + sel[i].id + ",";
                            }
                            $.post("${ctx}/res/notice/delete", {
                                ids: ids
                            }, function (data) {
                                if (data.success) {
                                    window.location.href = "${ctx}/res/notice/list"
                                } else {
                                    tipError("删除数据失败！");
                                }
                            });
                        } else {
                        }
                    });

                }
            });
            $("#btnEdit").on("click", function (e) {
                var sel = $("#noticeList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var uid = sel[0].id;
                    window.location.href = "${ctx}/res/notice/edit/" + uid;
                }
            });
            $("#btnAudit").on("click", function (e) {
                var sel = $("#noticeList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var uid = sel[0].id;
                    $.post("${ctx}/res/notice/audit/" + uid, null, function (data) {
                        if (data.success) {
                            window.location.href = "${ctx}/res/notice/list"
                        } else {
                            tipError(data.msg);
                        }
                    });
                }
            });

        }
        $(document).ready(function () {
            $("#noticeList").createBootstrapTable({
                url: "${ctx}/res/notice/query",
                cudBtn: true,
                btns: [
                    {id: "btnAudit", name: "发布", iconCls: "fa fa-user", rowSelectAware: true}
                ]
            });
            bindToolBtnEvent();
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
        <table id="noticeList">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="title" data-align="center">标题</th>
                <th data-field="crtuser" data-align="center">发布者</th>
                <th data-field="crtdate" data-align="center">发布时间</th>
                <th data-field="state" data-align="center">状态</th>
            </tr>
            </thead>
        </table>
    </section>
</aside>
</body>
</html>
