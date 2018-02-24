package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.dao.BlogDao;
import com.javaex.dao.UsersDao;
import com.javaex.vo.BlogVo;
import com.javaex.vo.CategoryVo;
import com.javaex.vo.PostVo;
import com.javaex.vo.UsersVo;

@Service
public class BlogService {

	@Autowired
	BlogDao blogDao;
	@Autowired
	UsersDao usersDao;

	public BlogVo getBlog(int userNo) {
		return blogDao.getBlog(userNo);
	}

	public void updateBlog(BlogVo blogVo, MultipartFile logoFile) {

		String saveDir = "D:\\JAVAstudy\\upload";
		// 파일 정보 수집
		// original 파일이름
		String orgName = logoFile.getOriginalFilename();
		System.out.println(orgName);

		// 확장자 (.뭐뭐뭐)
		String exName = logoFile.getOriginalFilename().substring(logoFile.getOriginalFilename().lastIndexOf("."));
		System.out.println(exName);

		// 저장될 파일 이름
		// 파일명 중복을 피하기 위해서 UUID 사용
		String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exName;
		System.out.println(saveName);

		// 파일위치 (path)
		String filePath = saveDir + "\\" + saveName;
		System.out.println(filePath);

		// 파일 사이즈.getSize() (default로 byte단위)
		/*
		 * 8bit -> 1BYTE 
		 * 1024byte -> 1KB 
		 * 1024KB -> 1MB 
		 * 1024MB -> 1GB 
		 * 1024GB -> 1TB
		 */
		long fileSize = logoFile.getSize();
		int kbSize = (int) Math.ceil(fileSize / 1024.0);
		System.out.println(fileSize + " 바이트");
		System.out.println(kbSize + "kb");
		
		// 사용자가 업로드한 파일 카피
		try {
			
			byte[] fileData = logoFile.getBytes();
			OutputStream out = new FileOutputStream(saveDir + "\\" + saveName);
			BufferedOutputStream bout = new BufferedOutputStream(out);
			bout.write(fileData);
			
			if(bout != null) {
				bout.close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		blogVo.setLogoFile(saveName);
		blogDao.updateBlog(blogVo);
	}


	public List<PostVo> getPostList(String id, int cateNo) {
		int userNo = usersDao.getUserNo(id);
		return blogDao.getPostList(userNo, cateNo);
	}

	public PostVo getViewPost(int postNo) {
		PostVo postVo = blogDao.getViewPost(postNo);
		return postVo;
	}

	public Map<String, Object> getBlog(String id) {
		return blogDao.getBlog(id);
	}

	public List<CategoryVo> writeform(int userNo) {
		return blogDao.getCateByUserNo(userNo);
	}

	public void postWrite(String postTitle, String postContent, int cateNo) {
		
		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("postTitle", postTitle);
		pMap.put("postContent", postContent);
		pMap.put("cateNo", cateNo);
		blogDao.postWrite(pMap);
	}

	public BlogVo getTitle(UsersVo usersVo) {
		int userNo = usersVo.getUserNo();
		BlogVo blogVo = blogDao.getTitle(userNo);
		return blogVo;
	}

}
