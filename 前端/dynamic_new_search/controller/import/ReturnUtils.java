package com.jadlsoft.utils;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.httpclient.HttpStatus;


/**
 * 封装返回Json数据
 * 
 * 返回格式为:
 *  {  
 *  	"code":200,
 * 	 	"msg":"success",
 *   	"data":Object
 *  }
 * 
 * @author linmengmeng
 * @date 2020年9月10日 下午3:30:38
 */
public class ReturnUtils extends HashMap<String, Object> {
	private static final long serialVersionUID = 1L;
	
	public ReturnUtils() {
		put("code", HttpStatus.SC_OK);
		put("msg", "success");
	}
	
	public static ReturnUtils error() {
		return error(HttpStatus.SC_INTERNAL_SERVER_ERROR, "未知异常，请联系管理员");
	}
	
	public static ReturnUtils error(String msg) {
		return error(HttpStatus.SC_INTERNAL_SERVER_ERROR, msg);
	}
	
	public static ReturnUtils error(int code, String msg) {
		ReturnUtils r = new ReturnUtils();
		r.put("code", code);
		r.put("msg", msg);
		return r;
	}
	
	public static ReturnUtils ok(int code, String msg) {
		ReturnUtils r = new ReturnUtils();
		r.put("code", code);
		r.put("msg", msg);
		return r;
	}

	public static ReturnUtils ok(String msg) {
		ReturnUtils r = new ReturnUtils();
		r.put("msg", msg);
		return r;
	}
	
	public static ReturnUtils ok(Map<String, Object> map) {
		ReturnUtils r = new ReturnUtils();
		r.put("data", map);
		return r;
	}
	
	public static ReturnUtils ok(Object data) {
		ReturnUtils r = new ReturnUtils();
		r.put("data", data);
		return r;
	}
	
	public static ReturnUtils ok() {
		return new ReturnUtils();
	}

	public ReturnUtils put(String key, Object value) {
		super.put(key, value);
		return this;
	}
}
