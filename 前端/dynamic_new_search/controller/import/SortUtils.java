package com.jadlsoft.utils;

import java.util.Map;

import org.apache.commons.lang.StringUtils;

/**
 * 结合PageHelper分页工具使用的排序工具类
 * @author linmengmeng
 * @date 2020年11月10日 下午4:08:43
 */
public class SortUtils {

	/**
	 * 动态获取待排序字段
	 * @auther linmengmeng
	 * @Date 2020-11-10 下午4:09:58
	 * @param remarkMap	Map<实体类字段名称, 数据库字段> 		
	 * @param sortName	前端传来的需要排序的字段
	 * @param sortOrder	排序规则 desc or asc
	 * @return
	 */
	public static String getSortInfo(Map<String, String> remarkMap, String sortName, String sortOrder){
		if (StringUtils.isEmpty(sortName) || StringUtils.isEmpty(sortOrder)) {
			throw new IllegalArgumentException("sortName and sortOrder can not be empty");
		}
		String sort_name = remarkMap.get(sortName);
		if (StringUtils.isEmpty(sort_name)) {
			throw new IllegalArgumentException("sortName is illegal or sortName value is not contained in the remarkMap ");
		}
		return sort_name + " " + sortOrder;
	}
}
