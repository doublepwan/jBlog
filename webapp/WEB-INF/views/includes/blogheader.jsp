<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


			
			
			
			
			
			<!-- 블로그 해더 -->
		<div id="header">
		<c:choose>
			<c:when test="${empty blogVo }">
				<h1>unnamed 블로그</h1>
			</c:when>
			
			<c:otherwise>
				<h1><a href="${pageContext.request.contextPath }/${sessionUser.id}">${blogVo.blogTitle }</a></h1>
			</c:otherwise>
		</c:choose>
			<ul>
				<c:choose>
					<c:when test="${empty sessionUser }">
						<li><a href="${pageContext.request.contextPath }/main">메인페이지</a></li>
						<li><a href="${pageContext.request.contextPath }/users/loginform">로그인</a></li>
						<li><a href="${pageContext.request.contextPath }/users/joinform">회원가입</a></li>
					</c:when>

					<c:otherwise>
						<li>${sessionUser.id } <a href="${pageContext.request.contextPath }/users/logout">로그아웃</a></li>
						<li><a href="${pageContext.request.contextPath }/${sessionUser.id }/blog/adminBasic">내 블로그 관리</a></li>
						<li><a href="${pageContext.request.contextPath }/main">메인페이지</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		<!-- /블로그 해더 -->