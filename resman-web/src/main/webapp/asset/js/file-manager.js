/**
 * Created by lcheng on 2015/2/24.
 * 通用的文件管理JS函数
 */
(function ($) {
    "use strict";
    $.fm = {
        iconMap:{
            pdf:"file-pdf-o",
            rar:"file-zip-o", zip:"file-zip-o", gz:"file-zip-o",
            doc:"file-word-o", docx:"file-word-o",
            xlsx:"file-excel-o", xls:"file-excel-o",
            ppt:"file-powerpoint-o", pptx:"file-powerpoint-o",
            png:"file-image-o", jpeg:"file-image-o", jpg:"file-image-o", bmp:"file-image-o",
            mp4:"file-video-o",flv:"file-video-o",avi:"file-video-o",rmvb:"file-video-o",
            txt:"file-text-o"
        },
        getFileIconCls:function(subfix){
           if(!subfix){
               return "fa fa-file-text-o";
           }else{
               var cls = $.fm.iconMap[subfix];
               if(!cls){
                   return "fa fa-file-text-o";
               }else{
                   return "fa fa-"+cls;
               }
           }
        },
        createFileTable: function () {
            $(window.fmConf.tabId).bootstrapTable({
                contentType: "application/x-www-form-urlencoded",
                url: window.fmConf.ctxPath + '/res/common/' + window.fmConf.func + '/query',
                queryParams: function (params) {
                    params.path = window.fmConf.filePath;
                    return params;
                },
                pageList:"[10, 20, 50, 100]",
                pagination:true,
                sidePagination: "server",
                pageSize: 10,
                method: "POST",
                search: true,
                showRefresh: true,
                showColumns: true,
                toolbar: window.fmConf.fileMenuId,
                clickToSelect: true
            });
        },
        createUploadMenu: function (btnId,btnCls,btnTxt) {
            var btnUpload = (btnId && btnId !='') ? $(btnId) : $('#btnUpload'),
                btnClsStr = (btnCls && btnCls!='') ? btnCls : 'btn btn-primary',
                btnTxtStr = (btnTxt && btnTxt!='') ? btnTxt : '上传文件';
            if (btnUpload) {
                var conf = {
                    height: 34,
                    width: 100,
                    buttonClass: btnClsStr,
                    removeTimeout: 0,
                    'fileSizeLimit' : '100MB',
                    'preventCaching' : false,
                    swf: window.fmConf.ctxPath+'/asset/js/plugins/uploadify/uploadify.swf',
                    uploader: window.fmConf.ctxPath+'/res/common/'+window.fmConf.func+'/upload',
                    fileObjName: 'fileData',
                    buttonText: '<span class="fa fa-upload"></span>&nbsp;'+btnTxtStr,
                    queueID: 'fileQueue',
                    formData: {path: window.fmConf.filePath},
                    onInit:function(){
                        var upbtn = (btnId && btnId !='') ? btnId :"#btnUpload";
                        $(upbtn+"-button").css("line-height","");
                    },
                    onQueueComplete: function (queueData) {
                        $('#fileList').bootstrapTable('refresh');
                    }
                };
                if(window.fmConf.allowFileExts && window.fmConf.allowFileExts!=""){
                    conf.fileTypeExts = window.fmConf.allowFileExts;
                }
                //$('#btnUpload').uploadify(conf);
                btnUpload.uploadify(conf);
            }
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
                    postUrl = window.fmConf.ctxPath + "/res/common/" + window.fmConf.func + "/addFolder";
                $.post(postUrl, {path: window.fmConf.filePath, name: val}, function (data) {
                    if (data.success) {
                        dialog.close();
                        $('#fileList').bootstrapTable('refresh');
                    } else {
                        tipError(data.msg);
                    }
                });
            }
        },
        createDocCourse:function(){
            window.location.href = window.fmConf.ctxPath +"/res/course/addDocCourse";
        },
        editDocCourse:function(){
            var sel = $("#fileList").bootstrapTable('getSelections');
            if (sel.length > 0) {
                var docUid = sel[0].uuid,type = sel[0].type;
                if(type=='0'){
                    window.location.href = window.fmConf.ctxPath +"/res/course/editDocCourse?uid="+docUid;
                } else{
                    alert("请选择需要修改的课程!");
                }
            }else{
                alert("请选择需要修改的课程!");
            }
        },
        uploadDocCourse:function(){
            $.fm.createUploadMenu('#btnUploadCourse','btn','上传课件');
        },
        deleteFile:function(){
            var sel = $("#fileList").bootstrapTable('getSelections');
            if (sel.length > 0) {
                BootstrapDialog.confirm('确认要删除吗?', function (result) {
                    if (result) {
                        var names = "",postUrl=window.fmConf.ctxPath+"/res/common/"+window.fmConf.func+"/delete";
                        //for (var i = 0; i < sel.length; i++) {
                        //    names = names + sel[i].name + ",";
                        //}
                        //$.post(postUrl, {
                        //    names: names,
                        //    path: window.fmConf.filePath
                        //}, function (data) {
                        //    if (data.success) {
                        //        $('#fileList').bootstrapTable('refresh');
                        //    } else {
                        //        tipError("删除数据失败！");
                        //    }
                        //});
                        var ids = "";
                        for (var i = 0; i < sel.length; i++) {
                            ids = ids + sel[i].uuid + ",";
                        }
                        $.post(postUrl, {ids: ids}, function (data) {
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
            //path = encodeURI(path);
            window.location.href = window.fmConf.ctxPath + "/res/common/" + window.fmConf.func + "/list?path=" + path;
        },
        _createDownloadFrame:function(dlUrl, triggerDelay, cleaningDelay){
            setTimeout(function () {
                var frame = $('<iframe style="display: none;" class="multi-download-frame"></iframe>');

                frame.attr('src',dlUrl);
                $('body').append(frame);

                setTimeout(function () { frame.remove() }, cleaningDelay);
            }, triggerDelay)
        },
        _downloadComplete:function(uuid){
            console.log(uuid+":"+$.cookie(uuid));
            return $.cookie(uuid) == "complete";
        },
        _downloadFile:function(uuid){
            //$.cookie(uuid,"pending",{path:'/'});
            var dlUrl = window.fmConf.ctxPath+"/res/document/download?uuid="+uuid;
            var frame = $('<iframe style="display: none;" class="multi-download-frame"></iframe>');
            frame.attr('src',dlUrl);
            $('body').append(frame);
            console.log('start downloading '+uuid);
        },
        _dlMgrFunc:function(arr){
            return function(){
                $.fm._downloadManager(arr);
            }
        },
        _downloadManager:function(toDownload){
            var allComplete = false;
            for(var i=0;i<toDownload.length;i++){
                if($.fm._downloadComplete(toDownload[i])){
                    if(i==toDownload.length){
                        allComplete = true;
                    }else{
                        var uid = toDownload[i+1];
                        if(i<(toDownload.length-1)&&($.cookie(uid)==undefined)){
                            $.fm._downloadFile(toDownload[i+1]);
                        }
                    }
                }

            }
            if(allComplete){
                for(var i=toDownload.length;i>0;i--){
                    $.cookie(toDownload[i-1],null,{path:"/"});
                }
                $(".multi-download-frame").remove();
            }else{
                //setTimeout("$.fm._downloadManager("+JSON.stringify(toDownload)+");",1000);
                setTimeout($.fm._dlMgrFunc(toDownload),1000);
                //$.fm._downloadManager(toDownload);
            }
        },
        downloadFile:function(){
            var sel = $("#fileList").bootstrapTable('getSelections');
            if (sel.length > 0) {
                var name = sel[0].name;
                var href = window.fmConf.ctxPath+"/res/document/download?uuid="+sel[0].uuid;
                //window.open(href, null, 'height=250, width=400, top=50,left=50, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
                window.location.href = href;

            } else {
                tipNotify("请先选择资源");
            }
        },
        moveTo :function(){
            var sel = $("#fileList").bootstrapTable('getSelections');
            if (sel.length > 0) {
                var srcPath = sel[0].path,
                    srcIdx = srcPath.lastIndexOf("/");
                $.fm.createFolderSelect("移动到",window.fmConf.mcDir,srcPath, $.fm.doMoveTo);
            }else{
                //alert("请选择要移动的文件(夹)!");
                tipNotify("请选择要移动的文件(夹)!");
            }
        },
        doMoveTo:function(srcPath,destPath,dialog){
            var postUrl = window.fmConf.ctxPath+"/res/common/"+window.fmConf.func+"/moveTo",
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
                $.fm.createFolderSelect("复制到",window.fmConf.mcDir,srcPath, $.fm.doCopyTo);
            }else{
                //alert("请选择要移动的文件(夹)!");
                tipNotify("请选择要复制的文件(夹)!");
            }
        },
        doCopyTo:function(srcPath,destPath,dialog){
            var postUrl = window.fmConf.ctxPath+"/res/common/"+window.fmConf.func+"/copyTo",
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
                                postUrl = window.fmConf.ctxPath+"/res/common/"+window.fmConf.func+"/rename";
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
                var path = encodeURI(window.fmConf.filePath + "/" + value),
                     hrefUrl = window.fmConf.ctxPath + "/res/common/" + window.fmConf.func + "/list?path=" + path;
                return '<i class="fa fa-folder"></i> <a href="' + hrefUrl + '">' + value + '</a>'
            } else {
                var name = row.name,idx = name.lastIndexOf("."),subfix=null;
                if(idx>0){
                    subfix = name.substring(idx+1);
                }
                var iconCls = $.fm.getFileIconCls(subfix);
                //return '<i class="'+iconCls+'"></i><a href="javascript:void(0)" onclick="$.fm.viewFile(\'' + row.uuid
                //    + '\',\'' + value + '\');">' +"&nbsp;&nbsp;" +value;
                return '<a href="javascript:void(0)" onclick="$.fm.viewFile(\'' + row.uuid
                    + '\',\'' + value + '\');">' +'<i class="'+iconCls+'"></i>'+"&nbsp;&nbsp;"+value+'</a>';
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
                            url: window.fmConf.ctxPath +"/res/common/"+ window.fmConf.func+"/folderList",
                            autoParam: ["folderPath=parent"],
                            otherParam:['srcPath',srcPath,'mcDir',parent]
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

