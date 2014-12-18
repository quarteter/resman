<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>添加权限</title>
    <link href="${ctx}/asset/js/plugins/datepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet"
          media="screen">
    <script src="${ctx}/asset/js/plugins/datepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${ctx}/asset/js/plugins/datepicker/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="${ctx}/asset/js/plugins/iCheck/icheck.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctx}/asset/js/common.js"></script>
    <script>
        function addValidator() {
            $("#permForm").validate({
                rules: {
                    "name": "required",
                    "resource": {required: true},
                    "permission": {required: true},
                    "notes": {maxlength: 100}
                }
            });
        }
        $(document).ready(function () {
            addValidator();
        });
    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            权限管理
            <small>添加权限</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">添加权限</li>
        </ol>
    </section>
    <section class="content">
        <form class="form-horizontal" role="form" method="post" id="permForm">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="name">权限名</label>

                <div class="col-sm-4">
                    <input id="name" class="form-control" name="name"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="resource">资源标识</label>

                <div class="col-sm-4">
                    <input id="resource" class="form-control" name="resource"/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label" for="permission">权限标识</label>

                <div class="col-sm-4">
                    <input id="permission" class="form-control" name="permission"/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label" for="notes">备 注</label>

                <div class="col-sm-4">
                    <textarea id="notes" name="notes" class="form-control" rows="3"></textarea>
                </div>
            </div>


            <div style="margin-top:30px;margin-left: 160px">
                <button id="btnSubmit" type="submit" class="btn btn-success btn-flat"><span class="fa fa-save"></span>
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
