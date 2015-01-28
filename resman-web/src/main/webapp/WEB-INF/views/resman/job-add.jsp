<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>添加作业</title>
    <link href="${ctx}/asset/js/plugins/datepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet"
          media="screen">
    <link href="${ctx}/asset/css/jNotify.jquery.css" rel="stylesheet"/>

    <script src="${ctx}/asset/js/plugins/datepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${ctx}/asset/js/plugins/datepicker/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="${ctx}/asset/js/plugins/iCheck/icheck.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctx}/asset/js/common.js"></script>
    <script src="${ctx}/asset/js/plugins/ueditor/ueditor.config.js"></script>
    <script src="${ctx}/asset/js/plugins/ueditor/ueditor.all.min.js"></script>
    <script src="${ctx}/asset/js/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script src="${ctx}/asset/js/jNotify.jquery.min.js"></script>
    <script>
        function addValidator() {
            $("#jobForm").validate({
                rules: {
                    "name": {
                        required: true,
                        minlength: 2,
                        maxlength: 20
                    }
                }
            });
        }

        function bindSubmit() {
            $("#btnSubmit").on("click", function () {
                if ($("#jobForm").valid()) {
                    $.post('/res/course/save', $('#jobForm').serializeJson(), function (data) {
                        if (data.success) {
                            tipSuccess("操作成功");
                            window.location.href = "/res/course/list?pid=${pid}";
                        } else {
                            tipError("操作失败");
                        }
                    });
                }
            });
        }
        $(document).ready(function () {
            bindSubmit();
            addValidator();
        });
    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            课程列表
            <small>添加作业</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/res/course/list"><i class="fa fa-dashboard"></i> 课程列表</a></li>
            <li class="active">添加作业</li>
        </ol>
    </section>
    <section class="content">
        <form class="form-horizontal" role="form" method="post" id="jobForm">
            <input type="hidden" name="parent" value="${pid}"/>
            <input type="hidden" name="ntype" value="1"/>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="name">名称</label>
                <div class="col-sm-4">
                    <input id="name" class="form-control" name="name"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="description">备注</label>
                <div class="col-sm-4">
                    <input id="description" class="form-control" name="description"/>
                </div>
            </div>
            <div style="margin-top:30px;margin-left: 160px">
                <button id="btnSubmit" type="button" class="btn btn-success btn-flat"><span class="fa fa-save"></span>
                    保存
                </button>
                <button type="button" class="btn btn-success btn-flat" style="margin-left: 30px"
                        onclick="goBack()"><span
                        class="fa fa-undo"></span> 返回
                </button>
            </div>
        </form>
    </section>
</aside>
</body>
</html>
