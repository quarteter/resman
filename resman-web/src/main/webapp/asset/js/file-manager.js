/**
 * Created by lcheng on 2015/2/24.
 * 通用的文件管理JS函数
 */
(function ($) {
    "use strict";
    $.fm = {
        createFileTable: function () {
            $(window.tabId).bootstrapTable({
                url: window.ctxPath + '/res/common/' + window.func + '/query',
                queryParams: function (params) {
                    params.path = window.filePath;
                    return params;
                },
                search: true,
                showRefresh: true,
                showColumns: true,
                toolbar: window.fileMenuId,
                clickToSelect: true
            });
        },
        createUploadMenu: function () {
            setTimeout(function () {
                var btnUpload = $('#btnUpload');
                if (btnUpload) {
                    $('#btnUpload').uploadify({
                        height: 34,
                        width: 100,
                        buttonClass: 'btn btn-primary',
                        removeTimeout: 0,
                        swf: window.ctxPath+'/asset/js/plugins/uploadify/uploadify.swf',
                        uploader: window.ctxPath+'/res/common/'+window.func+'/upload',
                        fileObjName: 'fileData',
                        buttonText: '<span class="fa fa-upload"></span>&nbsp;上传文件',
                        queueID: 'fileQueue',
                        formData: {path: window.filePath},
                        onQueueComplete: function (queueData) {
                            $('#fileList').bootstrapTable('refresh');
                        }
                    });
                }
            }, 10);
        },
        createFolder: function () {
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
                            $.fm.createFolderAction(dialog);
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
        },
        createFolderAction: function (dialog) {
            if ($("#folderForm").valid()) {
                var val = $('#name').val(),
                    postUrl = window.ctxPath + "/res/common/" + window.func + "/addFolder";
                $.post(postUrl, {path: window.filePath, name: val}, function (data) {
                    if (data.success) {
                        dialog.close();
                        $('#fileList').bootstrapTable('refresh');
                    } else {
                        tipError(data.msg);
                    }
                });
            }
        },
        deleteFile:function(){
            var sel = $("#fileList").bootstrapTable('getSelections');
            if (sel.length > 0) {
                BootstrapDialog.confirm('确认要删除吗?', function (result) {
                    if (result) {
                        var names = "",postUrl=window.ctxPath+"/res/common/"+window.func+"/delete";
                        for (var i = 0; i < sel.length; i++) {
                            names = names + sel[i].name + ",";
                        }
                        $.post(postUrl, {
                            names: names,
                            path: window.filePath
                        }, function (data) {
                            if (data.success) {
                                $('#fileList').bootstrapTable('refresh');
                            } else {
                                tipError("删除数据失败！");
                            }
                        });
                    } else {
                    }
                });

            }
        },
        clickCrumbs: function (path) {
            path = encodeURI(path);
            path = encodeURI(path);
            window.location.href = window.ctxPath + "/res/common/" + window.func + "/list?path=" + path;
        },
        downloadFile:function(){
            var sel = $("#fileList").bootstrapTable('getSelections');
            if (sel.length > 0) {
                var name = sel[0].name;
                var href = window.ctxPath+"/res/document/download?uuid="+sel[0].uuid;
                window.open(href, null, 'height=250, width=400, top=50,left=50, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
            } else {
                tipNotify("请先选择资源");
            }
        },
        moveTo :function(){
            var sel = $("#fileList").bootstrapTable('getSelections');
            if (sel.length > 0) {
                var srcPath = sel[0].path,
                    srcIdx = srcPath.lastIndexOf("/");
                $.fm.createFolderSelect("移动到",window.mcDir,srcPath, $.fm.doMoveTo);
            }else{
                //alert("请选择要移动的文件(夹)!");
                tipNotify("请选择要移动的文件(夹)!");
            }
        },
        doMoveTo:function(srcPath,destPath,dialog){
            var postUrl = window.ctxPath+"/res/common/"+window.func+"/moveTo",
                params={srcPath:srcPath,destPath:destPath};
            $.post(postUrl, params, function (data) {
                if (data.success) {
                    dialog.close();
                    $('#fileList').bootstrapTable('refresh');
                } else {
                    tipError(data.msg);
                }
            });
        },
        copyTo :function(){
            var sel = $("#fileList").bootstrapTable('getSelections');
            if (sel.length > 0) {
                var srcPath = sel[0].path,
                    srcIdx = srcPath.lastIndexOf("/");
                $.fm.createFolderSelect("复制到",window.mcDir,srcPath, $.fm.doCopyTo);
            }else{
                //alert("请选择要移动的文件(夹)!");
                tipNotify("请选择要复制的文件(夹)!");
            }
        },
        doCopyTo:function(srcPath,destPath,dialog){
            var postUrl = window.ctxPath+"/res/common/"+window.func+"/copyTo",
                params={srcPath:srcPath,destPath:destPath};
            $.post(postUrl, params, function (data) {
                if (data.success) {
                    dialog.close();
                    $('#fileList').bootstrapTable('refresh');
                } else {
                    tipError(data.msg);
                }
            });
        },
        viewFile:function(uuid, name){
            BootstrapDialog.show({
                size: BootstrapDialog.SIZE_WIDE,
                title: name,
                message: function () {
                    var tpl = $.templates("#view-dlg");
                    return tpl.render({uuid:uuid});
                }
            });
        },
        rename:function(){
            var sel = $("#fileList").bootstrapTable('getSelections');
            if (sel.length <= 0)
                tipNotify('请先选择资源');
            var oldName = sel[0].name,
                oldPath = sel[0].path;

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
                            var val = $('#name').val(),
                                postUrl = window.ctxPath+"/res/common/"+window.func+"/rename";
                            $.post(postUrl, {path: oldPath, oldName:oldName, name: val}, function (data) {
                                if (data.success) {
                                    dialog.close();
                                    $('#fileList').bootstrapTable('refresh');
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
        },
        nameFormatter: function (value, row) {
            if (row.type == '0') {
                var path = encodeURI(window.filePath + "/" + value),
                    path = encodeURI(path), hrefUrl = window.ctxPath + "/res/common/" + window.func + "/list?path=" + path;
                return '<i class="fa fa-folder"></i> <a href="' + hrefUrl + '">' + value + '</a>'
            } else {
                return '<i class="fa fa-file-pdf-o"></i> <a href="javascript:void(0)" onclick="$.fm.viewFile(\'' + row.uuid + '\',\'' + value + '\');">' + value;

            }
        },
        createFolderSelect:function(title,parent,srcPath,confirmFunc){
            BootstrapDialog.show({
                title: title,
                nl2br: false,
                message: "<ul id='folderTree' class='ztree'></ul>",
                buttons: [
                    {
                        label: '确定',
                        cssClass: 'btn-primary btn-flat',
                        action: function (dialog) {
                            var ztree = $.fn.zTree.getZTreeObj("folderTree"),
                                nodes = ztree.getCheckedNodes(),
                                srcIdx = srcPath.lastIndexOf("/");
                            if(nodes.length>0){
                                var destPath = nodes[0].folderPath+"/"+srcPath.substring(srcIdx+1);
                                confirmFunc(srcPath,destPath,dialog);
                            }
                        }
                    },
                    {
                        label: '取消',
                        action: function (dialogItself) {
                            dialogItself.close();
                        }
                    }
                ],
                onshown:function(){
                    var setting = {
                        async: {
                            enable: true,
                            url: window.ctxPath +"/res/common/"+ window.func+"/folderList",
                            autoParam: ["folderPath=parent"],
                            otherParam:['srcPath',srcPath]
                        },
                        check:{
                            enable: true,
                            chkStyle: "radio",
                            radioType: "all"
                        }
                    };
                    var ztree = $.fn.zTree.init($("#folderTree"), setting);
                    //    srcIdx =srcPath.lastIndexOf("/") ,
                    //    parentPath = srcPath.substr(0,srcIdx),
                    //    node = ztree.getNodeByParam("folderPath",parentPath,null);
                    //if(node!=null){
                    //    ztree.setChkDisabled(node,true);
                    //}
                }
            });
        }
    }

})(window.jQuery);
