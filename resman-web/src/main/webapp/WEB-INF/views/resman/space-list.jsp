<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>我的空间</title>
    <link href="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.css" rel="stylesheet">
    <link href="${ctx}/asset/css/jNotify.jquery.css" rel="stylesheet"/>
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
        $(function () {
            $('#spaceList').bootstrapTable({
                url: '${ctx}/res/space/query',
                search: true,
                showRefresh: true,
                showColumns: true,
                toolbar: '#tb-space',
                clickToSelect: true
            });
        });

        function nameFormatter(value, row) {
            if (row.type == '0') {
                return  '<i class="fa fa-folder"></i> ' + value;
            } else {
                return '<i class="fa fa-file-pdf-o"></i> ' + value;
            }
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
        <button id="btnUpload" type="button" class="btn btn-primary"><span class="fa fa-upload"></span>&nbsp;上传文件
        </button>
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
</aside>
</body>
</html>
