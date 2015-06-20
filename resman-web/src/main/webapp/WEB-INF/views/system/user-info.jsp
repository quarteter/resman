<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <title>用户信息</title>
  <link href="${ctx}/asset/js/plugins/datepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet"
        media="screen">
  <script src="${ctx}/asset/js/plugins/datepicker/js/bootstrap-datetimepicker.min.js"></script>
  <script src="${ctx}/asset/js/plugins/datepicker/js/bootstrap-datetimepicker.zh-CN.js"></script>
  <script src="${ctx}/asset/js/plugins/iCheck/icheck.min.js"></script>
  <script src="${ctx}/asset/js/plugins/validate/jquery.validate.min.js"></script>
  <script src="${ctx}/asset/js/plugins/validate/messages_zh.min.js"></script>
  <script src="${ctx}/asset/js/common.js"></script>
</head>
<body>

<aside class="right-side">

  <section class="content">
    <form class="form-horizontal" role="form" method="post" action="${ctx}/sys/user/add" id="userForm">
      <div class="form-group">
        <label class="col-sm-2 control-label" for="name">姓 名</label>

        <div class="col-sm-4">
          <input id="name" class="form-control" name="name" value="${user.name}"/>
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-2 control-label" for="name">院 系</label>

        <div class="col-sm-4">
          <input id="college" class="form-control" name="name" value="${user.college}"/>
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-2 control-label" for="name">专 业</label>

        <div class="col-sm-4">
          <input id="major" class="form-control" name="name" value="${user.major}"/>
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-2 control-label" for="name">职 称</label>

        <div class="col-sm-4">
          <input id="title" class="form-control" name="name" value="${user.title}"/>
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-2 control-label" for="phoneNum">手机号</label>

        <div class="col-sm-4">
          <input id="phoneNum" class="form-control" name="phoneNum" value="${user.phoneNum}"/>
        </div>

      </div>

      <%--<div style="margin-top:30px;margin-left: 160px">--%>
        <%--<button id="btnSubmit" type="button" class="btn btn-success btn-flat"><span class="fa fa-save"></span>--%>
          <%--保存--%>
        <%--</button>--%>
        <%--<button type="button" class="btn btn-success btn-flat" style="margin-left: 30px" onclick="goBack()"><span--%>
                <%--class="fa fa-undo"></span> 返回--%>
        <%--</button>--%>
      <%--</div>--%>
    </form>
  </section>
</aside>

</body>
</html>
