<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<header class="header">
  <a href="${ctx}/main" class="logo">
    云终端安全管理系统
  </a>
  <!-- Header Navbar: style can be found in header.less -->
  <nav class="navbar navbar-static-top" role="navigation">
    <!-- Sidebar toggle button-->
    <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </a>

    <div class="navbar-right">
      <ul class="nav navbar-nav">
        <!-- User Account: style can be found in dropdown.less -->
        <li class="dropdown user user-menu">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <i class="glyphicon glyphicon-user"></i>
            <span><shiro:principal property="userName"/><i class="caret"></i></span>
          </a>
          <ul class="dropdown-menu">
            <!-- User image -->
            <li class="user-header bg-light-blue">
              <img src="${ctx}/asset/img/avatar3.png" class="img-circle" alt="User Image"/>

              <p>
                  <shiro:principal property="userName"/> - 管理员
                <c:set value="<%= new Date()%>" var="now"></c:set>
                <small><fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/></small>
              </p>
            </li>
            <!-- Menu Footer-->
            <li class="user-footer">

              <div class="text-center">
                <a href="${ctx}/logout" class="btn btn-default btn-flat">退 出</a>
              </div>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </nav>
</header>
