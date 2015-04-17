 

  $(function (){
		//下拉菜单控件	  
		$(".selecter li").mouseover(function (){
			$(this).find("ul").show()
		}).mouseout(function (){
			$(this).find("ul").hide();
		})
		 
		//模拟选中效果	
		$(".selecter li ul li a").click(function (){
		     
		    $(this).parent().parent().parent().find(".drop_down").val($(this).html())
			$(".selecter li ul").hide();
			
		})
 //top菜单
         $(".nav li a").click(function (){
			  for(i=1;i<=6;i++){
				  $(".n"+i).removeClass("n"+i+"_hover");
			  }					
              $(this).addClass($(this).attr("class")+"_hover")									    
		 })
		 
		 // 全选反选
		 $("input[name=input_but]").click(function (){
												 
				$("input[name=input]").attr("checked",$(this).attr("checked"))									
		 })
		 //表格
		 $(".table_form tr").mouseover(function (){
				 $(this).css("background","#f7f7f7")					 
		 }).mouseout(function (){
			 
			 $(this).css("background","#ffffff")
	     })
		 //左侧菜单上下特效
		    $(".title").toggle(
		function(){
		$(this).next().slideshow();
		$(this).addClass("show_menu");		
		},function(){
		$(this).next().slideshow()
		$(this).removeClass("show_menu")
		
		}) 
		//   左侧菜单点击效果	
		$("#pucker li a").click(function (){
		   $("#pucker li a").removeClass("a_hover")
		   $(this).addClass("a_hover")
		})
    })
 
 








/*lby js库 by 联合设计仅用于学习交流*/
var lby={
	$:function (id){return document.getElementById(id)},//如果需要定义两个或者两个以上的方法用，隔开
	getByClass:function (name){
		var arr=[];//定义空数组
		for(i=0;i<document.getElementsByTagName("*").length;i++){
			if(document.getElementsByTagName("*")[i].className==name){
				arr.push(document.getElementsByTagName("*")[i])//添加到数组
			}//end if
		}//end for
		return arr;
	},//end getByClass function
	index:function (self,obj){ //得到索引值方法 
       for(var i=0;i < obj.length;i++){
           if(obj[i]==self){
           return i;
           }
       }
   },
   replaceSpace:function (strObj){//替换表单中字符串中含有空格函数
	 var reg=/\s/g;
	 var str=strObj.value;//原有的内容，可能会带有空格
	 str=str.replace(reg,"");
	 strObj.value=str;//去除空格后的文本框显示的内容	  
   },
 /*  s:0,//动画
   animate:function changeNum(num,obj){
   
   p=Math.ceil(0.1*(num-lby.s));//   第二次 s=19
   lby.s=lby.s+p;
   obj.innerHTML=lby.s
   obj.style.left=lby.s
   setTimeout("changeNum("+num+","+obj+")",10)
   },*/
   getByTag:function(id,tagName){// 用标签名获取对象，obj为id tagName为标签名
   var arr=[];
   for(tagi=0;tagi<document.getElementById(id).getElementsByTagName(tagName).length;tagi++){
	   arr.push(document.getElementById(id).getElementsByTagName(tagName)[tagi]);
   }
   return arr;
   }
}//创建自定义对象

//浏览器兼容判断
var Browser = {
		isIE:navigator.userAgent.indexOf("MSIE")>-1 && !window.opera,
		isGecko:navigator.userAgent.indexOf("Gecko")>-1 && !window.opera 
		&& navigator.userAgent.indexOf("KHTML") ==-1,
		isKHTML:navigator.userAgent.indexOf("KHTML")>-1,
		isOpera:navigator.userAgent.indexOf("Opera")>-1
};
//下拉菜单控件 