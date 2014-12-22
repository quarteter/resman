<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="menu" uri="http://org.arcie.ctsm"%>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<aside class="left-side sidebar-offcanvas">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="${ctx}/asset/img/avatar3.png" class="img-circle" alt="User Image"/>
            </div>
            <div class="pull-left info">
                <p>你好, <shiro:principal property="userName"/></p>

                <a href="#"><i class="fa fa-circle text-success"></i> 在线</a>
            </div>
        </div>

        <menu:menu></menu:menu>

        <%--<ul class="sidebar-menu">--%>
            <%--<li class="active">--%>
                <%--<a href="${ctx}/index">--%>
                    <%--<i class="fa fa-dashboard"></i> <span>Dashboard</span>--%>
                <%--</a>--%>
            <%--</li>--%>
            <%--<li class="treeview active">--%>
                <%--<a href="#">--%>
                    <%--<i class="fa fa-bar-chart-o"></i>--%>
                    <%--<span>设备管理</span>--%>
                    <%--<i class="fa fa-angle-left pull-right"></i>--%>
                <%--</a>--%>
                <%--<ul class="treeview-menu">--%>
                    <%--<li><a href="${ctx}/store/list"><i class="fa fa-angle-double-right"></i> 设备查询</a></li>--%>
                    <%--<li><a href="${ctx}/question/list"><i class="fa fa-angle-double-right"></i> 接入控制</a></li>--%>
                    <%--<li><a href="${ctx}/question/list"><i class="fa fa-angle-double-right"></i> 设备组管理</a></li>--%>
                    <%--<li><a href="${ctx}/question/list"><i class="fa fa-angle-double-right"></i> 策略管理</a></li>--%>
                    <%--<li><a href="${ctx}/question/indexedList"><i class="fa fa-angle-double-right"></i> 状态监控</a></li>--%>
                <%--</ul>--%>
            <%--</li>--%>

        <%--</ul>--%>
    </section>
    <!-- /.sidebar -->
</aside>
