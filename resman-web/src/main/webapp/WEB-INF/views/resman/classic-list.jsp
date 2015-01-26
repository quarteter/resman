<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>管理空间</title>
    <link href="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.css" rel="stylesheet">
    <link href="${ctx}/asset/css/jNotify.jquery.css" rel="stylesheet"/>
    <link href="${ctx}/asset/js/plugins/bsdialog/bootstrap-dialog.min.css" rel="stylesheet">
    <link href="${ctx}/asset/js/plugins/uploadify/uploadify.css" rel="stylesheet"/>

    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.js"></script>
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table-zh-CN.min.js"></script>
    <script src="${ctx}/asset/js/plugins/bsdialog/bootstrap-dialog.js"></script>
    <script src="${ctx}/asset/js/plugins/template/jsrender.min.js"></script>
    <script src="${ctx}/asset/js/common.js"></script>
    <script src="${ctx}/asset/js/jNotify.jquery.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx}/asset/js/plugins/uploadify/jquery.uploadify.min.js"></script>

    <script id="view-dlg" type="text/x-jsrender">
        <iframe src="${ctx}/res/space/view?path={{:path}}&name={{:name}}" width="870px" height="560px" scrolling="auto"></iframe>
    </script>

    <script id="folder-dlg" type="text/x-jsrender">
        <form class="form-horizontal" role="form" id="folderForm">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="name">名称</label>

                <div class="col-sm-6">
                    <input id="name" class="form-control" name="name"/>
                </div>
            </div>
        </form>

    </script>

    <script id="tree-dlg" type="text/x-jsrender">
        <ul id="folderTree" class="ztree"></ul>
    </script>

    <script>
        $(function () {
            $('#spaceList').bootstrapTable({
                url: '${ctx}/res/course/classic/query',
                search: true,
                showRefresh: true,
                showColumns: true,
                toolbar: '#tb-space',
                clickToSelect: true
            });

            $("#folderForm").validate({
                rules: {
                    "name": {
                        required: true,
                        minlength: 2,
                        maxlength: 20
                    }
                }
            });

            $('#btnCreate').on('click', function () {
                showFolderDialog();
            });

            $('#btnDelete').on('click', function () {
                var sel = $("#spaceList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    BootstrapDialog.confirm('确认要删除吗?', function (result) {
                        if (result) {
                            var names = "";
                            for (var i = 0; i < sel.length; i++) {
                                names = names + sel[i].name + ",";
                            }
                            $.post("${ctx}/res/course/classic/delete", {
                                names: names,
                                path: '${path}'
                            }, function (data) {
                                if (data.success) {
                                    $('#spaceList').bootstrapTable('refresh');
                                } else {
                                    tipError("删除数据失败！");
                                }
                            });
                        } else {
                        }
                    });

                }
            });

            $('#btnUpload').uploadify({
                height: 34,
                width: 100,
                buttonClass: 'btn btn-primary',
                removeTimeout: 0,
                swf: '${ctx}/asset/js/plugins/uploadify/uploadify.swf',
                uploader: '${ctx}/res/course/classic/upload',
                fileObjName: 'fileData',
                buttonText: '<span class="fa fa-upload"></span>&nbsp;上传文件',
                queueID: 'fileQueue',
                formData: {path: '${path}'},
                onQueueComplete: function (queueData) {
                    $('#spaceList').bootstrapTable('refresh');
                }
            });

            $('#btnDownload').on('click', function () {
                var sel = $("#spaceList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var name = sel[0].name;
                    var href = "${ctx}/res/course/classic/download?name="+name + "&path=${path}";
                    window.open(href, null, 'height=250, width=400, top=50,left=50, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
                } else {
                    tipNotify("请先选择资源");
                }
            });

            $.fn.zTree.init($("#folderTree"), setting);
        });

        function nameFormatter(value, row) {
            if (row.type == '0') {
                var path = encodeURI('${path}/'+value);
                path = encodeURI(path);
                return  '<i class="fa fa-folder"></i> <a href="${ctx}/res/space/list?path='+path+'">' + value;
            } else {
                <c:if test="${path==''}">
                return '<i class="fa fa-file-pdf-o"></i> <a href="javascript:void(0)" onclick="viewFile(\''+value+'\');">' + value;
                </c:if>
                return '<i class="fa fa-file-pdf-o"></i> <a href="javascript:void(0)" onclick="viewFile(\''+value+'\',\'${path}\');">' + value;
            }
        }

        function viewFile(name, path){
            BootstrapDialog.show({
                size: BootstrapDialog.SIZE_WIDE,
                title: name,
                message: function () {
                    var tpl = $.templates("#view-dlg");
                    return tpl.render({name:name,path:path});
                }
            });
        }

        function showFolderDialog() {
            BootstrapDialog.show({
                title: "新建文件夹",
                nl2br: false,
                message: function () {
                    var tpl = $.templates("#folder-dlg");
                    return tpl.render({});
                },
                buttons: [
                    {
                        label: '确定',
                        cssClass: 'btn-primary btn-flat',
                        action: function (dialog) {
                            saveFolder(dialog);
                        }
                    },
                    {
                        label: '取消',
                        action: function (dialogItself) {
                            dialogItself.close();
                        }
                    }
                ]
            });
        }

        function saveFolder(dialog) {
            if ($("#folderForm").valid()) {
                var val = $('#name').val();
                $.post('${ctx}/res/course/classic/addFolder',
                        {path: '${path}', name: val,status:"0",visibility:"a"},
                        function (data) {
                    if (data.success) {
                        dialog.close();
                        $('#spaceList').bootstrapTable('refresh');
                    } else {
                        tipError(data.msg);
                    }
                });
            }
        }

        function rename(){
            var sel = $("#spaceList").bootstrapTable('getSelections');
            if (sel.length <= 0)
                tipNotify('请先选择资源');
            var oldName = sel[0].name;

            BootstrapDialog.show({
                title: "重命名",
                nl2br: false,
                message: function () {
                    var tpl = $.templates("#folder-dlg");
                    return tpl.render({});
                },
                buttons: [
                    {
                        label: '确定',
                        cssClass: 'btn-primary btn-flat',
                        action: function (dialog) {
                            var val = $('#name').val();
                            $.post('${ctx}/res/course/classic/rename', {path: '${path}', oldName:oldName, name: val}, function (data) {
                                if (data.success) {
                                    dialog.close();
                                    $('#spaceList').bootstrapTable('refresh');
                                } else {
                                    tipError(data.msg);
                                }
                            });
                        }
                    },
                    {
                        label: '取消',
                        action: function (dialogItself) {
                            dialogItself.close();
                        }
                    }
                ]
            });
            $('#name').val(oldName);
        }

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
                onDrop:onDrop
            },
            view:{
                selectedMulti:false
            }
        };

        function move(){
            var sel = $("#spaceList").bootstrapTable('getSelections');
            if (sel.length <= 0)
                tipNotify('请先选择资源');
            var oldName = sel[0].name;

            BootstrapDialog.show({
                title: "重命名",
                nl2br: false,
                message: function () {
                    var tpl = $.templates("#tree-dlg");
                    return tpl.render({});
                },
                buttons: [
                    {
                        label: '确定',
                        cssClass: 'btn-primary btn-flat',
                        action: function (dialog) {
                            var val = $('#name').val();
                            $.post('${ctx}/res/space/rename', {path: 'personal/zs', oldName:oldName, name: val}, function (data) {
                                if (data.success) {
                                    dialog.close();
                                    $('#spaceList').bootstrapTable('refresh');
                                } else {
                                    tipError(data.msg);
                                }
                            });
                        }
                    },
                    {
                        label: '取消',
                        action: function (dialogItself) {
                            dialogItself.close();
                        }
                    }
                ]
            });
            $('#name').val(oldName);
        }

        function clickHref(path){
            path = encodeURI(path);
            path = encodeURI(path);
            window.location.href = "${ctx}/res/course/classic/list?path="+path;
        }
    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            我的空间
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">我的空间</li>
        </ol>
    </section>
    <section class="content">
        <table id="spaceList">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="name" data-align="left" data-formatter="nameFormatter">文件名</th>
                <th data-field="size" data-align="left">大小</th>
                <th data-field="modifyDate" data-align="left">修改日期</th>
            </tr>
            </thead>
        </table>
    </section>
    <div id="tb-space">
        <div id="btnUpload"></div>
        <button id="btnCreate" type="button" class="btn btn-default"><span class="fa fa-folder-o"></span>&nbsp;新建文件夹
        </button>
        <button id="btnDownload" type="button" class="btn btn-default"><span class="fa fa-download"></span>&nbsp;下载
        </button>
        <button id="btnDelete" type="button" class="btn btn-default"><span class="fa fa-trash"></span>&nbsp;删除</button>
        <button id="btnShare" type="button" class="btn btn-default"><span class="fa fa-share-alt"></span>&nbsp;分享
        </button>
        <div class="btn-group">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                更多
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li><a href="#">移动到</a></li>
                <li><a href="#">复制到</a></li>
                <li><a href="#">重命名</a></li>
            </ul>
        </div>
    </div>
    <div id="fileQueue"></div>

</aside>
</body>
</html>
