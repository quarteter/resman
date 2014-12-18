<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>角色管理</title>
    <link href="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.css" rel="stylesheet">
    <link href="${ctx}/asset/js/plugins/zTree/css/zTreeStyle.css" rel="stylesheet">
    <link href="${ctx}/asset/js/plugins/multiselect/css/multi-select.css" rel="stylesheet">
    <link href="${ctx}/asset/js/plugins/bsdialog/bootstrap-dialog.min.css" rel="stylesheet">
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.js"></script>
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table-zh-CN.min.js"></script>
    <script src="${ctx}/asset/js/plugins/zTree/jquery.ztree.all-3.5.min.js"></script>
    <script src="${ctx}/asset/js/plugins/bsdialog/bootstrap-dialog.min.js"></script>
    <script src="${ctx}/asset/js/plugins/template/jsrender.min.js"></script>
    <script src="${ctx}/asset/js/plugins/multiselect/js/jquery.multi-select.js"></script>
    <script src="${ctx}/asset/js/jquery.quicksearch.js"></script>
    <script src="${ctx}/asset/js/common.js"></script>
    <script id="permTpl" type="text/x-jsrender">
        <option value="{{:id}}">{{:name}}({{:permission}})</option>
    </script>
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
        var setting = {
            check: {
                enable: true,
                chkboxType: {"Y": "ps", "N": "ps"}
            },
            async: {
                enable: true,
                url: "${ctx}/sys/role/funcTree",
                autoParam: ["id=pid", "name=n", "level=lv"]
            }
        };
        function getSelectRoleId() {
            var tree = $.fn.zTree.getZTreeObj("funcTree"),
                    nodes = tree.getSelectedNodes();
            if (nodes != null && nodes.length > 0) {
                return nodes[0].id;
            }
            return -1;
        }
        function confRoleFuncDialog(rid) {
            BootstrapDialog.show({
                title: "配置角色功能",
                nl2br: false,
                message: '<ul id="funcTree" class="ztree"></ul>',
                buttons: [{
                    label: '确定',
                    cssClass: 'btn-primary btn-flat',
                    action: function (dialog) {
                        var tree = $.fn.zTree.getZTreeObj("funcTree");
                        var nodes = tree.getCheckedNodes(true);
                        var nodeArr = [];
                        $.each(nodes, function (idx, val) {
                            nodeArr.push(val.id);
                        });
                        $.post("${ctx}/sys/role/addFunc", {uid: rid, funcIds: nodeArr}, function (data) {
                            if (data.success) {
                                dialog.close();
                            } else {
                                BootstrapDialog.alert("为角色配置功能失败!");
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
                    $.fn.zTree.init($("#funcTree"), setting);
                }
            });
        }
        function confRolePermDialog(rid) {
            BootstrapDialog.show({
                title: "配置角色权限",
                nl2br: false,
                message: '<div class="alert alert-info alert-dismissable">' +
                '<i class="fa fa-info"></i>' +
                '<b>注意!</b> 请为角色选择权限：' +
                '</div>' +
                '<select id="permSelect" multiple="multiple"></select>',
                buttons: [{
                    label: '确定',
                    cssClass: 'btn-primary btn-flat',
                    action: function (dialog) {
                        var sel =$("#permSelect").val();
                        $.post("${ctx}/sys/role/addPerm",{uid:rid,permIds:sel},function(data){
                            if(data.success){
                                dialog.close();
                            }else{
                                BootstrapDialog.warning("为角色添加权限失败!");
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
                    var tpl = $.templates("#permTpl");
                    $.post("${ctx}/sys/role/rolePerms", {uid: rid}, function (data) {
                        var ops = tpl.render(data.all);
                        $(ops).appendTo("#permSelect");
                        createDualSelect("#permSelect", "container");
                        var sel = new Array();
                        $.each(data.selected, function (idx, val) {
                            sel.push(val.id.toString());
                        });
                        $("#permSelect").multiSelect("select", sel);
                    });

                }
            });
        }
        function bindToolBtnEvent() {
            $("#btnAdd").on("click", function (e) {
                window.location.href = "${ctx}/sys/role/add"
            });
            $("#btnDel").on("click", function (e) {
                var sel = $("#roleList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var ids = "";
                    for (var i = 0; i < sel.length; i++) {
                        ids = ids + sel[i].id + ",";
                    }
                    $.post("${ctx}/sys/role/del", {
                        ids: ids
                    }, function (data) {
                        if (data.success) {
                            window.location.href = "${ctx}/sys/role/list"
                        } else {
                            alert("删除数据失败！");
                        }
                    });
                }
            });
            $("#btnEdit").on("click", function (e) {
                var sel = $("#roleList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var uid = sel[0].id;
                    window.location.href = "${ctx}/sys/role/edit?uid=" + uid;
                }
            });
            $("#btnRoleFunc").on("click", function (e) {
                var sel = $("#roleList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var id = sel[0].id;
                    setting.async.otherParam = {rid: id};
                    confRoleFuncDialog(id);
                }
            });
            $("#btnRolePerm").on("click", function (e) {
                var sel = $("#roleList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var id = sel[0].id;
                    confRolePermDialog(id);
                }
            });
        }
        $(document).ready(function () {
            $("#roleList").createBootstrapTable({
                url: "${ctx}/sys/role/query",
                cudBtn: true,
                btns: [
                    {id: "btnRoleFunc", name: "角色功能", iconCls: "fa fa-wrench", rowSelectAware: true},
                    {id: "btnRolePerm", name: "角色权限", iconCls: "fa fa-tasks", rowSelectAware: true}
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
            角色管理
            <small>角色列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">角色列表</li>
        </ol>
    </section>
    <section class="content">
        <table id="roleList">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="name" data-align="center">角色名称</th>
                <th data-field="role" data-align="center">角 色</th>
                <th data-field="notes" data-align="center">描 述</th>
                <%--<th data-align="center" data-formatter="roleActionFormatter">操 作</th>--%>
            </tr>
            </thead>
        </table>
    </section>
</aside>
</body>
</html>

