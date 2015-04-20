<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>添加编码</title>
    <link href="${ctx}/asset/js/plugins/datepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet"
          media="screen">
    <script src="${ctx}/asset/js/plugins/iCheck/icheck.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctx}/asset/js/common.js"></script>
    <script>
        function addValidator(){
            $("#codeForm").validate({
                rules: {
                    "category": {
                        required:true,
                        minlength:2,
                        maxlength:32
                    },
                    "code": {
                        required: true,
                        minlength:2,
                        maxlength:32
                    },
                    "name":{
                        required:true,
                        minlength:2,
                        maxlength:32
                    },
                    "seqNo":{
                        required:true,
                        digits: true
                    }
                }
            });
        }

        function bindSubmit(){
            $("#btnSubmit").on("click", function () {
                var isValid = $("#codeForm").valid();
                if (isValid) {
                    $("#codeForm").submit();
                }
            });
        }

        $(document).ready(function(){
            addValidator();
            bindSubmit();
        });

    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            系统管理
            <small>添加编码</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">添加编码</li>
        </ol>
    </section>
    <section class="content">
        <form class="form-horizontal" role="form" method="post" id="codeForm" action="${ctx}/sys/code/add">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="category">分 类</label>

                <div class="col-sm-4">
                    <input id="category" class="form-control" name="category"/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">编 码</label>

                <div class="col-sm-4">
                    <input id="code" class="form-control" name="code"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">名 称</label>

                <div class="col-sm-4">
                    <input id="name" class="form-control" name="name"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">序 号</label>

                <div class="col-sm-4">
                    <input id="seqNo" class="form-control" name="seqNo"/>
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
