<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>功能管理</title>
    <link href="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.css" rel="stylesheet">
    <link href="${ctx}/asset/js/plugins/zTree/css/zTreeStyle.css" rel="stylesheet">
    <link href="${ctx}/asset/js/plugins/bsdialog/bootstrap-dialog.min.css" rel="stylesheet">
    <style>
        .sidebar-shortcuts {
            background-color: #fafafa;
            border-bottom: 1px solid #ddd;
            /*text-align: center;*/
            line-height: 39px;
            max-height: 41px;
            margin-bottom: 0;
        }

        .sidebar-shortcuts-large {
            padding-bottom: 4px;
        }

    </style>
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.js"></script>
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table-zh-CN.min.js"></script>
    <script src="${ctx}/asset/js/plugins/zTree/jquery.ztree.all-3.5.min.js"></script>
    <script src="${ctx}/asset/js/plugins/bsdialog/bootstrap-dialog.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctx}/asset/js/plugins/template/jsrender.min.js"></script>
    <script src="${ctx}/asset/js/common.js"></script>
    <script id="funcTpl" type="text/x-jsrender">
        <form class="form-horizontal" role="form" id="funcModuleForm">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="name">功能名称</label>
              <div class="col-sm-4">
                <input id="name" class="form-control" name="name"/>
              </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="url"> URL</label>
            <div class="col-sm-4">
                <input id="url" class="form-control" name="url"/>
            </div>
           </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="seqNo"> 序 号</label>
                <div class="col-sm-4">
                    <input id="seqNo" class="form-control" name="seqNo"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="iconCls"> 图标(类)</label>
                <div class="col-sm-4">
                    <input id="iconCls" class="form-control" name="iconCls"/>
                </div>
            </div>
            </form>
    </script>
    <script type="text/javascript">
        var setting = {
            edit: {
                enable: true,
                showRemoveBtn: false,
                showRenameBtn: false,
                drag: {
                    inner: false,
                    isCopy: false
                }
            },
            async: {
                enable: true,
                url: "${ctx}/sys/func/treeList",
                autoParam: ["id=pid", "name=n", "level=lv"]
            },
            callback: {
                beforeDrop: beforeDrop,
                onDrop: onDrop,
                onClick:onNodeClick
            },
            view: {
                selectedMulti: false
            }
        };
        function beforeDrop(treeId, treeNodes, targetNode, moveType) {
            var result = false,
                    srclen = treeNodes.length,
                    curLevel = -1,
                    targetParent = targetNode.getParentNode(),
                    srcParent = null;
            for (var i = 0; i < srclen; i++) {
                srcParent = treeNodes[i].getParentNode();
                if (srcParent !== targetParent) {
                    return false;
                }
                if (i == 0) {
                    curLevel = treeNodes[i].level;
                } else {
                    return curLevel == treeNodes[i].level;
                }
            }

            return targetNode ? targetNode.level == curLevel : false;
        }
        function onDrop(event, treeId, treeNodes, targetNode, moveType) {
            if (treeNodes && treeNodes.length > 0) {
                var srcId = treeNodes[0].id,
                        targetId = targetNode.id,
                        treeObj = $.fn.zTree.getZTreeObj("funcTree");
                $.post("${ctx}/sys/func/adjustSeqNo", {
                    srcId: srcId,
                    targetId: targetId,
                    type: moveType
                }, function (data) {
                    if (!data.success) {
                        treeObj.reAsyncChildNodes(targetNode.getParentNode(), "refresh", true);
                    }
                });
            }
        }
        function onNodeClick(event, treeId, treeNode, clickFlag){
            $("#infoSpan").text("").removeClass("label label-success label-warning");
            $("#infoPanel").show();
            var id = treeNode.id,url="${ctx}/sys/func/"+id;
            $.get(url,{},function(data){
                $("#fid").val(data.id);
                $("#fname").val(data.name);
                $("#furl").val(data.url);
                $("#fseqNo").val(data.seqNo);
                $("#ficonCls").val(data.iconCls);
            });
        }
        /*
         * 创建功能树
         */
        function createFuncTree() {
            $.fn.zTree.init($("#funcTree"), setting);
        }

        function addFuncDialog(leaf) {
            BootstrapDialog.show({
                title: "添加功能模块",
                nl2br: false,
                message: function () {
                    var tpl = $.templates("#funcTpl");
                    return tpl.render({});
                },
                buttons: [{
                    label: '确定',
                    cssClass: 'btn-primary btn-flat',
                    action: function (dialog) {
                        addFuncAction(dialog, leaf);
                    }
                }, {
                    label: '取消',
                    action: function (dialogItself) {
                        dialogItself.close();
                    }
                }]
            });
        }

        function addFuncAction(dialogRef, leaf) {
            var name = $("#name").val(),
                    url = $("#url").val(),
                    seqNo = $("#seqNo").val(),
                    iconCls = $("#iconCls").val(),
                    data = {"name": name, "url": url, "seqNo": seqNo},
                    treeObj = $.fn.zTree.getZTreeObj("funcTree"),
                    nodes = treeObj.getSelectedNodes();
            if (nodes.length > 0) {
                data.parent = nodes[0].id;
                data.level = nodes[0].level + 1;
            } else {
                data.level = 0;
            }
            data.leaf = leaf;
            if (iconCls != null && iconCls != "") {
                data.iconCls = iconCls;
            }

            $.post("${ctx}/sys/func/add", data, function (data) {
                if (!data.success) {
                    BootstrapDialog.alert("添加功能模块失败!");
                } else {
                    dialogRef.close();
                    if (nodes.length > 0) {
                        treeObj.reAsyncChildNodes(nodes[0], "refresh", true);
                    } else {
                        treeObj.reAsyncChildNodes(null, "refresh", false);
                    }
                }
            });
        }
        function delFuncAction() {
            var tree = $.fn.zTree.getZTreeObj("funcTree"),
                    nodes = tree.getSelectedNodes();
            if (nodes.length > 0) {
                var id = nodes[0].id,
                        data = {"uid": id};
                $.post("${ctx}/sys/func/del", data, function (data) {
                    if (!data.success) {
                        BootstrapDialog.warning("删除功能模块失败!")
                    } else {
                        if (nodes[0].getParentNode() != null) {
                            tree.reAsyncChildNodes(nodes[0].getParentNode(), "refresh", false);
                        } else {
                            tree.reAsyncChildNodes(null, "refresh");
                        }
                    }
                });
            }
        }
        function refreshModuleTreeAction() {
            var tree = $.fn.zTree.getZTreeObj("funcTree"),nodes = tree.getSelectedNodes();
            if(nodes.length>0){
                var parent = nodes[0].getParentNode();
                if(parent){
                    tree.reAsyncChildNodes(parent, "refresh", false);
                }else{
                    tree.reAsyncChildNodes(null, "refresh", true);
                }
            }
            $("#infoPanel").hide();
        }
        function queryParamFunc(params) {
            var page = params.pageNumber,
                    size = params.pageSize,
                    tree = $.fn.zTree.getZTreeObj("funcTree"),
                    nodes = tree.getSelectedNodes();
            delete params.pageNumber;
            delete params.pageSize;
            params.page = (page - 1);
            params.size = size;
            if (nodes.length > 0) {
                var id = nodes[0].id;
                params.pid = id;
            } else {
                var roots = tree.getNodes();
                if (roots.length > 0) {
                    var id = roots[0].id;
                    params.pid = id;
                }
            }
        }
        function updateFunc(){
            if(!$("#infoForm").valid()){
                return;
            }
            var id=$("#fid").val(),name =$("#fname").val(),
            url = $("#furl").val(), seqNo = $("#fseqNo").val(),
            iconCls = $("#ficonCls").val();
            $.post("${ctx}/sys/func/update",{
                id:id,name:name,url:url,seqNo:seqNo,iconCls:iconCls
            },function(data){
                if(data.success){
                    $("#infoSpan").addClass("label label-success").text("更新成功");
                }else{
                    $("#infoSpan").addClass("label label-warning").text("更新失败");
                }
            });
        }
        function addValidator() {
            $("#infoForm").validate({
                rules: {
                    "fname":{
                        required:true
                    },
                    "fseqNo":{
                        digits:true
                    },
                    "ficonCls":{
                        maxlength:100
                    }
                }
            });
        }

        //===================bind event==============
        function bindFuncModuleEvent() {
            $("#funcAddBtn").on("click", function () {
                addFuncDialog(false);
            });
            $("#funcPointAddBtn").on("click", function () {
                addFuncDialog(true);
            });
            $("#funcDelBtn").on("click", function () {
                delFuncAction();
            });
            $("#funcRefreshBtn").on("click", function () {
                refreshModuleTreeAction();
            });
        }
        function bindFuncEvent() {
            $("#btnAdd").on("click", function () {
                BootstrapDialog
            });
        }
        $(document).ready(function () {
            createFuncTree();
            bindFuncModuleEvent();
            addValidator();
            $("#infoPanel").hide();
        });
    </script>
