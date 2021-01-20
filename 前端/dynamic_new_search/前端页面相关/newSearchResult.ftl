<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search-ftl</title>

    <link rel="shortcut icon" href="favicon.ico">
    <link href="${ctx!}/css/uicss/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx!}/common/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="color: #4d4d4d;">

	<!-- 查询参数 form... -->
	<div class="form-group" class="col-sm-12">
		<form id="query_form">
			<table class="dnCon_wt">
				<tr>
					<td style="width:80%;">
						<table id="queryParameterTable" style="padding-left:30px;" width="100%" border="0" cellspacing="0" cellpadding="2">
						</table>
					</td>
					<td style="padding-left:30px;">
						<table id="queryButtonTable" width="100%" border="0" cellspacing="0" cellpadding="2">
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="row row-lg">
	    <div class="col-sm-12">
	        <!-- Example Card View -->
	        <div class="example-wrap">
	            <div class="example">
	            	<table id="table_list"></table>
	            </div>
	        </div>
	        <!-- End Example Card View -->
	    </div>
	</div>
	
   <!-- 全局js -->
    <script src="${ctx!}/common/jquery.min.js?v=2.1.4"></script>
    <script src="${ctx!}/common/bootstrap/js/bootstrap.min.js"></script>
    <script src="${ctx!}/common/commonTable.js"></script>
    
	<!-- Bootstrap table -->
    <script src="${ctx!}/common/bootstrap-table/bootstrap-table.min.js"></script>
    <script src="${ctx!}/common/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>

    <!-- 自定义js -->
    <script src="${ctx!}/common/newSearch/js/commonSearch.js"></script>
    <script src="${ctx!}/common/newSearch/js/jadlsoftWarming.js"></script>

    <!-- Page-Level Scripts -->
    <script>
    	/**
    	*	动态渲染查询条件
    	*	searchTitle	由接口返回，渲染input框前面的文字
    	*	searchCol	由接口返回，渲染input框的name
    	*/
	    function fillQueryParameterTable(searchTitle, searchCol){
	    	var tableObj = document.getElementById('queryParameterTable').rows[0];
	    	if (tableObj == null) {
				var queryParameterTableTr = "";
				//渲染查询弹窗里面的查询条件
				for (var i=0; i<searchTitle.length; i++){
					queryParameterTableTr = "<tr><td style='text-align:right;'>"
					+ searchTitle[i] 
					+ "</td><td>"
					+ "<input value='' name='" + searchCol[i] + "'/>"
					+ "</td></tr>";
					$("#queryParameterTable").append(queryParameterTableTr);
				}
			 }
	    }
	    
	    /**
	    *	动态渲染查询按钮
	    *	isMultiSign 是否显示确定按钮
	    */
	    function fillQueryButton(isMultiSign){
	    	var queryButtonTr = "<tr><td><input class='btn btn-success active' type='button' name='chaxun' onclick='search(\"table_list\");' value='查询'/></td></tr>";
	    	var confimButtonTr = "<tr><td><input class='btn btn-primary active' type='button' name='confirm' onclick='addSelectObj();' value='确定'/></td></tr>";
	    	var closeButtonTr = "<tr><td><input class='btn btn-info active' type='button' name='close' onclick='hidewindow();' value='关闭'/></td></tr>";
	    	$("#queryButtonTable").append(queryButtonTr);
	    	if(isMultiSign){
	    		$("#queryButtonTable").append(confimButtonTr);
	    	}
	    	$("#queryButtonTable").append(closeButtonTr);
	    }
    	
    	/**
    	*	关闭frame弹窗
    	*/
		function hidewindow(){
	    	parent.closewin();
	    }
	    
	    /**
	    *	将选中的数据对象通过getSearchMultiObject(selectedObjArray)函数传到父页面中
	    *	这里不对选择条数进行限制，条数权限限制下放到父页面，父页面自定义限制选中的条数
	    */
		function addSelectObj(){
			var selectedObjArray = $('#table_list').bootstrapTable('getSelections');
			parent.getSearchMultiObject(selectedObjArray,parent.window.searchWinName);
	    }
    
        $(document).ready(function () {
        	//动态渲染查询按钮
        	fillQueryButton(parent.window.isMultiSign);
        	//初始化表格,动态从服务器加载数据  
			$("#table_list").bootstrapTable({
			    //使用get请求到服务器获取数据  
			    method: "POST",
			    //必须设置，不然request.getParameter获取不到请求参数
			    contentType: "application/x-www-form-urlencoded",
			    //获取数据的Servlet地址  
			    url: parent.window.searchUrl,
			    //表格显示条纹  
			    striped: true,
			    //启动分页  
			    pagination: true,
				//sortable: true,      //是否启用排序	//需配合下面的列字段sortable: true进行排序
				//sortOrder: "asc",     //排序方式
			    //每页显示的记录数  
			    pageSize1: 10,
			    //当前第几页  
			    pageNumber1: 1,
			    //记录数可选列表  
			    pageList: [10, 20, 50],
			    toolbar: '#toolbar',                //工具按钮用哪个容器
			    striped: true,                      //是否显示行间隔色
			    //showRefresh: true,                  //是否显示刷新按钮 作用不大，默认false
			    //clickToSelect: true,                //是否启用点击选中行  需配合复选框使用
			    singleSelect:false,//是否单选，false表示多选;true标识只能单选
 				clickToSelect: true,//启用点击某行就选中某行
			    onDblClickRow: function (row) {
			    	if(!parent.window.isMultiSign){
			    		parent.singleSelectCallback(row,parent.window.searchWinName);
						hidewindow();
			    	}
				},
				theadClasses: "thead-blue",//设置thead-blue为表头样式
				//classes: "table table-bordered table-striped table-sm table-dark", //"table table-bordered table-striped table-sm table-dark",
			    //是否启用查询    默认只有一个搜索框
			    //search: true,
			    //表示服务端请求  
			    sidePagination: "server",
			    //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder  
			    //设置为limit可以获取limit, offset, search, sort, order  
			    queryParamsType: "undefined",
			    //得到查询的参数
				queryParams : function (params) {
					var temp = $("#query_form").serializeJsonObject();
					var fixedParameters = parent.window.fixedQueryParameters;
					if(fixedParameters && fixedParameters != ''){
						temp["parentQueryParameter"]= parent.window.fixedQueryParameters;
					}
					temp["sortName"]= params.sortName,
					temp["sortOrder"]= params.sortOrder,
					temp["page"]= params.pageNumber,
					temp["rows"]= params.pageSize;
					return temp;
				},
			    //json数据解析
			    responseHandler: function(data) {
			    	//console.log(data);
			    	if(data.code == 200){
			    		fillQueryParameterTable(data.data.searchTitle, data.data.searchCol);
			    		return {
			    			"rows": data.data.resultList,
				            "total": data.data.count
				        };
			    	}else{
			    		alert("系统异常，请联系管理员");
			    	}
			    },
			    //数据列
			    columns: parent.window.searchResultColumn
			});
        });
    </script>
</body>
</html>