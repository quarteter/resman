<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <title>作业列表</title>
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
  <script>
    function bindToolBtnEvent(){
      $("#btnAdd").on("click", function (e) {
        window.location.href = "${ctx}/res/hw/add"
      });
      $("#btnEdit").on("click", function (e) {
        var sel = $("#hwList").bootstrapTable('getSelections');
        if (sel.length > 0) {
          var id = sel[0].id;
          window.location.href = "${ctx}/res/hw/edit?id=" + id;
        }
      });

      $("#btnDel").on("click", function (e) {
        var sel = $("#hwList").bootstrapTable('getSelections');
        if (sel.length > 0) {
//          var ids = "";
          var ids = new Array();
          for (var i = 0; i < sel.length; i++) {
//            ids = ids + sel[i].id + ",";
            ids.push(sel[i].id);
          }
          $.post("${ctx}/res/hw/del", {
            ids: ids
          }, function (data) {
            if (data.success) {
              window.location.href = "${ctx}/res/hw/list"
            } else {
              alert("删除数据失败！");
            }
          });
        }
      });

      $("#btnViewCommit").on("click",function(e){
        var sel = $("#hwList").bootstrapTable('getSelections');
        if (sel.length > 0) {
          var id = sel[0].id;
          window.location.href = "${ctx}/res/hw/records/" + id;
        }
      });
    }

    $(document).ready(function () {
      $("#hwList").createBootstrapTable({
        url: "${ctx}/res/hw/query",
        cudBtn: true,
        btns: [{id: "btnViewCommit", name: "提交的作业", iconCls: "fa fa-user", rowSelectAware: true}]
      });
      bindToolBtnEvent();
    });
  </script>
</head>
<body>
<aside class="right-side">
  <section class="content-header">
    <h1>
      作业管理
      <small>作业列表</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
      <li class="active">作业列表</li>
    </ol>
  </section>
  <section class="content">
    <table id="hwList">
      <thead>
      <tr>
        <th data-checkbox="true"></th>
        <th data-field="name" data-align="center">名 称</th>
        <th data-field="classNo" data-formatter="sexFormatter" data-align="center">作业班级</th>
        <th data-field="dateFrom" data-align="center">开始日期</th>
        <%--<th data-field="email" data-align="right">电子邮件</th>--%>
        <th data-field="dateTo" data-align="center">结束日期</th>
        <th data-field="notes" data-align="center">备 注</th>
      </tr>
      </thead>
    </table>
  </section>
</aside>
</body>
</html>
