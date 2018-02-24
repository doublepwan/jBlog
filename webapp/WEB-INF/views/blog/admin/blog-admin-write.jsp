<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>

<title>JBlog</title>
<link rel="stylesheet" href="/jblog/assets/css/jblog.css">
</head>
<body>

	<div id="container">
		
		<!-- 블로그 해더 -->
			<c:import url="/WEB-INF/views/includes/blogheader.jsp"></c:import>
		<!-- /블로그 해더 -->
		
		<div id="wrapper">
			<div id="content" class="full-screen">

				<ul class="admin-menu">
					<li><a href="${pageContext.request.contextPath }/${sessionUser.id }/blog/adminBasic">기본설정</a></li>
					<li><a href="${pageContext.request.contextPath }/${sessionUser.id }/blog/adminCategory">카테고리</a></li>
					<li class="selected"><a href="${pageContext.request.contextPath }/${sessionUser.id }/blog/admin/writeForm">글작성</a></li>
				</ul>
				
				
				<form action="${pageContext.request.contextPath}/${sessionUser.id}/blog/admin/write" method="post">
			      	<table class="admin-cat-write">
			      		<tr>
			      			<td class="t">제목</td>
			      			<td>
			      				<input type="text" size="60" name="postTitle">
				      			<select name="category">
				      				
				      			</select>
				      		</td>
			      		</tr>
			      		<tr>
			      			<td class="t">내용</td>
			      			<td><textarea name="postContent"></textarea></td>
			      		</tr>
			      		<tr>
			      			<td>&nbsp;</td>
			      			<td class="s"><input type="submit" value="포스트하기"></td>
			      		</tr>
			      	</table>
				</form>
			</div>
		</div>
		
		<!-- 푸터 -->
		<div id="footer">
			<p>
				<strong>Spring 이야기</strong> is powered by JBlog (c)2018
			</p>
		</div>
		<!-- 푸터 -->
		
	</div>
</body>

<script type="text/javascript">

	$(document).ready(function(){
		var userNo = ${sessionUser.userNo};
		fetchCateList(userNo);
	});
	
	function fetchCateList(userNo){ 
		$.ajax({
			url : "${pageContext.request.contextPath}/${sessionUser.id}/blog/cate/list",
			type : "post",
			data : {userNo : userNo},
			dataType : "json",
			success : function(cateList){
				for(var i = 0; i < cateList.length; i++) {
					render(cateList[i]);
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});	
	}
	
	function render(categoryVo){
		var str="";
		str += "<option value="+categoryVo.cateNo+">"+categoryVo.cateName+"</option>";
		
		$("[name=category]").append(str);
	}
	
</script>
</html>