</head>
<body>
<aside class="right-side">

    <section class="content-header">
        <h1>
            权限管理
            <small>功能列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">功能列表</li>
        </ol>
    </section>
    <section class="content">
        <div class="row">
            <div class="col-sm-3">
                <div class="sidebar-shortcuts">
                    <div class="sidebar-shortcuts-large">
                        <button class="btn btn-primary btn-sm btn-flat" id="funcAddBtn">
                            <i class="fa fa-file fa-fw"></i>
                        </button>
                        <button class="btn btn-primary btn-sm btn-flat" id="funcPointAddBtn">
                            <i class="fa fa-plus-circle fa-fw"></i>
                        </button>
                        <button class="btn btn-warning btn-sm btn-flat" id="funcDelBtn">
                            <i class="fa fa-trash-o fa-fw"></i>
                        </button>
                        <button class="btn btn-success btn-sm btn-flat" id="funcRefreshBtn">
                            <i class="fa fa-refresh fa-fw"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-3">
                <ul id="funcTree" class="ztree"></ul>
            </div>
            <div class="col-sm-7">
                <div class="panel panel-default" id="infoPanel">
                    <div class="panel-heading">功能信息<span id="infoSpan"></span></div>
                    <div class="panel-body">
                        <form class="form-horizontal" role="form" id="infoForm">
                            <input type="hidden" id="fid" value=""/>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="fname">功能名称</label>

                                <div class="col-sm-4">
                                    <input id="fname" class="form-control" name="fname"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="furl">功能URL</label>

                                <div class="col-sm-4">
                                    <input id="furl" class="form-control" name="furl"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="fseqNo">功能序号</label>

                                <div class="col-sm-4">
                                    <input id="fseqNo" class="form-control" name="fseqNo"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="ficonCls"> 图标(类)</label>
                                <div class="col-sm-4">
                                    <input id="ficonCls" class="form-control" name="ficonCls"/>
                                </div>
                            </div>
                            <hr/>
                            <button type="button" id="btnUpdate" class="btn btn-primary btn-flat" style="margin-left: 105px"
                                    onclick="updateFunc();"><i class="fa fa-refresh"></i>&nbsp;更新</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</aside>
</body>
</html>

