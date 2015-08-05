<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="func" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>问答列表</title>
    <link href="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.css" rel="stylesheet">
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table.min.js"></script>
    <script src="${ctx}/asset/js/plugins/boottable/bootstrap-table-zh-CN.min.js"></script>
    <script src="${ctx}/asset/js/plugins/bspaginator/bootstrap-paginator.min.js"></script>
    <script src="${ctx}/asset/js/plugins/ueditor/ueditor.config.js"></script>
    <script src="${ctx}/asset/js/plugins/ueditor/ueditor.all.min.js"></script>
    <script src="${ctx}/asset/js/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx}/asset/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctx}/asset/js/common.js"></script>

    <script>

        var ue = UE.getEditor('editor11');

        function isnull(_val) {
            if (_val == null || _val == undefined || _val == "")
                return true;
            return false;
        }

        function checkForm()
        {
            var content = ue.getContent();
            if( isnull(content) )
            {
                alert("回复内容不能为空！");
                return false;
            }
            return true;
        }

        function bindSubmit() {
            $("#btnSubmit").on("click", function () {
                if ( checkForm() ) {
                    $("#questionForm").submit();
                }
            });
        }

        function createPaginator() {
            var option = {
                bootstrapMajorVersion: 3,
                currentPage: ${curPage+1},
                totalPages: ${totalPages},
                numberOfPages: 20,
                alignment: "center",
                pageUrl: function (type, page, current) {
                    var p = page - 1;
                    return "${ctx}" + "/res/question/teacher/view/${question.id}?page=" + p;
                }
            };
            $("#paginator").bootstrapPaginator(option);
        }

        function deleteAnswer(aid) {
          //  if (window.confirm("您确定要删除该问答回复吗?")) {
                $.post("${ctx}/res/question/deleteAnswer", {aid: aid}, function (data) {
                    if (data.success) {
                        window.location = window.location;
                    } else {
                        alert("删除问答回复后台错误!")
                    }
                });
           // }
        }

        $(document).ready(function () {
            //$("#newsTable").bootstrapTable();
            bindSubmit();
               createPaginator();
        });
    </script>
</head>
<body>
<aside class="right-side">
    <section class="content-header">
        <h1>
            问答管理
            <small>问答详情</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="${ctx}/main"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li class="active">问答详情</li>
        </ol>
    </section>
    <section class="content" style="min-height: 300px">
       <!--
        <div class="row" style="margin-top: 10px">
            <div class="col-md-10">
                标题：&nbsp;${question.title}<br>
                提问者：${question.username}<br>
                时间：&nbsp;【<fmt:formatDate value="${question.crtdate}" pattern="yyyy-MM-dd"></fmt:formatDate>】

                <br>内容：&nbsp;${question.content}</br>
            </div>
        </div>
        -->
        <div class="row" style="margin-top: 10px">
            <div class="col-md-1">
                标题：
            </div>
            <div class="col-md-8">
                ${question.title}
            </div>
        </div>
        <div class="row" style="margin-top: 10px">
            <div class="col-md-1">
                提问者：
            </div>
            <div class="col-md-8">
                ${question.username}
            </div>
        </div>
        <div class="row" style="margin-top: 10px">
            <div class="col-md-1">
                时间：
            </div>
            <div class="col-md-8">
                <fmt:formatDate value="${question.crtdate}" pattern="yyyy-MM-dd"></fmt:formatDate>
            </div>
        </div>

        <div class="row" style="margin-top: 10px">
            <div class="col-md-1">
               内容：
            </div>
            <div class="col-md-9">
                ${question.content}
            </div>
        </div>

        <div class="row" style="margin-top: 10px">
            <div class="col-md-10">
            </div>
        </div>

        <div class="row" style="margin-top: 10px">
            <div class="col-md-10">
                <c:choose>
                    <c:when test="${func:length(answer)>0}">
                        <ul class="list-group">
                            <c:forEach items="${answer}" var="n">
                                <li class="list-group-item">
                                    <span>【${n.crtuser.name}】【<fmt:formatDate value="${n.crtdate}" pattern="yyyy-MM-dd"></fmt:formatDate>】</span>
                                    <c:if test="${user == n.crtuser.id}">
                                        <a href="javascript:void(0)" onclick="deleteAnswer(${n.id});">[删除]</a>
                                        &nbsp;  &nbsp;
                                        <a href="${ctx}/res/question/updateAnswerPage?aid=${n.id}&page=${curPage}">[修改]</a>
                                    </c:if>
                                       <p>${n.content}</p>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <b><p>目前还没有回答信息!</p></b>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <ul id="paginator"></ul>

        <div class="row" style="margin-top: 10px">
            <form class="form-horizontal" role="form" method="post" id="questionForm" action="${ctx}/res/question/addAnswer">
                <div class="form-group" style="margin-top: 10px">
                    <label class="col-sm-1 control-label" for="editor11">内容</label>
                    <div class="col-sm-8">
                        <script id="editor11" name="content" style="height: 250px;" type="text/plain"></script>
                    </div>
                </div>
                <div style="margin-top:30px;margin-left: 160px">
                    <input type="hidden" id="qid" name="qid" value="${question.id}">
                    <input type="hidden" id="page" name="page" value="${curPage}">

                    <button id="btnSubmit" type="button" class="btn btn-success btn-flat"><span class="fa fa-save"></span>
                        回答问题
                    </button>
                    <button type="button" class="btn btn-success btn-flat" style="margin-left: 30px"
                            onclick="goBack()"><span
                            class="fa fa-undo"></span> 返回
                    </button>
                </div>
           </form>
       </div>

    </section>
</aside>

</body>
</html>
