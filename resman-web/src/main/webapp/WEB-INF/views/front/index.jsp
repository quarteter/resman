<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>北京市黄庄职业高中：：动漫与游戏专业</title>
<link href="/asset/css/css.css" rel="stylesheet" type="text/css" />

<script src="/asset/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script src="/asset/js/jquery.carouFredSel-6.0.4-packed.js" type="text/javascript"></script>
<script src="/asset/js/topanv.js" type="text/javascript" ></script>
<script language="JavaScript" type="text/javascript"> 
function ChangeDiv(divId,divName,zDivCount,obj) 
{ 
for(i=0;i<4;i++) 
{ 
document.getElementById(divName+i).style.display="none"; 
//将所有的层都隐藏 
} 
document.getElementById(divName+divId).style.display="block"; 
 

//显示当前层
var $len=document.getElementById("title").getElementsByTagName("li").length;
   for(j=0;j<$len;j++){
	 if(j==divId){
	 document.getElementById("title").getElementsByTagName("li")[j].style.background="images/bou_1.png";
	  document.getElementById("title").getElementsByTagName("li")[j].style.color="#ffffff"; 
	 }else{
	 document.getElementById("title").getElementsByTagName("li")[j].style.background="images/bou_1hover.png";
	  document.getElementById("title").getElementsByTagName("li")[j].style.color="#ffffff";
	 }
   }
}
$(document).ready(function(){
	$(".selecter li ul").hide();
	
			
}) 


</script>

	<script language="javascript">
  function switchmodTag(modtag,modcontent,modk) {
    for(i=1; i <4; i++) {
      if (i==modk) {
        document.getElementById(modtag+i).className="title_show";document.getElementById(modcontent+i).className="slidingList";}
      else {
        document.getElementById(modtag+i).className="menuNo";document.getElementById(modcontent+i).className="slidingList_none";}
    }
  }
</script>
 </head>

<body>
<div class="top">
</div>

<div class="header">
 <div class="logo"><img src="/asset/images/logo.jpg" width="222" height="65" /></div>
 <div class="nav">
 <ul>
<li><a href="/front/index" class="nav_show">网站首页</a></li>
<li><a href="/front/news">新闻动态</a></li>
<li><a href="/front/course">精品课程</a></li>
<li><a href="/front/resources/classic">资源库</a></li>
<li><a href="javascript:void(0)">成果展示</a></li>
<li><a href="/front/teachers">专家团队</a></li>
<li><a href="/front/works">师生作品</a></li>
 </ul>
  </div>
  </div>
 <div class="main_content">
  <div class="content_left">
    <div class="notice">
     <h1><span><a href="./notices">更多>></a></span>通知公告</h1>
         <ul>
             <c:forEach items="${notices_list}" var="n">
                 <a href="notices/${n.id}">${n.title} </a>
             </c:forEach>
          </ul>
    </div>
  <div class="login">
  <h1> <a href="#"><img src="/asset/images/login_01.jpg" width="240" height="137" /></a></h1>
   <ul>
    <li><a href="#" class="a1">个人中心</a></li>
    <li><a href="#" class="a2">我的资源</a></li>
    <li><a href="#" class="a3">个人资料</a></li>
    <li><a href="#" class="a4">我的课程</a></li>
    <li><a href="#" class="a5">作业管理</a></li>
    <li><a href="#" class="a6">退出登录</a></li>
        
        
<!--            <li><a href="#"><img src="images/ioc_1.png"   onmouseover="this.src='images/ioc_1hover.png'" onmouseout="this.src='images/ioc_1.png'"/>个人中心</a></li>
    <li><a href="#"><img src="images/ioc_2.png"   onmouseover="this.src='images/ioc_2hover.png'" onmouseout="this.src='images/ioc_2.png'"/>我的资源</a></li>
    <li><a href="#"><img src="images/ioc_3.png"   onmouseover="this.src='images/ioc_3hover.png'" onmouseout="this.src='images/ioc_3.png'"/>个人资料</a></li>
    <li><a href="#"><img src="images/ioc_4.png"   onmouseover="this.src='images/ioc_4hover.png'" onmouseout="this.src='images/ioc_4.png'"/>我的课程</a></li>
    <li><a href="#"><img src="images/ioc_5.png"   onmouseover="this.src='images/ioc_5hover.png'" onmouseout="this.src='images/ioc_5.png'"/>作业管理</a></li>
    <li><a href="#"><img src="images/ioc_6.png"   onmouseover="this.src='images/ioc_6hover.png'" onmouseout="this.src='images/ioc_6.png'"/>退出登录</a></li>  
