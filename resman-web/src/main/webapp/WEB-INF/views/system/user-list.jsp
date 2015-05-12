<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户管理</title>
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
    <style>
        input.search-input {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            width: 100%;
            margin-bottom: 5px;
            height: auto;
        }
    </style>
    <script id="roleTpl" type="text/x-jsrender">
        <option value="{{:id}}">{{:name}}</option>
    </script>
    <script>
        function sexFormatter(value, row) {
            var iconCls = row.sex == 'Female' ? "fa fa-female" : "fa fa-male";
            return '<i class="' + iconCls + '"></i> ';
        }
        function sysUserFormatter(value, row) {
            var txt = row.sysUserId != null ?
                    "<span class='text-green'>是</span>" : "<span class='text-red'>否</span>";
            return txt;
        }
        function bindToolBtnEvent() {
            $("#btnAdd").on("click", function (e) {
                window.location.href = "${ctx}/sys/user/add"
            });
            $("#btnDel").on("click", function (e) {
                var sel = $("#userList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var ids = "";
                    for (var i = 0; i < sel.length; i++) {
                        ids = ids + sel[i].id + ",";
                    }
                    $.post("${ctx}/sys/user/del", {
                        ids: ids
                    }, function (data) {
                        if (data.success) {
                            window.location.href = "${ctx}/sys/user/list"
                        } else {
                            alert("删除数据失败！");
                        }
                    });
                }
            });
            $("#btnEdit").on("click", function (e) {
                var sel = $("#userList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var uid = sel[0].id;
                    window.location.href = "${ctx}/sys/user/edit?uid=" + uid;
                }
            });

            $("#btnUserRole").on("click", function () {
                var sel = $("#userList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var uid = sel[0].id;
                    BootstrapDialog.show({
                        title: "配置用户角色",
                        nl2br: false,
                        message: '<div class="alert alert-info alert-dismissable">' +
                        '<i class="fa fa-info"></i>' +
                        '<b>注意!</b> 请为用户选择角色：' +
                        '</div>' +
                        '<select id="roleSelect" multiple="multiple"></select>',
                        buttons: [{
                            label: '确定',
                            cssClass: 'btn-primary btn-flat',
                            action: function (dialog) {
                                var sel = $("#roleSelect").val();
                                $.post("${ctx}/sys/user/addRole", {uid: uid, roleIds: sel}, function (data) {
                                    if (data.success) {
                                        dialog.close();
                                    } else {
                                        dialog.close();
                                        BootstrapDialog.warning("为用户添加角色失败!");
                                    }
                                });
                            }
                        }, {
                            label: '取消',
                            action: function (dialogItself) {
                                dialogItself.close();
                            }
                        }],
                        onshown: function () {
                            var tpl = $.templates("#roleTpl");
                            $.post("${ctx}/sys/user/userRole", {uid: uid}, function (data) {
                                var ops = tpl.render(data.all);
                                $(ops).appendTo("#roleSelect");
                                createDualSelect("#roleSelect", "container");
                                var sel = new Array();
                                $.each(data.selected, function (idx, val) {
                                    sel.push(val.toString());
                                });
                                $("#roleSelect").multiSelect("select", sel);
                            });
                        }
                    });
                } else{
                    BootstrapDialog.alert("该用户还不是系统用户，请为其初始化系统用户操作!");
                }
            });
            $("#btnUserImport").on("click",function(){
                window.location.href = "${ctx}/sys/user/import"
            });
        }
        $(document).ready(function () {
            $("#userList").createBootstrapTable({
                url: "${ctx}/sys/user/query",
                cudBtn: true,
                btns: [{id: "btnUserRole", name: "用户角色", iconCls: "fa fa-user", rowSelectAware: true},
                    {id: "btnUserImport", name: "导入用户", iconCls: "fa fa-sign-in", rowSelectAware: false},]
            });
            bindToolBtnEvent();
        });
    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            用户管理
            <small>用户列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">用户列表</li>
        </ol>
    </section>
    <section class="content">
        <table id="userList">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="name" data-align="center">姓 名</th>
                <th data-field="sex" data-formatter="sexFormatter" data-align="center">性 别</th>
                <th data-field="bod" data-align="center">出生年月</th>
                <%--<th data-field="email" data-align="right">电子邮件</th>--%>
                <th data-field="phoneNum" data-align="center">手机号</th>
                <th data-field="telNum" data-align="center">电 话</th>
                <%--<th data-formatter="sysUserFormatter" data-align="center">系统用户</th>--%>
            </tr>
            </thead>
        </table>
    </section>
</aside>
</body>
</html>
