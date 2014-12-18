<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title><sitemesh:write property='title'>首页</sitemesh:write></title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta charset="UTF-8">
    <link href="${ctx}/asset/css/bootstrap.css" rel="stylesheet" media="screen"/>
    <link href="${ctx}/asset/css/font-awesome.css" rel="stylesheet"/>
    <link href="${ctx}/asset/css/ionicons.css" rel="stylesheet"/>
    <link href="${ctx}/asset/css/AdminLTE.css" rel="stylesheet"/>

    <script src="${ctx}/asset/js/jquery-2.1.1.min.js"></script>
    <script src="${ctx}/asset/js/jquery-ui.min.js"></script>
    <script src="${ctx}/asset/js/bootstrap.js"></script>
    <script src="${ctx}/asset/js/plugins/cookie/jquery.cookie.js"></script>
    <script src="${ctx}/asset/js/app.js"></script>

    <sitemesh:write property='head'/>
</head>
<body class="skin-blue">
<%@include file="top.jsp" %>
<div class="wrapper row-offcanvas row-offcanvas-left">
    <%@include file="left.jsp" %>
    <sitemesh:write property="body"/>
</div>
</body>
</html>
