<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>成绩列表</title>
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
    <script src="${ctx}/asset/js/plugins/validate/jquery.validate.min.js"></script>
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
        function nameFormatter(value,row){
            return row.user.name;
        }
        $(function () {
            $('#scoreList').bootstrapTable({
                url: '${ctx}/res/homework/listScore/query',
                queryParams: function (params) {
                    params.homeworkID = '${homeworkID}';
                    return params;
                },
                search: false,
                showRefresh: true,
                showColumns: true,
             //   toolbar: '#tb-score',
                clickToSelect: true,
                pagination: true,
                sidePagination: "server"
            });
        });


    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            课程作业
            <small>成绩列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li><a href="${ctx}/res/homework/list"><i class="fa fa-dashboard"></i>作业列表</a></li>
            <li class="active">成绩列表</li>
        </ol>
    </section>
    <section class="content">
        <table id="scoreList">
            <thead>
            <tr>
                <th data-field="user.nane" data-formatter="nameFormatter" data-align="left">名称</th>
                <th data-field="score" data-align="center">成绩</th>
            </tr>
            </thead>
        </table>
    </section>
    <!--
    <div id="tb-score">
        <button id="btnEdit" type="button" class="btn btn-default"><span class="fa fa-edit"></span>&nbsp;修改成绩
        </button>
    </div>
    -->
</aside>
</body>
</html>