-->    
   </ul>
  </div>
 <script type="text/javascript">
$(function () {
   $('.tab ul.menu li').click(function(){
        //获得当前被点击的元素索引值
        var Index = $(this).index();
		//给菜单添加选择样式
	    $(this).addClass('active').siblings().removeClass('active');
		//显示对应的div
		$('.tab').children('div').eq(Index).show().siblings('div').hide();
   });
});
</script>
  
  <div class="students tab">
    <h1>学生专区</h1>
  	<ul class="menu">
		<li class="active" style="margin:0;"><a href="javascript:void(0)">知识堂</a></li>
		<li><a href="javascript:void(0)">问答</a></li>
<!--		<li><a href="javascript:void(0)">交流</a></li> -->
   	  </ul>
  	<div class="con1">
    <!--知识堂-->
     <ul>
      <c:forEach items="${knowledge_list}" var="n" >
                    <li> <a href="news/${n.id}">${n.title}</a></li>
      </c:forEach>
    </ul>
    </div>
      	<div class="con2">
       <ul>
           <c:forEach items="${question_list}" var="n" >
               <li> <a href="news/${n.id}">${n.title}</a></li>
           </c:forEach>
      </ul>
    </div>

      <!--
  	<div class="con3">
    
        <ul>
     <li><a href="#">校财经商贸 "京西杯微课程大智慧——我校组织"微课基 </a></li>
     <li><a href="#">名师、传承人进课堂，助力黔西南中职 </a></li>
     <li><a href="#">服装专业召开"馆建设研讨会</a></li>
     <li><a href="#">我"技能大赛</a></li>
     <li><a href="#">微课程大智旗袍传习慧——我校组织"微课基础</a></li>
     <li><a href="#">微课程大智慧——我校组织"微课基 </a></li>
      </ul>

    
    </div>
    -->

<h2><img src="/asset/images/pic04.jpg" width="214" height="123" /></h2>
 
  </div>
  <div  class="link">
 
    		<div id="anvlfteb">
			<div selec="bbs" class="posbox"> <a href="#">友情链接</a></div>
		 
			<div id="seledbox" class="posiabox" style=" display:none;  "><div> 
  </div>
 </div>
		
        </div>
   
 </div>
   <div class="contact"><a href="#">联系方式</a></div> 
  <div class="professional">
   <h1>专业简介</h1>
  <p>北京市黄庄职业高中位于石景山区鲁谷东街，是一所面向全国招生的国家级重点职业高中。1981年，在北京市黄庄中学的基础上，创办了北京市第一个服装专业职业高中班，1984年成为独立设校的职业高中，正式更名为"北京市黄庄职业高中"。2006年，石景山区为最大限度地发挥区职教资源优势，对职教                职业高中、古城旅游职业学校进行了资源整合，目前已形成学历教育、社会培训、实训经营等分类设置，学历、非学历并举，产学研有机结合，资源全面统筹，多品牌经营，一体化管理的办学格局。
  </p>
  <h2><a href="#">详细+</a>
  </h2>
  </div>

 
  </div>
 <div class="content_right">
  <div class="banner"><img src="/asset/images/pic.jpg" width="747" height="256" /></div>
  <div class="new_data">
   <div class="new ">
    <h3><ul id="tit">
  <li class="title_show"  id="mod1" onmouseover="$('#listmoretag').attr('href','./news/'); switchmodTag('mod','slidingList','1');this.blur();">新闻动态</li>
  <li  id="mod2" onmouseover="$('#listmoretag').attr('href','./news/'); switchmodTag('mod','slidingList','2');this.blur();">研究展示</li>
