<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>${title}</title>
    <link href="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.css" rel="stylesheet">
    <link href="${ctx}/asset/css/jNotify.jquery.css" rel="stylesheet"/>
    <link href="${ctx}/asset/js/plugins/multiselect/css/multi-select.css" rel="stylesheet">
    <link href="${ctx}/asset/js/plugins/bsdialog/bootstrap-dialog.min.css" rel="stylesheet">
    <link href="${ctx}/asset/js/plugins/uploadify/uploadify.css" rel="stylesheet"/>
    <link href="${ctx}/asset/js/plugins/zTree/css/zTreeStyle.css" rel="stylesheet"/>

    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.js"></script>
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table-zh-CN.min.js"></script>
    <script src="${ctx}/asset/js/plugins/bsdialog/bootstrap-dialog.js"></script>
    <script src="${ctx}/asset/js/plugins/template/jsrender.min.js"></script>
    <script src="${ctx}/asset/js/plugins/multiselect/js/jquery.multi-select.js"></script>
    <script src="${ctx}/asset/js/jquery.quicksearch.js"></script>
    <script src="${ctx}/asset/js/jNotify.jquery.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx}/asset/js/plugins/uploadify/jquery.uploadify.js"></script>
    <script src="${ctx}/asset/js/plugins/zTree/jquery.ztree.all-3.5.min.js"></script>
    <script src="${ctx}/asset/js/plugins/cookie/jquery.cookie.js"></script>
    <script src="${ctx}/asset/js/common.js"></script>
    <script src="${ctx}/asset/js/file-manager.js"></script>
    <script id="view-dlg" type="text/x-jsrender">
        <iframe src="${ctx}/res/document/view?uuid={{:uuid}}" width="870px" height="500px" scrolling="auto"></iframe>
    </script>

    <script id="folder-dlg" type="text/x-jsrender">
        <form class="form-horizontal" role="form" id="folderForm" onsubmit="return false;">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="name">名称</label>

                <div class="col-sm-6">
                    <input id="name" class="form-control" name="name"/>
                </div>
            </div>
        </form>

    </script>
    <script>
        <%--var ctxPath = "${ctx}", func = "${func}", tabId = "#fileList",--%>
                <%--filePath = "${path}", fileMenuId = "#menu",mcDir="${funcDef.mcDir}";--%>
        var fmConf = {
            "ctxPath" : "${ctx}",
            "func" : "${func}",
            "tabId": "#fileList",
            "filePath": "${path}",
            "fileMenuId": "#menu",
            "mcDir": "${funcDef.mcDir}",
            "allowFileExts":"${funcDef.allowFileExts}"
        };
        $(document).ready(function () {
            $.fm.createFileTable();
            $.fm.createUploadMenu();
        });
        $(function(){
            if(window.fmConf.func=='classic'){
                $.fm.createUploadMenu('#btnCourseUpload','btn btn-primary','上传课件');
                if(window.fmConf.filePath==''){
                    setTimeout(function(){
                        $("#btnCourseUpload").uploadify('disable',true);
                    },1000);
                }else{
                    $("#btnCourse li").addClass("disabled");
                    $("#btnCourse li a").removeAttr("onclick");
                }
            }
        });
    </script>

</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            ${title}
        </h1>
        <ol class="breadcrumb">
            <c:forEach items="${items}" var="item">
                <li><a href="javascript:void(0)" onclick="$.fm.clickCrumbs('${item.path}')"></i>${item.title}</a></li>
            </c:forEach>
        </ol>
    </section>
    <section class="content">
        <table id="fileList">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="name" data-align="left" data-formatter="$.fm.nameFormatter">文件名</th>
                <th data-field="size" data-align="left">大小</th>
                <th data-field="modifyDate" data-align="left">修改日期</th>
            </tr>
            </thead>
        </table>
    </section>
    <div id="menu">
        <c:forEach items="${funcDef.menus}" var="menu">
            <c:choose>
                <c:when test="${menu.id=='btnUpload'}">
                    <div id="${menu.id}"></div>
                </c:when>
                <c:when test="${menu.type!=null && menu.type=='dropdown'}">
                    <c:if test="${fn:length(menu.children)>0}">
                        <div class="btn-group">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                <span class="${menu.iconCls}"></span>&nbsp;${menu.name}
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu" id="${menu.id}">
                            <c:forEach items="${menu.children}" var="child">
                                <li id="${child.id}"><a href="javascript:void(0)" onclick="$.fm.${child.action}()">
                                    <span class="${child.iconCls}"></span>&nbsp;${child.name}</a></li>
                            </c:forEach>
                            </ul>
                        </div>

                    </c:if>
                </c:when>
                <c:otherwise>
                    <button id="${menu.id}" type="button" <c:if test="${menu.action!=null && menu.action!=''}">onclick="$.fm.${menu.action}()"</c:if>
                            class="btn btn-default"><span class="${menu.iconCls}"></span>&nbsp;${menu.name}</button>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${not empty funcDef.moreMenus}">
            <div class="btn-group">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                    更多
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <c:forEach items="${funcDef.moreMenus}" var="moreMenu">
                        <li><a href="javascript:void(0)" onclick="$.fm.${moreMenu.action}()">${moreMenu.name}</a></li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
    </div>

    <div id="fileQueue"></div>
</aside>
</body>
</html>
