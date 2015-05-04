<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>添加课程</title>
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
        var ue = UE.getEditor('description');
        function addValidator() {
            $("#courseForm").validate({
                rules: {
                    "name": {
                        required: true,
                        minlength: 2,
                        maxlength: 40
                    },
                    "teacher": {required: true},
                    "brief":{required:true}
                }
            });
        }

        function bindSubmit() {
            $("#btnSubmit").on("click", function () {
                if ($("#courseForm").valid()) {
                    $.post('${ctx}/res/course/addDocCourse', $('#courseForm').serializeJson(), function (data) {
                        if (data.success) {
                            tipSuccess("操作成功");
                            window.location.href = "${ctx}/res/common/classic/list";
                        } else {
                            tipError("操作失败");
                        }
                    });
                }
            });
        }
        $(document).ready(function () {
            addValidator();
            bindSubmit();
        });
    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            课程列表
            <small>添加课程</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">添加课程</li>
        </ol>
    </section>
    <section class="content">
        <form class="form-horizontal" role="form" method="post" id="courseForm">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="name">名 称</label>

                <div class="col-sm-6">
                    <input id="name" class="form-control" name="name"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="teacher">授课老师</label>

                <div class="col-sm-6">
                    <input id="teacher" class="form-control" name="teacher"/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label" for="brief">课程简介</label>

                <div class="col-sm-6">
                    <textarea id="brief" class="form-control" name="brief" rows="5"></textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label" for="description">备 注</label>

                <div class="col-sm-6">
                    <script id="description" name="description" style="height: 250px;" type="text/plain"></script>
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