<li class="float" style="background:none;"><span><a id="listmoretag" href="./news/">更多>></a></span></li>
    </ul> 
      </h3>
    <!--新闻列表-->
        <ul  id="slidingList1">
            <c:if test="${fn:length(news_list)>0}">
                <h1><a href="./news/${news_list[0].id} ">${news_list[0].title}</a></h1>
            </c:if>
            <c:if test="${fn:length(news_list)>1}">
                <c:forEach items="${news_list}" var="n" begin="1">
                     <li><span>[<fmt:formatDate value="${n.crtdate}" pattern="yyyy-MM-dd"/>  ]</span> <a href="news/${n.id}">${n.title}</a></li>
                </c:forEach>
            </c:if>
      </ul>
       <!--研究成果-->
<ul class="slidingList_none" id="slidingList2" >
    <c:if test="${fn:length(achievement_list)>0}">
        <h1><a href="./news/${achievement_list[0].id} ">${achievement_list[0].title}</a></h1>
    </c:if>
    <c:if test="${fn:length(achievement_list)>1}">
        <c:forEach items="${achievement_list}" var="n" begin="1">
            <li><span>[<fmt:formatDate value="${n.crtdate}" pattern="yyyy-MM-dd"/>  ]</span> <a href="news/${n.id}">${n.title}</a></li>
        </c:forEach>
    </c:if>

 </ul>


   </div>
  <div class="data">
    <h1>资料库</h1>
   <div class="search">
  <input name="" type="text" class="infor_text" value="站内搜索" onblur="if (value ==''){value='站内搜索'}" onclick="if(this.value=='站内搜索')this.value=''"/><input name="" type="button" value=" " class="infor_button"/> 
 </div>
  <ul>
   <li><a href="#">精品课资源</a></li>
   <li><a href="#">图库资源</a></li>
   <li><a href="#">课件资源</a></li>
   <li><a href="#">素材资源</a></li>
   <li><a href="#">文档资源</a></li>
   <li><a href="#">其他资源</a></li>
   
  </ul> 
  <div style="clear:both"></div>
  <dl>

      <c:if test="${fn:length(strategy_list)>0}">
          <c:forEach items="${strategy_list}" var="n">
              <dt>【攻略】</dt> <dd>  <a href="news/${n.id}">${n.title}</a></dd>
          </c:forEach>
      </c:if>


   </dl>
   <h2><img src="/asset/images/pic03.jpg" width="218" height="90" /></h2>
   </div>
  
  
  </div>
  <div style="clear:both"></div>
  <div class="boutique  zzsc">
      <h1>  
     <ul id="tit" class="tab1">
  <li class="on"   style="margin-left:25px;">精品课程 </li>
<li > 精品素材 </li>
<li> 精品文档 </li>
<li> 经常图库 </li>
	 </ul>                                                               
 <div style="clear:both"></div>
 </h1>
<div class="content">
<ul>
<li style="display:block;">
 <div class="slid">
 <div  class="bout_left">
  <h2><img src="/asset/images/pic01.jpg" width="280" height="139" /></h2>
  <h3><a href="#">资料</a><a href="#">资讯</a><a href="#">攻略</a><a href="#">视频</a><a href="#">动漫</a><a href="#">萌妹</a><a href="#">囧图</a></h3>
 <div style="clear:both"></div>
  <dl>
  <dd>  <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  <dd> <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  <dd> <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  <dd> <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  </dl>
  
    </div>
 <div class="bout_right">
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic02.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>
   
   </dl>
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic02.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>
   
   </dl>
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic02.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>
   
   </dl>
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic02.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>
   
   </dl>
 
 
 </div>
  </div>
  </li>
<li class="bout_none" >
<div class="slid">
 <div  class="bout_left">
  <h2><img src="/asset/images/pic01.jpg" width="280" height="139" /></h2>
  <h3><a href="#">资料</a><a href="#">资讯</a><a href="#">攻略</a><a href="#">视频</a><a href="#">动漫</a><a href="#">萌妹</a><a href="#">囧图</a></h3>
 <div style="clear:both"></div>
  <dl>
  <dd>  <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  <dd> <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  <dd> <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  <dd> <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  </dl>
  
    </div>
 <div class="bout_right">
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic1.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>
   
   </dl>
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic1.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>
   
   </dl>
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic1.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门】 </a></dd>
   
   </dl>
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic1.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>
   
   </dl>
 
 
 </div>
  </div>
  </li>
