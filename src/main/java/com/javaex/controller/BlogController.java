package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.BlogService;
import com.javaex.service.CategoryService;
import com.javaex.service.UsersService;
import com.javaex.vo.BlogVo;
import com.javaex.vo.CategoryVo;
import com.javaex.vo.PostVo;
import com.javaex.vo.UsersVo;

@Controller
public class BlogController {

	@Autowired
	UsersService userService;
	@Autowired
	CategoryService cateService;
	@Autowired
	BlogService blogService;

	@RequestMapping("/{id}")
	public String blogMain(@PathVariable(value = "id") String id, Model model) {
		getBlogTitle(id, model);
		model.addAttribute("id", id);
		
		List<CategoryVo> cateList = cateService.blogMainCate(id);
		model.addAttribute("cateList", cateList);
		
		return "blog/blog-main";
	}

	@ResponseBody
	@RequestMapping("/{id}/blog/postList")
	public List<PostVo> listPost(@PathVariable(value = "id") String id, @RequestParam("cateNo") int cateNo) {
		
		return blogService.getPostList(id, cateNo);
	}
	
	@ResponseBody
	@RequestMapping("/{id}/blog/newestPost")
	public PostVo newestPost(@PathVariable(value = "id") String id, @RequestParam int postNo) {
		return blogService.getViewPost(postNo);
	}
	
	@ResponseBody
	@RequestMapping("/{id}/blog/getPost")
	public PostVo getPost(@PathVariable(value = "id") String id, @RequestParam int postNo) {

		return blogService.getViewPost(postNo);
	}

	public void getBlogTitle(String id, Model model) {
		UsersVo usersVo = userService.getUser(id);
		model.addAttribute("id", id);

		BlogVo blogVo = blogService.getTitle(usersVo);
		model.addAttribute("blogVo", blogVo);
	}

}
