<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>成绩</title>
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


    <script id="job-dlg" type="text/x-jsrender">
        <form class="form-horizontal" role="form" id="scoreForm">
            <input type="hidden" name="id" value="{{:id}}"/>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="score">成绩</label>
                <div class="col-sm-6">
                    <input id="score" class="form-control" name="score"/>
                </div>
            </div>
        </form>

    </script>

    <script>
        $(function () {
            $('#scoreList').bootstrapTable({
                url: '${ctx}/res/score/query',
                queryParams: function (params) {
                    params.courseId = '${courseId}';
                    return params;
                },
                search: false,
                showRefresh: true,
                showColumns: true,
                toolbar: '#tb-score',
                clickToSelect: true ,
                pagination:true,
                sidePagination:"server"
            });

            $("#scoreForm").validate({
                rules: {
                    "score": {
                        required: true
                    }
                }
            });

            $('#btnEdit').on('click', function () {
                var sel = $("#scoreList").bootstrapTable('getSelections');
                if (sel.length > 0) {
                    BootstrapDialog.show({
                        title: "输入成绩",
                        nl2br: false,
                        message: function () {
                            var tpl = $.templates("#job-dlg");
                            return tpl.render({id: sel[0].id});
                        },
                        buttons: [
                            {
                                label: '确定',
                                cssClass: 'btn-primary btn-flat',
                                action: function (dialog) {
                                    $.post('${ctx}/res/score/saveScore', $('#scoreForm').serializeJson(), function (data) {
                                        if (data.success) {
                                            dialog.close();
                                            $('#scoreList').bootstrapTable('refresh');
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
                }
            });

        });


    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            我的课程
            <small>作业列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/res/course/list"><i class="fa fa-dashboard"></i> 课程列表</a></li>
            <li class="active">我的作业</li>
        </ol>
    </section>
    <section class="content">
        <table id="scoreList">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="name" data-align="left">名称</th>
                <th data-field="score" data-align="center">成绩</th>
            </tr>
            </thead>
        </table>
    </section>
    <div id="tb-score">
        <button id="btnEdit" type="button" class="btn btn-default"><span class="fa fa-edit"></span>&nbsp;修改成绩
        </button>
    </div>

</aside>
</body>
</html>
