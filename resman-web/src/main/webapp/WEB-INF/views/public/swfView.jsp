<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html >
<html>
<head>
    <title>附件查看</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/asset/js/plugins/FlexPaper/css/flexpaper.css"/>
    <script type="text/javascript" src="${ctx}/asset/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="${ctx}/asset/js/plugins/FlexPaper/js/flexpaper.js"></script>
    <script type="text/javascript" src="${ctx}/asset/js/plugins/FlexPaper/js/flexpaper_handlers.js"></script>
</head>
<body>
<div id="documentViewer" class="flexpaper_viewer"></div>

<script type="text/javascript">
    $('#documentViewer').FlexPaperViewer({
        config: {
            SwfFile: '${ctx}/res/document/swfView?uuid=${uuid}',
            EncodeURI: true,
            Scale: 1,
            ZoomTransition: 'easeOut',
            ZoomTime: 0.5,
            ZoomInterval: 0.2,
            FitPageOnLoad: true,
            FitWidthOnLoad: true,
            FullScreenAsMaxWindow: false,
            ProgressiveLoading: true,
            MinZoomSize: 0.2,
            MaxZoomSize: 5,
            SearchMatchAll: false,
            InitViewMode: 'Portrait',

            ViewModeToolsVisible: true,
            ZoomToolsVisible: true,
            NavToolsVisible: true,
            CursorToolsVisible: true,
            SearchToolsVisible: true,

            WMode : 'window',
            localeChain: 'zh_CN'
        }
    });
</script>

</body>
</html>



















