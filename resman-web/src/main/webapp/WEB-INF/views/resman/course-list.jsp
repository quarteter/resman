<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>我的课程</title>
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

    <script id="job-dlg" type="text/x-jsrender">
        <form class="form-horizontal" role="form" id="uploadJobForm" method="post" action="${ctx}/res/course/upload?courseId={{:courseId}}" enctype="multipart/form-data">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="fileData">文件</label>
                <div class="col-sm-6">
                    <input type="file" id="fileData" name="fileData" />
                </div>
            </div>
        </form>

    </script>

    <script>
        $(function () {
            $("#courseList").createBootstrapTable({
                url: "${ctx}/res/course/query",
                cudBtn: true,
                queryParams:function(params){
                    params.pid = '${pid}';
                    return params;
                },
                btns: [
                    {id:'btnScore', name: '查看成绩', iconCls: 'fa fa-th', rowSelectAware: true},
                    {id: "btnTest", name: "测试上传作业", iconCls: "fa fa-upload"}
                ]
            });
            bindToolBtnEvent();
        });

        function bindToolBtnEvent() {
            $("#btnAdd").on("click", function (e) {
                window.location.href = "${ctx}/res/course/add?pid=${pid}"
            });
            $("#btnEdit").on("click", function (e) {
                var sel = $("#courseList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    var uid = sel[0].id;
                    window.location.href = "${ctx}/res/course/edit/" + uid;
                }
            });
            $("#btnDel").on("click", function (e) {
                var sel = $("#courseList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    BootstrapDialog.confirm('确认要删除吗?', function (result) {
                        if (result) {
                            var ids = "";
                            for (var i = 0; i < sel.length; i++) {
                                ids = ids + sel[i].id + ",";
                            }
                            $.post("${ctx}/res/course/delete", {
                                ids: ids
                            }, function (data) {
                                if (data.success) {
                                    window.location.href = "${ctx}/res/course/list"
                                } else {
                                    tipError("删除数据失败！");
                                }
                            });
                        } else {
                        }
                    });

                }
            });

            $("#btnScore").on("click", function (e) {
                var sel = $("#courseList").bootstrapTable('getSelections');
                if(sel.length > 0){
                    if(sel[0].ntype == '0'){
                        alert("不允许上传作业");
                        return;
                    }
                window.location.href = "${ctx}/res/score/list?courseId="+sel[0].id;
                }
            });

            //测试用
            $("#btnTest").on("click", function (e) {
                var sel = $("#courseList").bootstrapTable('getSelections');
                if(sel.length > 0){
                    if(sel[0].ntype == '0'){
                        alert("不允许上传作业");
                        return;
                    }
                    BootstrapDialog.show({
                        title: "测试上传作业",
                        nl2br: false,
                        message: function () {
                            var tpl = $.templates("#job-dlg");
                            return tpl.render({courseId: sel[0].id});
                        },
                        buttons: [
                            {
                                label: '确定',
                                cssClass: 'btn-primary btn-flat',
                                action: function (dialog) {
                                    $('#uploadJobForm').submit();
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

            });
        }

        function nameFormatter(value, row) {
            if (row.ntype == '0') {
                return  '<i class="fa fa-folder"></i> <a href="${ctx}/res/course/list?pid='+row.id+'">' + value;
            } else {
                return  '<i class="fa fa-file-o"></i> ' + value;
            }
        }

    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            我的课程
            <small>课程列表</small>
        </h1>
        <ol class="breadcrumb">
             <c:choose>
                 <c:when test="${empty name}">
                     <li class="active"><i class="fa fa-dashboard"></i> 课程列表</li>
                 </c:when>
                 <c:otherwise>
                     <li><a href="${ctx}/res/course/list"><i class="fa fa-dashboard"></i> 课程列表</a></li>
                     <li class="active">${name}</li>
                 </c:otherwise>
             </c:choose>
        </ol>
    </section>
    <section class="content">
        <table id="courseList">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="name" data-align="left" data-formatter="nameFormatter">名称</th>
                <th data-field="category.name" data-align="center">类别</th>
                <th data-field="description" data-align="center">描述信息</th>
            </tr>
            </thead>
        </table>
    </section>
</aside>
</body>
</html>
