
/*!
 * 此js仅用于需要用到公共弹窗的页面，支持弹窗内容双击选中单条数据，多选通过按钮获取选中数据
 * commonSearch.js v1.0.0 
 * author linmengmeng	2020-11-12
 * (c) 2020-2030 JadlSoft
 */

/**
 * 关闭iframe弹窗
 */
function closewin() {
	//$("#detail").find(".close").parent().parent().hide().siblings("#maskLayer").remove();
	$("#detail").find(".close").parent().parent().hide();
	$("#maskLayer").remove();
	/* 当存在多个弹窗时，需要判断移除的maskLayer所在页面
	 * if($('#maskLayer').length > 0){
		console.log("存在maskLayer.......");
	}*/
}

/**
 * 校验公共函数调用参数是否合法
 */
function isEmpty(obj){
    if(typeof obj == "undefined" || obj == null || obj == ""){
        return true;
    }else{
        return false;
    }
}

//此对象用来存储弹窗里面的列表头和中文名称
var searchResultColumn;
//此对象用来存储弹窗里面的列表对应接口名称
var searchUrl;
//此对象用来存储弹窗里面的查询条件  可用来携带弹窗里面固定的查询参数
var searchQueryCols;

//此对象(拼接的字符串)用来存储父页面往子页面传的固定查询参数
var fixedQueryParameters = "";

//此对象用来存储列表中选中的对象数组
var searchMultiObjArray;

//标记是否是多选,search弹窗页面根据 isMultiSign 判断是否显示复选框
var isMultiSign = false;

//此对象用来标记自定义弹窗名称，回调方法中会返回该对象的值
var searchWinName;


/**
 * 初始化父页面固定查询参数
 * keyArray 固定查询参数字段名称组成的数组 需保证参数名为查询弹窗SQL里面的字段名 否则拼接的查询SQL会出现异常
 * 		* : 右LIKE
 * 		** : 左右LIKE 会全表扫描，这里禁用左右LIKE 如果使用左右LIKE 自动丢弃此查询参数
 * 		没有任何标识符的按等于处理
 * valueArray	固定查询参数值组成的数组 
 * keyArray 和 valueArray 数组长度须保持一致
 */
function initFixedQueryParameters(keyArray, valueArray){
	var tempFixedQueryParameter = "";
	if(!keyArray || !valueArray){
		jadlsoftWarming("initFixedQueryParameters", "keyArray and valueArray can't be null, they should be Array");
		return;
	}
	
	if(keyArray.length != valueArray.length){
		jadlsoftWarming("initFixedQueryParameters", "keyArray and valueArray length is not equals");
		return;
	}
	var tempKey = "";
	for(var i=0;i<keyArray.length;i++){
		tempKey = keyArray[i];
		if(tempKey.indexOf("**")>0){
			continue;//左右LIKE 丢弃此查询参数
		}
		if(tempKey.indexOf("*")>0) {
			tempKey = tempKey.substr(0, tempKey.indexOf("*"));
			tempFixedQueryParameter += tempKey;
			tempFixedQueryParameter += "~like~";
			tempFixedQueryParameter += valueArray[i];
		}else{
			tempFixedQueryParameter += tempKey;
			tempFixedQueryParameter += "~=~";
			tempFixedQueryParameter += valueArray[i];
		}
		if(i < keyArray.length-1){
			tempFixedQueryParameter += ",";
		}
	}
	
	fixedQueryParameters = tempFixedQueryParameter;
}


/**
 * url 为列表待显示的数据接口URL
 * fields 为列表字段属性值映射 即为弹窗待显示的sql里面的字段名
 * titles 为列表表头显示内容	该字段对应的表头
 * 
 * winName 自定义的当前弹窗名称，公共回调函数会返回该值
 * isMulti 是否多选 true  false  使用多选时，父页面js中必须要有 multiSearchCallback(searchMultiObjArray, winName) 函数(该函数为自定义业务逻辑函数，参数为选中的对象数组)
 */
function openSeachWindow(url, fields, titles,winName, isMulti) {

	if(winName == null || winName == ''){
		jadlsoftWarming("openSeachWindow", "winName can't be null or ''");
		return;
	}
	var openSearchWinPath = $("#openSearchWinPath").val();
	if(openSearchWinPath == null || openSearchWinPath == ''){
		jadlsoftWarming("openSeachWindow", "openSearchWinPath can't be null or ''");
		return;
	}
	
	searchWinName = winName;
	
	initSearchWin(url, fields, titles,winName, isMulti);
	
	$("#iframe_content").empty();
	
	$("#iframe_content").append("<iframe src='"+openSearchWinPath+"' id='iframeid' width='800' height='380' frameborder='no' title='test'></iframe>")
	popWin("detail");
	
}


/**
 * 单选弹窗调用此函数
 * url 为列表待显示的数据接口URL
 * fields 为列表字段属性值映射
 * titles 为列表表头显示内容
 * winName 自定义的当前弹窗名称，公共回调函数会返回该值
 * isFixedParameter 弹窗内是否携带固定查询参数
 */
function openSeachWindowSingle(url, fields, titles,winName,isFixedParameter) {
	if(!isFixedParameter){
		fixedQueryParameters = "";
	}
	openSeachWindow(url, fields, titles,winName, false);
}

/**
 * 多选弹窗调用此函数
 * url 为列表待显示的数据接口URL
 * fields 为列表字段属性值映射
 * titles 为列表表头显示内容
 * winName 自定义的当前弹窗名称，公共回调函数会返回该值
 * isFixedParameter 弹窗内是否携带固定查询参数
 */
function openSeachWindowMulti(url, fields, titles,winName,isFixedParameter) {
	if(!isFixedParameter){
		fixedQueryParameters = "";
	}
	openSeachWindow(url, fields, titles,winName, true);
}

/**
 * 初始化弹窗参数
 */
function initSearchWin(url, fields, titles,searchCols, isMulti){
	if(isEmpty(fields) || isEmpty(titles)){
		jadlsoftWarming("openSeachWindow", "fields and titles can't be empty");
		return;
	}
	if(isEmpty(url)){
		jadlsoftWarming("openSeachWindow", "url can't be empty");
		return;
	}
	if(isEmpty(searchCols)){
		jadlsoftWarming("openSeachWindow", "searchCols can't be empty");
		return;
	}
	if(isMulti == null){
		jadlsoftWarming("openSeachWindow", "isMulti can't be null");
		return;
	}
	
	searchUrl = url;
	isMultiSign = isMulti;
	searchResultColumn = [];
	
	if(isMulti){
		searchResultColumn.push({
			field: 'selectItem',	//注意这里的field尽量不用返回数据的字段名，否则后面获取选中值的时候会把该字段的值变为true或者false 
			checkbox: true
		});
	}
	
	var fieldArray = fields.split(",");
	var titleArray = titles.split(",");
	for(var i = 0,len=fieldArray.length; i < len; i++) {
		searchResultColumn.push({
			field: fieldArray[i],
            title: titleArray[i],
            align: 'center',
            valign: 'middle',
            sortable: true
		});
	}
	
	searchQueryCols = searchCols.split(",");
}

/**
 * 多选弹窗确定按钮执行该方法, 该公共方法去调用页面自定义的方法：afterSearchMulti 实现自定义的具体业务逻辑
 */
function getSearchMultiObject(searchMultiObjArray, winName){
	if(multiSelectCallback(searchMultiObjArray, winName)){
		closewin();
	}
}

