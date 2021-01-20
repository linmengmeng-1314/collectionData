/**
 * 测试search单选弹窗
 */
function openXzqhWin(url){
	$("#title_h5").text("请选择行政区划");
	openSeachWindowSingle(url, "dm,mc", "行政区划代码,行政区划名称", "xzqhWin", false);
}

/**
 * 测试search多选弹窗
 */
function openXzqhWinMulti(url){
	$("#title_h5").text("请选择行政区划");
	openSeachWindowMulti(url, "dm,mc", "行政区划代码,行政区划名称", "xzqhWin", false);
}

/**
 * 测试父页面往弹窗里面传单个值作为固定查询条件
 */
function openXzqhWinFixQueryParameter(url){
	$("#title_h5").text("请选择行政区划-固定查询条件");
	
	/**
	 * 这里测试只查北京下面的行政区划   如果需要传多个固定参数，按照顺序挨个添加即可
	 * dm* 表示查询条件为右LIKE
	 * dm  表示条件为等于
	 */
//	var keyArray=new Array("dm");
//	var valueArray=new Array("110100");
	var keyArray=new Array("dm*");
	var valueArray=new Array("11");
	/**
	 * 初始化固定查询参数
	 */
	initFixedQueryParameters(keyArray, valueArray);
	
	//多选
	//openSeachWindowMulti(url, "dm,mc", "行政区划代码,行政区划名称", "xzqhWinAndParameter", true);
	
	//单选
	openSeachWindowSingle(url, "dm,mc", "行政区划代码,行政区划名称", "xzqhWinAndParameter", true);
}

/**
 * 测试父页面往弹窗里面传多个值作为固定查询条件
 */
function openXzqhWinFixQueryParameters(url){
	$("#title_h5").text("请选择行政区划-多个固定查询条件");
	
	/**
	 * 这里测试只查北京下面的行政区划   如果需要传多个固定参数，按照顺序挨个添加即可
	 * dm* 表示查询条件为右LIKE
	 * dm  表示条件为等于
	 */
//	var keyArray=new Array("dm");
//	var valueArray=new Array("110100");
//	var keyArray=new Array("dm*");
//	var valueArray=new Array("11");
	var keyArray=new Array("dm*", "dm");
	var valueArray=new Array("11","110100");
	/**
	 * 初始化固定查询参数
	 */
	initFixedQueryParameters(keyArray, valueArray);
	
	//多选
	//openSeachWindowMulti(url, "dm,mc", "行政区划代码,行政区划名称", "xzqhWinAndParameter", true);
	
	//单选
	openSeachWindowSingle(url, "dm,mc", "行政区划代码,行政区划名称", "xzqhWinAndParameter", true);
}

/**
 * 单选弹窗 回调函数
 */
function singleSelectCallback(singleSelectObject, winName){
	console.log("winName：" + winName);
	console.log("单选双击行对象：");
	console.log(singleSelectObject);
}

/**
 * 多选弹窗回调函数 
 * 多选时页面需要定义此方法来实现多选数据后具体的业务逻辑
 * 弹窗子页面不做选中数据条数判断 这里自定义添加限制选中的条数 可根据 selectedObjArray.length 判断选中条数
 * return boolean true 关闭弹窗，false 不关闭弹窗
 */
function multiSelectCallback(selectedObjArray, winName){
	console.log("winName：" + winName);
	console.log("多选弹窗勾选数据如下:");
	console.log(selectedObjArray);
	if(selectedObjArray.length < 1){
		alert("请至少选择一项！");
		return false;
	}
	return true;
}