/**
 * 工具类使用方法异常提醒
 */
function jadlsoftWarming(methodName,warmingMsg){
	console.error("******jadlsoft warming: The method name is " + methodName + ", which has a wrong way to call, errorMsg:" + warmingMsg + "*************");
	return;
}