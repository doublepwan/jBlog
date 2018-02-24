<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="/jblog/assets/css/jblog.css">
</head>
<body>
	<div class="center-content">
		
		<!-- 메인해더 -->
			<c:import url="/WEB-INF/views/includes/mainheader.jsp"></c:import>
 		<!-- /메인해더 -->
		
		<form class="login-form" method="post" action="${pageContext.request.contextPath }/users/login">
      		<label>아이디</label> 
      		<input type="text" name="id" id="id">
      		
      		<label>패스워드</label> 
      		<input type="password" name="password" id="password">
      	<c:if test="${param.result == 'fail' }">	
      		<p class="form-error">
				로그인 실패 다시 입력해주세요
			</p>
		</c:if>	
      		<input type="submit" value="로그인">
		</form>
		
	</div>
	<div id="dialog-message" title="" style="display:none">
  		<p></p>
	</div>
</body>
</html>