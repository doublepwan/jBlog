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
					<li class="selected"><a href="${pageContext.request.contextPath }/${sessionUser.id }/blog/adminBasic">기본설정</a></li>
					<li><a href="${pageContext.request.contextPath }/${sessionUser.id }/blog/adminCategory">카테고리</a></li>
					<li><a href="${pageContext.request.contextPath }/${sessionUser.id }/blog/admin/writeForm">글작성</a></li>
				</ul>
				
				<form action="${pageContext.request.contextPath }/${sessionUser.id }/blog/blogUpdate" method="post" enctype="multipart/form-data">
	 		      	<table class="admin-config">
			      		<tr>
			      			<td class="t">블로그 제목</td>
			      			<td><input type="text" size="40" name="blogTitle" value=""></td>
			      		</tr>
			      		<tr>
			      			<td class="t">로고이미지</td>
			      			<c:choose>
			      			<c:when test="${empty blogVo.logoFile}">
			      				<td><img src="/jblog/assets/images/spring-logo.jpg"></td>
			      			</c:when>
			      			<c:otherwise>
				      			<td><img src="${pageContext.request.contextPath}/upload/${blogVo.logoFile}"></td>
				      		</c:otherwise>
			      			</c:choose>
			      		</tr>      		
			      		<tr>
			      			<td class="t">&nbsp;</td>
			      			<td><input type="file" name="logo-file" onchange="readURL(this)"></td>
			      		</tr>           		
			      		<tr>
			      			<td class="t">&nbsp;</td>
			      			<td class="s"><input type="submit" value="기본설정 변경"></td>      			
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

	function readURL(input) { 
		if (input.files && input.files[0]) { 
			var reader = new FileReader(); 
	
			reader.onload = function (e) { 
				$("img").attr('src', e.target.result); 
			}
			
			reader.readAsDataURL(input.files[0]); 
		} 
	}
	
</script>
</html>