package com.javaex.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.BlogService;
import com.javaex.service.CategoryService;
import com.javaex.service.UsersService;
import com.javaex.vo.BlogVo;
import com.javaex.vo.CategoryVo;
import com.javaex.vo.UsersVo;

@Controller
public class AdminController {
	
	@Autowired
	UsersService userService;
	@Autowired
	BlogService blogService;
	@Autowired
	CategoryService cateService;

	@RequestMapping("/{id}/blog/adminBasic")
	public String adminBasic(@PathVariable(value = "id") String id, Model model, HttpSession session) {
		System.out.println("베이직");
		UsersVo sessionUser = (UsersVo) session.getAttribute("sessionUser");
		BlogVo blogVo = blogService.getBlog(sessionUser.getUserNo());
		model.addAttribute("blogVo", blogVo);
		System.out.println(blogVo.toString());
		return "blog/admin/blog-admin-basic";
	}

	@RequestMapping("{id}/blog/blogUpdate")
	public String BlogUpdate(@PathVariable(value = "id") String id, @RequestParam("blogTitle") String blogTitle,
			@RequestParam(value = "logo-file", required = false) MultipartFile logoFile, HttpSession session,
			@ModelAttribute BlogVo blogVo) {
		
		UsersVo sessionUser = (UsersVo) session.getAttribute("sessionUser");

		blogVo.setUserNo(sessionUser.getUserNo());
		blogVo.setBlogTitle(blogTitle);

		blogService.updateBlog(blogVo, logoFile);

		return "redirect:/" + id + "/blog/adminBasic";
	}

	@RequestMapping("{id}/blog/adminCategory")
	public String adminCategory(@PathVariable(value = "id") String id, Model model) {
		System.out.println("카테고리");
		getBlogTitle(id, model);
		return "blog/admin/blog-admin-cate";
	}

	@RequestMapping("{id}/blog/admin/writeForm")
	public String writeForm(@PathVariable("id") String id, HttpSession session, Model model) {
		getBlogTitle(id, model);
		UsersVo sessionUser = (UsersVo) session.getAttribute("sessionUser");
		
		List<CategoryVo> cateList = cateService.getList(sessionUser.getUserNo());
		model.addAttribute("cateList",cateList);
		return "blog/admin/blog-admin-write";
	}
	
	@RequestMapping("{id}/blog/admin/write")
	public String adminWrite(@PathVariable(value = "id") String id, 
							 @RequestParam("postTitle") String postTitle,
							 @RequestParam("postContent") String postContent,
							 @RequestParam("category") int cateNo) {
		
		blogService.postWrite(postTitle, postContent, cateNo);

		return "redirect:/{id}";
	}
	
	public void getBlogTitle(String id, Model model) {
		UsersVo usersVo = userService.getUser(id);
		model.addAttribute("id", id);

		BlogVo blogVo = blogService.getTitle(usersVo);
		model.addAttribute("blogVo", blogVo);
	}

}