<li class="bout_none"   >
<div class="slid">
 <div  class="bout_left">
  <h2><img src="/asset/images/pic01.jpg" width="280" height="139" /></h2>
  <h3><a href="#">资料</a><a href="#">资讯</a><a href="#">攻略</a><a href="#">视频</a><a href="#">动漫</a><a href="#">萌妹</a><a href="#">囧图</a></h3>
 <div style="clear:both"></div>
  <dl>
  <dd>  <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  <dd> <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  <dd> <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  <dd> <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  </dl>
  
    </div>
 <div class="bout_right">
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic2.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>
   
   </dl>
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic2.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>
   
   </dl>
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic2.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>
   
   </dl>
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic2.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>
   
   </dl>
 
 
 </div>
  </div>
  </li>
<li class="bout_none"  >
<div class="slid">
 <div  class="bout_left">
  <h2><img src="/asset/images/pic01.jpg" width="280" height="139" /></h2>
  <h3><a href="#">资料</a><a href="#">资讯</a><a href="#">攻略</a><a href="#">视频</a><a href="#">动漫</a><a href="#">萌妹</a><a href="#">囧图</a></h3>
 <div style="clear:both"></div>
  <dl>
  <dd>  <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  <dd> <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  <dd> <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  <dd> <a href="#">微课程大智慧——我校组织"微课基础理论与制作技术"</a></dd>
  </dl>
  
    </div>
 <div class="bout_right">
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic3.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门】平民拳刃加点推荐</a></dd>
   
   </dl>
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic3.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【 刃加点推荐</a></dd>
   
   </dl>
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic3.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【 民拳刃加点推荐</a></dd>
   
   </dl>
   <dl>
    <dt><a href="#" class="avatar"><img src="/asset/images/pic3.jpg" width="165" height="105" /></a></dt>
    <dd><a href="#">【热门 刃加点推荐</a></dd>
   
   </dl>
 
 
 </div>
  </div>
  </li>
 
 </ul>
 </div>
    
  </div>

<script>
$(function(){
	$(".zzsc .tab1 li").mouseover(function(){
		$(this).addClass('on').siblings().removeClass('on');
		var index = $(this).index();
		number = index;
		$('.zzsc .content li').hide();
		$('.zzsc .content li:eq('+index+')').show();
	});
	
	var auto = 1;  //等于1则自动切换，其他任意数字则不自动切换
	if(auto ==1){
		var number = 0;
		var maxNumber = $('.zzsc .tab1 li').length;
		function autotab(){
			number++;
			number == maxNumber? number = 0 : number;
			$('.zzsc .tab1 li:eq('+number+')').addClass('on').siblings().removeClass('on');
			$('.zzsc .content ul li:eq('+number+')').show().siblings().hide();
		}
		 
		//鼠标悬停暂停切换
		 
		 
	  }
});
</script>
<div class="skills  zzsc1">
      <h1>  
     <ul id="tit" class="tab2">
 <li class="tit_show" style="margin-left:25px;">技能大赛 </li>
 <li>师生作品 </li>
 <li>师资团队 </li>
 <span class="float" style="background:none;"><a href="./news">更多>></a></span>
                      
	 </ul>                                                               
 <div style="clear:both"></div>
 </h1>
<div class="content1">
<ul>
<li ><p>
 <div class="slid">
 <div  class="bout_left">
  <h2><img src="/asset/images/pic01.jpg" width="280" height="139" /></h2>
  <div style="clear:both"></div>
  <dl>
      <!--skill-->
      <c:forEach items="${sikll_list}" var="n">
          <dd>  <a href="news/${n.id}">${n.title}</a></dd>
     </c:forEach>
  </dl>
  
    </div>
 <div class="bout_right">
     <!--skill-->
     <c:if test="${fn:length(sikll_hot)>0}">
         <c:forEach items="${sikll_hot}" var="n">
              <dl>
             <dt><a href="#" class="avatar"><img src="/asset/images/pic2.jpg" width="165" height="105" alt="${n.title}"/></a></dt>
             <dd><a href="news/${n.id}">【热门】${n.title}</a></dd>
            </dl>
         </c:forEach>
     </c:if>
 </div>
  </div></p>
  </li>
