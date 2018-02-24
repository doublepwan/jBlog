package com.javaex.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.BlogVo;
import com.javaex.vo.CategoryVo;
import com.javaex.vo.PostVo;


@Repository
public class BlogDao {

	@Autowired
	SqlSession sqlsession;

	public void insertBlog(int userNo) {
		sqlsession.insert("blog.insertBlog", userNo);
	}

	public BlogVo getBlog(int userNo) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("userNo", userNo);
		return sqlsession.selectOne("blog.getBlog", userNo);
	}

	public void updateBlog(BlogVo blogVo) {
		sqlsession.update("blog.updateBlog", blogVo);
	}

	public void postWrite(Map<String, Object> pMap) {
		sqlsession.insert("post.write", pMap);
	}

	public PostVo getViewPost(int postNo) {
		PostVo postVo = sqlsession.selectOne("post.getViewPost", postNo);
		return postVo;
	}

	public BlogVo getTitle(int userNo) {
		BlogVo blogVo = sqlsession.selectOne("blog.getTitle", userNo);
		return blogVo;
	}

	public List<CategoryVo> getCateByUserNo(int userNo) {
		return sqlsession.selectList("category.getCateByUserNo", userNo);
	}

	public Map<String, Object> getBlog(String id) {
		return sqlsession.selectOne("blog.getBlogById", id);
	}

	public List<PostVo> getPostList(int userNo, int cateNo) {
		Map<String, Integer> bmMap = new HashMap<>();
		bmMap.put("userNo", userNo);
		bmMap.put("cateNo", cateNo);
		return sqlsession.selectList("post.postList", bmMap);
	}

}
