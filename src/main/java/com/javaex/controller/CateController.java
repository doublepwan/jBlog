package com.javaex.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.BlogService;
import com.javaex.service.CategoryService;
import com.javaex.vo.CategoryVo;

@Controller
public class CateController {

	@Autowired
	CategoryService cateService;

	@ResponseBody
	@RequestMapping("{id}/blog/cate/list")
	public List<CategoryVo> apiGetCateList(@PathVariable(value = "id") String id, @RequestParam int userNo) {
		List<CategoryVo> cateList = cateService.getList(userNo);
		System.out.println(cateList.toString());
		return cateList;
	}
	
	@ResponseBody
	@RequestMapping("{id}/blog/cate/insertApi")
	public CategoryVo insertApiCate(@PathVariable(value = "id") String id, @RequestBody CategoryVo cateVo) {

		CategoryVo caVo = cateService.insertApi(cateVo);
		System.out.println(caVo.toString());
		return caVo;
	}

	@ResponseBody
	@RequestMapping("{id}/blog/cate/deleteApi")
	public boolean deleteApiCate(@PathVariable(value = "id") String id, @RequestParam("cateNo") int cateNo) {
		
		boolean result = cateService.delete(cateNo);
		return result;
	}
}