<li  ><p>
<div class="slid">
 <div  class="bout_left">
  <h2><img src="/asset/images/pic01.jpg" width="280" height="139" /></h2>
  <dl>
      <!--stworks_list-->
    <c:if test="${fn:length(stworks_list)>0}">
      <c:forEach items="${stworks_list}" var="n">
          <dd>  <a href="news/${n.id}">${n.title}</a></dd>
      </c:forEach>
    </c:if>
  </dl>
  
    </div>
 <div class="bout_right">

     <c:if test="${fn:length(stworks_hot)>0}">
         <c:forEach items="${stworks_hot}" var="n">
             <dl>
                 <dt><a href="#" class="avatar"><img src="/asset/images/pic1.jpg" width="165" height="105" alt="${n.title}"/></a></dt>
                 <dd><a href="news/${n.id}">【热门】${n.title}</a></dd>
             </dl>
         </c:forEach>
     </c:if>


 
 </div>
  </div></p>
  </li>
<li><p>
<div class="slid">
 <div  class="bout_left">
  <h2><img src="/asset/images/pic01.jpg" width="280" height="139" /></h2>
  <dl>
      <dl>
          <!--teachergroup_list-->
    <c:if test="${fn:length(teachergroup_list)>0}">
          <c:forEach items="${teachergroup_list}" var="n">
              <dd>  <a href="news/${n.id}">${n.title}</a></dd>
          </c:forEach>
    </c:if>
      </dl>
  </dl>
  
    </div>
 <div class="bout_right">
     <!--teachergroup_list-->
     <c:if test="${fn:length(teachergroup_hot)>0}">
         <c:forEach items="${teachergroup_hot}" var="n">
             <dl>
             <dt><a href="#" class="avatar"><img src="/asset/images/pic2.jpg" width="165" height="105" /></a></dt>
             <dd><a href="news/${n.id}">【热门】${n.title}</a></dd>
             </dl>
         </c:forEach>
     </c:if>


 </div>
  </div></p>
  </li>
  
 </ul>
 </div>
    
  </div>
  <script>
$(function(){
	$('.zzsc1 .content1 ul').width(720*$('.zzsc1 .content1 li').length+'px');
	$(".zzsc1 .tab2 li").mouseover(function(){
		$(this).addClass('tit_show').siblings().removeClass('tit_show');
		var index = $(this).index();
		number = index;
		var distance = -720*index;
		$('.zzsc1 .content1 ul').stop().animate({
			left:distance
		});
	});
	
	var auto = 1;  //等于1则自动切换，其他任意数字则不自动切换
	if(auto ==1){
		var number = 0;
		var maxNumber = $('.zzsc1 .tab2 li').length;
		function autotab(){
			number++;
			number == maxNumber? number = 0 : number;
			$('.zzsc1 .tab2 li:eq('+number+')').addClass('tit_show').siblings().removeClass('tit_show');
			var distance = -720*number;
			$('.zzsc1 .content1 ul').stop().animate({
				left:distance
			});
		}
		var tabChange = setInterval(autotab,3000);
		//鼠标悬停暂停切换
		$('.zzsc1').mouseover(function(){
			clearInterval(tabChange);
		});
		$('.zzsc1').mouseout(function(){
			tabChange = setInterval(autotab,3000);
		});
	  }  
});
</script>

    
 </div>
 </div>
   <div style="clear:both">
  </div>
<div class="fooder1"></div>
 <div class="fooder">
   地址：北京市石景山区鲁谷东街29号  邮编：100040<br/> 
电话：010-68638293   传真：010-68638293  京ICP备07012769号 | 京公网安备11010702001098号

 
 
 
 </div>
 </body>
</html>   