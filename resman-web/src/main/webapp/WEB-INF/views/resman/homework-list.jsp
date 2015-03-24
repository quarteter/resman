<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>课程作业</title>
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



        $(document).ready(function () {
            $("#homeworkList").createBootstrapTable({
                url: "${ctx}/res/homework/query",
                cudBtn: false
            });
        });

        function onBtnListScore( id )
        {
            window.location.href = "${ctx}/res/homework/listScore/"+id;
        }

        function onBtnAddHomeWork( id )
        {
            BootstrapDialog.show({
                title: "上传作业",
                nl2br: false,
                message: function () {
                    var tpl = $.templates("#job-dlg");
                    return tpl.render({courseId: id});
                },
                buttons: [
                    {
                        label: '确定',
                        cssClass: 'btn-primary btn-flat',
                        action: function (dialog) {
                            $('#uploadJobForm').submit();
                            alert("提交完成");
                            dialogItself.close();
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



        function nameFormatter(value, row) {
           return  '<i class="fa fa-file-o"></i> <a href="${ctx}/res/homework/view/'+row.id+'">' + value;
        }

        function functionFormatter(value, row) {
            return  '<button id="btnListScore" onclick="onBtnListScore('+ row.id +  ');" type="button" class="btn btn-success btn-flat"><span class="fa fa-save"></span>查看成绩</button>' + "&nbsp;&nbsp;&nbsp;"+
                    '<button id="btnAddHomeWork" onclick="onBtnAddHomeWork('+ row.id +  ');" type="button" class="btn btn-success btn-flat"><span class="fa fa-save"></span>上传作业</button>'
                  ;
           // return  '<i class="fa fa-file-o"></i> <a href="${ctx}/res/homework/view/'+row.id+'">' + value;
        }

    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            课程作业
            <small>作业列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">作业列表</li>
        </ol>
    </section>
    <section class="content">
        <table id="homeworkList">
            <thead>
            <tr>

                <th data-field="name" data-align="center" data-formatter="nameFormatter">作业名称</th>
                <th data-field="coursename" data-align="center">课程名称</th>
                <th data-field="categoryname" data-align="center">课程分类</th>
                <th data-field="description" data-align="center">作业描述</th>
                <th data-field="function" data-align="center" data-formatter="functionFormatter">操作</th>
            </tr>
            </thead>
        </table>
    </section>
</aside>
</body>
</html>
