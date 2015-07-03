<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>作业提交列表</title>
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
    <style>
        .score-dialog .modal-dialog {
            width: 300px;
        }
    </style>
    <script id="view-dlg" type="text/x-jsrender">
        <iframe src="${ctx}/res/document/view?uuid={{:uuid}}" width="870px" height="500px" scrolling="auto"></iframe>
    </script>
    <script>

        function hwRecordOp(value, row){
            var uuid = row.docUid;
            var action = "<a href='#' onclick='downloadFile(\""+uuid+"\");'>下载</a>&nbsp;&nbsp;" +
                    "<a href='javascipt:void(0)' onclick='viewFile(\""+uuid+ "\");'>查看</a>&nbsp;&nbsp;" +
                    "<a href='javascipt:void(0)' onclick='score(event,\""+row.id+"\")'>评分</a>"
            return action;
        }

        function downloadFile(uuid){
            var href = "${ctx}/res/document/download?uuid="+uuid;
            window.location.href = href;
        }

        function viewFile(uuid){
            BootstrapDialog.show({
                size: BootstrapDialog.SIZE_WIDE,
                title: name,
                message: function () {
                    var tpl = $.templates("#view-dlg");
                    return tpl.render({uuid:uuid});
                }
            });
        }

        function score(event,id){
            BootstrapDialog.show({
                title: '请设置分数',
                cssClass: 'score-dialog',
                message: $('<input class="form-control" id="score" name="score" />'),
                buttons: [{
                    label: '确定',
                    cssClass: 'btn-primary',
                    action: function(dialog) {
                        var score = $("#score").val();
                        if(score && $.isNumeric(score)){
                            $.post("${ctx}/res/hw/record/score",{
                                id:id,score:score
                            },function(data){
                                var t = event.target;
                                $(t).parent().prev().html(score);
                                dialog.close();
                            });
                        }
                    }
                }]
            });
        }

        $(document).ready(function(){
            $("#hwRecordList").createBootstrapTable({
                url: "${ctx}/res/hw/records/query/${hkId}",
                cudBtn: false,
                pagination:false
            });
        });
    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            作业管理
            <small>作业提交列表</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">作业提交列表</li>
        </ol>
    </section>
    <section class="content">
        <table id="hwRecordList">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="submitter" data-align="center">提交人</th>
                <th data-field="submitDate" data-align="center">提交时间</th>
                <th data-field="fileName" data-align="center">文件名称</th>
                <th data-field="score" data-align="center">作业分数</th>
                <th data-field="" data-align="center" data-formatter="hwRecordOp">操 作</th>
            </tr>
            </thead>
        </table>
    </section>
</aside>
</body>
</html>
