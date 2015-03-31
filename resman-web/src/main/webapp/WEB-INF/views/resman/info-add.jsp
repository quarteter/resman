<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>信息发布</title>
    <script src="${ctx}/asset/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctx}/asset/js/common.js"></script>
    <script src="${ctx}/asset/js/plugins/uploadify/jquery.uploadify.min.js"></script>
    <script src="${ctx}/asset/js/plugins/iCheck/icheck.min.js"></script>
    <script src="${ctx}/asset/js/plugins/ueditor/ueditor.config.js"></script>
    <script src="${ctx}/asset/js/plugins/ueditor/ueditor.all.min.js"></script>
    <script src="${ctx}/asset/js/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script>
        UE.getEditor('editor11');
        function addValidator() {
            $("#newsForm").validate({
                rules: {
                    "title": {
                        required: true,
                        minlength: 2,
                        maxlength: 20
                    },
                    "content": {
                        required: true
                    }
                }
            });
        }
        function bindSubmit() {
            $("#btnSubmit").on("click", function () {
                if ($("#newsForm").valid()) {
                    $("#newsForm").submit();
                }
            });
        }
        function bindCheckState(){
            $("#publish").on("ifChecked",function(){
                $("#stateTxt").text("【发布 】");
            });
            $("#publish").on("ifUnchecked",function(){
                $("#stateTxt").text("【不发布】");
            });
            $("#bannerNews").on("ifChecked",function(){
                $("#isBannerTxt").text("【 是 】");
            });
            $("#bannerNews").on("ifUnchecked",function(){
                $("#isBannerTxt").text("【 否 】");
            });
        }
        function createUploader(){
            $("#imgUploader").uploadify({
                height:34,
                width:54,
                fileObjName:'fileData',
                swf: '${ctx}/asset/js/plugins/uploadify/uploadify.swf',
                uploader: '${ctx}/info/imgUpload',
                buttonClass:"btn btn-default",
                buttonText:"上传",
                fileTypeExts:"*.bmp;*.gif;*.jpg;*.jpeg;*.png;",
                onInit:function(){
                    $("#imgUploader-button").css("line-height","");
                },
                onUploadSuccess:function(file,data,response){
                    var resp = eval("("+data+")");
                    if(resp.success){
                        $("#imgPath").val(resp.msg);
                    }
                }
            });
        }
        $(document).ready(function () {
            bindCheckState();
            bindSubmit();
            addValidator();
            createUploader();
        });
    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            信息管理
            <small>信息发布</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">信息发布</li>
        </ol>
    </section>
    <section class="content">
        <form class="form-horizontal" role="form" method="post" id="newsForm" action="${ctx}/info/add">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="title">标题</label>

                <div class="col-sm-4">
                    <input id="title" class="form-control" name="title"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="type">栏目</label>

                <div class="col-sm-4">
                    <select id="type" class="form-control" name="type">
                        <c:forEach items="${infoType}" var="type">
                            <option value="${type.code}">${type.name}</option>
                        </c:forEach>
                        <%--<option value="news">新闻 </option>--%>
                        <%--<option value="knowledge">知识堂 </option>--%>
                        <%--<option value="skillContest">技能大赛 </option>--%>
                        <%--<option value="teacherGroup">师资队伍</option>--%>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="publish">状态</label>

                <div class="col-sm-4">
                    <%--<input id="state" class="form-control" name="title"/>--%>
                    <div class="checkbox">
                        <label style="padding-left: 0"><input id="publish" name="publish" type="checkbox"/>&nbsp;&nbsp;<span id="stateTxt">【未发布】</span></label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="bannerNews">横幅新闻</label>

                <div class="col-sm-4">
                    <%--<input id="state" class="form-control" name="title"/>--%>
                    <div class="checkbox">
                        <label style="padding-left: 0"><input id="bannerNews" name="bannerNews" type="checkbox"/>&nbsp;&nbsp;<span id="isBannerTxt">【 否 】</span></label>
                    </div>
                </div>
            </div>
            <div class="from-group">
                <label class="col-sm-2 control-label" for="imgPath">图片</label>
                <div class="col-sm-4 input-group">
                    <input id="imgPath" name="imgPath" type="text" class="form-control" style="margin-left: 5px" readonly/>
                        <span class="input-group-btn">
                            <button id="imgUploader" class="btn btn-default" type="button">上传</button>
                        </span>
                </div>
            </div>
            <div class="form-group" style="margin-top: 10px">
                <label class="col-sm-2 control-label" for="editor11">内容</label>

                <div class="col-sm-8">
                    <script id="editor11" name="content" style="height: 350px;" type="text/plain"></script>
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
