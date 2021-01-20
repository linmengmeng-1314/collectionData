package com.jadlsoft.controller.newSearch;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jadlsoft.bean.search.XzqhBean;
import com.jadlsoft.bean.search.vo.XzqhQueryVO;
import com.jadlsoft.bean.search.vo.XzqhQueryVO.XzqhEnum;
import com.jadlsoft.business.newSearch.INewSearchManager;
import com.jadlsoft.common.annotation.CtrlLog;
import com.jadlsoft.utils.BeanCopierUtils;
import com.jadlsoft.utils.ReturnUtils;
import com.jadlsoft.utils.SortUtils;

@Controller
@RequestMapping("/search")
public class NewSearchController {

	@Autowired
	private INewSearchManager newSearchManager;
	
	@CtrlLog("打开search弹窗")
	@RequestMapping(value="/openSearchWin",method= {RequestMethod.POST,RequestMethod.GET})
	public String single(){
		return "search/newSearchResult";
	}
	
	/**
	 * 查询行政区划表数据
	 * @auther linmengmeng
	 * @Date 2020-11-30 上午10:00:24
	 * @return
	 */
	@CtrlLog("查询行政区划表数据")
	@RequestMapping("/getXzqh")
	@ResponseBody
	public ReturnUtils getXzqh(XzqhQueryVO xzqhQueryVO){
		XzqhBean xzqhBean = new XzqhBean();
		//int a = 10/0;
		BeanCopierUtils.copyProperties(xzqhQueryVO, xzqhBean);
		PageHelper.startPage(xzqhQueryVO.getPage(), xzqhQueryVO.getRows());
		//页面排序功能所用，支持查询条件所在列排序
		if (!StringUtils.isEmpty(xzqhQueryVO.getSortName())) {
			// 1. 查询条件对应实体类属性与数据库字段不一致时使用此方式进行转换，即当数据库字段如xzqh_dm 而实体类属性为xzqhDm时使用
			PageHelper.orderBy(SortUtils.getSortInfo(XzqhEnum.getRemarkMap(), xzqhQueryVO.getSortName(), xzqhQueryVO.getSortOrder()));
			// 2. 数据库字段与实体类属性完全一致时，无需转换，直接使用下面的方式设置PageHelper的orderBy属性值
			//PageHelper.orderBy(xzqhQueryVO.getSortName() + " " + xzqhQueryVO.getSortOrder());
		}
		List<XzqhBean> xzqhAllList = newSearchManager.getXzqhAll(xzqhBean);
		Page<XzqhBean> page = (Page<XzqhBean>) xzqhAllList;
		System.out.println(JSONObject.toJSONString(page));
		ReturnUtils result = packageReturnUtils(page, page.getTotal(), Arrays.asList("dm","mc"), Arrays.asList("行政区划代码","行政区划名称"));
		page.close();
		return result;
	}
	
	/**
	 * 封装返回参数
	 * @auther linmengmeng
	 * @Date 2020-11-30 下午5:44:43
	 * @param page	页面显示数据
	 * @param total	总条数
	 * @param searchCol	查询条件对应的数据库字段
	 * @param searchTitle	查询条件标题
	 * @return
	 */
	public static <T> ReturnUtils packageReturnUtils(Page<T> page, long total, List<String> searchCol, List<String> searchTitle){
		ReturnUtils result = new ReturnUtils();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("resultList", page);
		dataMap.put("count", total);
		//后台设置查询条件与字段名
		dataMap.put("searchCol", searchCol);
		dataMap.put("searchTitle", searchTitle);
		result.put("data", dataMap);
		return result;
	}
}
