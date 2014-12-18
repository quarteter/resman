<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>添加用户</title>
    <link href="${ctx}/asset/js/plugins/datepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet"
          media="screen">
    <script src="${ctx}/asset/js/plugins/datepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${ctx}/asset/js/plugins/datepicker/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="${ctx}/asset/js/plugins/iCheck/icheck.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctx}/asset/js/common.js"></script>
    <script>
        function isSysUser(){
            var checked = $("#isSysUser").parent().attr("aria-checked");
            return checked=="true";
        }
        function addValidator() {
            $("#userForm").validate({
                rules: {
                    "name": "required",
                    "email": {
                        required: true,
                        email: true
                    },
                    "sysUserName":{
                        required:{depends:isSysUser},
                        minlength:6,
                        maxlength:32
                    },
                    "sysUserPwd":{
                        required:{depends:isSysUser},
                        minlength:6,
                        maxlength:32
                    }
                }
            });
        }

        function bindSubmit() {
            $("#btnSubmit").on("click", function () {
                var isValid = $("#userForm").valid();
                if (isValid) {
                    var sysUserName = $("#sysUserName").val();
                    if (sysUserName != null && sysUserName.length > 0) {
                        $.post("${ctx}/sys/user/check", {
                            sysName: sysUserName
                        }, function (data) {
                            if (data.success && data.msg == 'true') {
                                alert("系统中该用户名已经注册！");
                            } else if (data.success && data.msg == 'false') {
                                $("#userForm").submit();
                            }
                        });
                    } else {
                        $("#userForm").submit();
                    }
                }
            });
        }
        function BindSysUserEvent() {
            $("input[type='checkbox']").on("ifChecked", function () {
                $("#sysUserNameDiv").removeClass("hide");
                $("#sysUserPwdDiv").removeClass("hide");
                $("#sysUserName").val("");
                $("#sysUserPwd").val("");
            });
            $("input[type='checkbox']").on("ifUnchecked", function () {
                $("#sysUserNameDiv").addClass("hide");
                $("#sysUserPwdDiv").addClass("hide");
                $("#sysUserName").val("");
                $("#sysUserPwd").val("");
            });
        }
        $(document).ready(function () {
            createDatePicker(".form_date", "date");
            BindSysUserEvent();
            bindSubmit();
            addValidator();
        });
    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            用户管理
            <small>添加用户</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">添加用户</li>
        </ol>
    </section>
    <section class="content">
        <form class="form-horizontal" role="form" method="post" id="userForm">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="name">姓 名</label>

                <div class="col-sm-4">
                    <input id="name" class="form-control" name="name"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="email">邮 件</label>

                <div class="col-sm-4">
                    <input id="email" class="form-control" name="email"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">性 别</label>
                <div class="radio">
                    <label>
                        <input type="radio" name="sex" id="femaleRadio" value="Female"> 女
                    </label>
                    <label>
                        <input type="radio" name="sex" id="maleRadio" value="Male" checked> 男
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="bod">出生日期</label>
                <%--<div class="input-group date form_date col-sm-4">--%>
                <%--<input id="bod" class="form-control" name="bod" type="text"/>--%>
                <%--</div>--%>
                <div class="input-group date form_date col-md-4" data-date="" data-date-format="yyyy-mm-dd"
                     data-link-field="bod" data-link-format="yyyy-mm-dd"
                     style="padding-left: 15px;padding-right: 15px;">
                    <input class="form-control" size="16" type="text" value="">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                <input type="hidden" id="bod" name="bod" value=""/>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="phoneNum">手机号</label>

                <div class="col-sm-4">
                    <input id="phoneNum" class="form-control" name="phoneNum"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <div class="checkbox">
                        <label>
                            <input id="isSysUser" type="checkbox"> 系统用户
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group hide" id="sysUserNameDiv">
                <label class="col-sm-2 control-label" for="sysUserName">用户名</label>

                <div class="col-sm-4">
                    <input id="sysUserName" class="form-control" name="sysUserName"/>
                </div>
            </div>

            <div class="form-group hide" id="sysUserPwdDiv">
                <label class="col-sm-2 control-label" for="sysUserPwd">密 码</label>

                <div class="col-sm-4">
                    <input id="sysUserPwd" class="form-control" name="sysUserPwd" type="password"/>
                </div>
            </div>
            <div style="margin-top:30px;margin-left: 160px">
                <button id="btnSubmit" type="button" class="btn btn-success btn-flat"><span class="fa fa-save"></span>
                    保存
                </button>
                <button type="button" class="btn btn-success btn-flat" style="margin-left: 30px" onclick="goBack()"><span
                        class="fa fa-undo"></span> 返回
                </button>
            </div>
        </form>
    </section>
</aside>
</body>
</html>
