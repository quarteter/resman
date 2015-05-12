<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户数据导入</title>
    <script src="${ctx}/asset/js/common.js"></script>
</head>
<body>
<aside class="right-side">

    <section class="content-header">
        <h1>
            用户导入
            <small><a class="btn-link" href="${ctx}/sys/user/tempFile?type=student"> (学生数据模板)</a>
                <a class="btn-link" href="${ctx}/sys/user/tempFile?type=teacher"> (老师数据模板)</a></small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">用户导入</li>
        </ol>
    </section>
    <section class="content">
        <form class="form-horizontal" role="form" method="post" id="userForm" enctype="multipart/form-data">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="userType">用户类型</label>

                <div class="col-sm-4">
                    <select id="userType" name="userType" class="form-control">
                        <option value="Student" selected>学 生</option>
                        <option value="Teacher">老 师</option>
                    </select>
                </div>
            </div>
            <div class="form-group">

                <label for="file" class="col-sm-2 control-label">数据文件</label>

                <div class="col-sm-2">
                    <input type="file" id="file" name="file" accept="application/excel,
                                                    application/vnd.ms-excel,application/vnd.msexcel,
                                                    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>
                </div>
            </div>

            <div style="margin-top:30px;margin-left: 160px">
                <button id="btnSubmit" type="submit" class="btn btn-success btn-flat"><span class="fa fa-save"></span>
                    确定
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
