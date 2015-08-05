<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>问题管理</title>
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

    <script>
        function bindToolBtnEvent() {



        }
        $(document).ready(function () {
            $("#questionList").createBootstrapTable({
                url: "${ctx}/res/question/teacher/queryMyAnswerList",
                cudBtn: false,
                btns: [

                ]
            });
            bindToolBtnEvent();
        });


        function nameFormatter(value, row) {
             return  ' <a href="${ctx}/res/question/teacher/view/'+row.id+'">' + value;
        }

    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            问题管理
            <small>我回答的问题</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">我回答的问题</li>
        </ol>
    </section>
    <section class="content">
        <table id="questionList">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="title" data-align="center" data-formatter="nameFormatter">标题</th>
                <th data-field="crtdate" data-align="center">发布时间</th>
            </tr>
            </thead>
        </table>
    </section>
</aside>
</body>
</html>
