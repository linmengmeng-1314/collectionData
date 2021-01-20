<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>首页</title>
    <#include "/include/head.ftl">
    
    <!-- newSearch begin -->
	<link href="${ctx!}/common/newSearch/css/cont_w.css" type="text/css" rel="stylesheet"></link>
	
    <script src="${ctx!}/js/jquery.min.js"></script>
    <script src="${ctx!}/common/newSearch/js/popWin.min.js"></script>
    <script src="${ctx!}/common/newSearch/js/commonSearch.js"></script>
	<!-- newSearch end -->
	
    <!-- 页面自定义js -->
    <script src="${ctx!}/syxx/syxx.js"></script>
    
    <style type="text/css">
    .div1 {
            width: 110px;
            height: 70px;
            border: 1px solid #1cc09f;
            border-radius: 5px;
            background: #1cc09f;
            float: left;
            margin: 2px;
            text-align: center;
            color: white;
            cursor: pointer;
        }
        
    .div2 {
            width: 110px;
            height: 70px;
            border: 1px solid #1cc09f;
            border-radius: 5px;
            background: #ec7e7e;
            float: left;
            margin: 2px;
            text-align: center;
            color: white;
            cursor: pointer;
        }
        
    .div3 {
            width: 110px;
            height: 70px;
            border: 1px solid #1cc09f;
            border-radius: 5px;
            background: #f3a633;
            float: left;
            margin: 2px;
            text-align: center;
            color: white;
            cursor: pointer;
        }
    
    </style>
    
    <script type="text/javascript">
    
    function openXzqhWin1(){
    	$("#title_h5").text("请选择行政区划");
    	openSeachWindowSingle("/search/getXzqh", "dm,mc", "行政区划代码,行政区划名称", "xzqhWin", false);
    }
    
    var data = [
    	{
    		"id": "1",
    		"name": "面板1",
    		"state": 0,
    	},
    	{
    		"id": "2",
    		"name": "面板2",
    		"state": 1,
    	},
    	{
    		"id": "3",
    		"name": "面板3",
    		"state": 2,
    	},
    	{
    		"id": "4",
    		"name": "面板4",
    		"state": 3,
    	}
    	];
    $(function(){
    	console.log("123init......");
    	initPage(data);
    	initPage(data);
    	initPage(data);
    	initPage(data);
    	initPage(data);
    	initPage(data);
    	initPage(data);
    });
    
    function initPage(data){
    	var tempData;
    	$.each(data, function(i){
    		//console.log(data[i]);
    		tempData = data[i];
    		if(tempData.state == 0 || tempData.state == 3){
	    		$("#mbId").append("<li onclick='myclick(" + tempData.id + ")' class='div1'>"
	    			+ "<div>" + tempData.id + "</div>"		
	    			+ "<div>" + tempData.name + "</div>"		
	    			+ "</li>");
    		}
    		if(tempData.state == 2){
	    		$("#mbId").append("<li onclick='myclick(" + tempData.id + ")' class='div2'>"
	    			+ "<div>" + tempData.id + "</div>"		
	    			+ "<div>" + tempData.name + "</div>"		
	    			+ "</li>");
    		}
    		if(tempData.state == 1){
	    		$("#mbId").append("<li onclick='myclick(" + tempData.id + ")' class='div3'>"
	    			+ "<div>" + tempData.id + "</div>"		
	    			+ "<div>" + tempData.name + "</div>"		
	    			+ "</li>");
    		}
    	});
    }
    
    function myclick(id){
    	console.log("点击了ID为：" + id + "的面板块。。。。。");
    }
    
    </script>
    
</head>
<body>
<!--主体内容-->
<div class="container margin-top48">
	<!-- 引入菜单栏 -->
	<#include "/include/menu.ftl">
	<div class="row clearfix fsxgl fsxglbox">
		<div class="col-md-12 col-sm-12 no-padding">
            <div class="bread">
                <ul class="clearfix">
                    <li>
                        <a href="#">当前位置</a><span>&nbsp></span>
                    </li>
                    <li>
                        <a href="#">首页</a>
                    </li>
                </ul>
            </div>
            <div class="col-md-12 col-sm-12 margin-top20">
            	<h1>welcome to 空白首页</h1>
		    	<div id="detail">
					<div class="tit ofl">
						<h5 id="title_h5" class="f1">请选择XX信息</h5>
						<!-- <i class="tit close fr">X</i> -->
						<!-- 这里class里面的close属性不能删，关闭弹窗是用这个判断的，否则关闭弹窗按钮失效 优化添加关闭按钮即可删掉下面的i标签 -->
						<i class="tit close" onclick="closewin()"></i>
					</div>
					<!-- 动态获取接口路径，传入iframe的src中-避免外部Tomcat运行时弹窗内容404 -->
					<input id="openSearchWinPath" type="text" style="display:none" value="${ctx!}/search/openSearchWin" />
					<div class="cont_c" id="iframe_content"></div>
				</div>
				<div>
					行政区划：
					<input type="text" size="30" id="mc" name="mc" readonly="readonly" class="input_open m_input jqInp" style="width:240px" onclick="openXzqhWin('${ctx!}/search/getXzqh');"/>
				</div>
				<div>
					行政区划多选：
					<input type="text" size="30" id="mc2" name="mc2" readonly="readonly" class="input_open m_input jqInp" style="width:240px" onclick="openXzqhWinMulti('${ctx!}/search/getXzqh');"/>
				</div>
				<div>
					行政区划-带单个参数弹窗(只查北京)：
					<input type="text" size="30" id="mc3" name="mc3" readonly="readonly" class="input_open m_input jqInp" style="width:240px" onclick="openXzqhWinFixQueryParameter('${ctx!}/search/getXzqh');"/>
				</div>
				<div>
					行政区划-带多个参数弹窗(只查北京的其中一条)：
					<input type="text" size="30" id="mc4" name="mc4" readonly="readonly" class="input_open m_input jqInp" style="width:240px" onclick="openXzqhWinFixQueryParameters('${ctx!}/search/getXzqh');"/>
				</div>
		    </div>
		    
		    <!-- 面板div -->
		    <div class="col-md-12 col-sm-12 margin-top20">
		    	<div id="mbId" class="list-group">
		    	</div>
		    </div>
        </div>
    </div>
</div>
</body>
</html>