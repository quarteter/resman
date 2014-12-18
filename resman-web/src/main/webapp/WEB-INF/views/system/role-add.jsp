<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>添加角色</title>
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
            $("#roleForm").validate({
                rules: {
                    "name": {required: true, maxlength: 60},
                    "role": {
                        required: true,
                        remote: {
                            url:"${ctx}/sys/role/validate",
                            type:"POST",
                            dataType:"JSON",
                            data:{
                                role:function(){
                                    return $("#role").val();
                                }
                            }
                        },
                        maxlength: 60
                    },
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
            <small>添加角色</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">添加角色</li>
        </ol>
    </section>
    <section class="content">
        <form class="form-horizontal" role="form" method="post" id="roleForm">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="name">角色名称</label>

                <div class="col-sm-4">
                    <input id="name" class="form-control" name="name"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="role">角 色</label>

                <div class="col-sm-4">
                    <input id="role" class="form-control" name="role"/>
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
