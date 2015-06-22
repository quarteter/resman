<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <title>修改作业设置</title>
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
      $("#hwForm").validate({
        rules: {
          "name": {
            required: true,
            minlength: 2,
            maxlength: 20
          },
          "classNo": {
            required: true,
            minlength: 2,
            maxlength: 20
          },
          "dateFrom": {
            required: true
          },
          "dateTo": {
            required: true
          }
        }
      });
    }
    function bindSubmit() {
      $("#btnSubmit").on("click", function () {
        var isValid = $("#hwForm").valid();
        if (isValid) {
          $("#hwForm").submit();
        }
      });
    }
    $(document).ready(function () {
      createDatePicker(".form_date", "date");
      //BindSysUserEvent();
      bindSubmit();
      addValidator();
    });
  </script>

</head>
<body>
<aside class="right-side">
  <section class="content-header">
    <h1>
      作业管理
      <small>修改作业设置</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li class="active">修改作业设置</li>
    </ol>
  </section>
  <section class="content">
    <form class="form-horizontal" role="form" method="post" id="hwForm" action="${ctx}/res/hw/add">
      <input type="hidden" id="id" name="id" value="${hw.id}"/>
      <div class="form-group">
        <label class="col-sm-2 control-label" for="name">名 称</label>

        <div class="col-sm-4">
          <input id="name" class="form-control" name="name" value="${hw.name}"/>
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-2 control-label">班 级</label>

        <div class="col-sm-4">
          <input id="classNo" class="form-control" name="classNo" value="${hw.classNo}"/>
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-2 control-label" for="dateFrom">开始日期</label>

        <div class="input-group date form_date col-md-4" data-date="" data-date-format="yyyy-mm-dd"
             data-link-field="dateFrom" data-link-format="yyyy-mm-dd"
             style="padding-left: 15px;padding-right: 15px;">
          <input id="dateFrom" name="dateFrom" class="form-control" value="<fmt:formatDate value="${hw.dateFrom}" pattern="yyyy-MM-dd"></fmt:formatDate>"/>
          <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>

      </div>

      <div class="form-group">
        <label class="col-sm-2 control-label" for="dateTo">结束日期</label>

        <div class="input-group date form_date col-md-4" data-date="" data-date-format="yyyy-mm-dd"
             data-link-field="dateTo" data-link-format="yyyy-mm-dd"
             style="padding-left: 15px;padding-right: 15px;">
          <input id="dateTo" name="dateTo" class="form-control" value="<fmt:formatDate value="${hw.dateTo}" pattern="yyyy-MM-dd"></fmt:formatDate>"/>
          <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>

      </div>

      <div class="form-group">
        <label class="col-sm-2 control-label">备 注</label>

        <div class="col-sm-4">
          <textarea id="notes" name="notes" rows="5" class="form-control">${hw.notes}</textarea>
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
