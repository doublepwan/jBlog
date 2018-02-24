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
		<!-- 블로그 해더 -->
		
		<div id="wrapper">
			<div id="content">
				<div class="blog-content">
					<h4 class="title">  </h4> 
					
					<p class="content">
						
					<p>
				</div>
				<ul class="blog-list"><!-- 여기에 포스트 리스트 제목, 등록일 -->
				
				</ul>
			</div>
		</div>

		<div id="extra">
			<div class="blog-logo">
				<c:choose>
			      	<c:when test="${empty blogVo.logoFile}">
			      		<td><img src="/jblog/assets/images/spring-logo.jpg"></td>
			      	</c:when>
			      	<c:otherwise>
				    	<td><img src="${pageContext.request.contextPath}/upload/${blogVo.logoFile}"></td>
				    </c:otherwise>
			    </c:choose>
			</div>
		</div>

		<div id="navigation">
			<h2>카테고리</h2><!-- cateTitle -->
			<ul>
				<c:forEach items="${cateList}" var="cateVo" varStatus="status">
					<li>
						<a href='javascript:fetchPostList(${id}, ${cateVo.cateNo})'>${cateVo.cateName}</a>
					</li>
				</c:forEach>
			</ul>
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

	var newestPost;
	
	$(document).ready(function(){
		var id = ${id};
		
		init(id);
	});

	function init(id){
		fetchPostList(id, 0);
	}
	
	function fetchPostList(id, cateNo){ 
		$.ajax({
			url : "${pageContext.request.contextPath}/{id}/blog/postList",
			type : "post",
			data : {id : id, cateNo : cateNo},
			dataType : "json",
			success : function(poList){
				$(".blog-list").empty();
				
				if(poList.length == 0){
					$(".title").text("등록된 글이 없습니다.");
					$(".content").text("");
				} else{
					for(var i = 0; i < poList.length; i++) {
							render_postlist(poList[i]);
						}

						showPost(poList[0]);
					}
				},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	}
	
	function render_postlist(postVo){
		var str="";
		str += "<li>";
		str += "	<a href='javascript:getPost("+postVo.postNo+")'>"+postVo.postTitle+"</a>";
		str += "	<span>"+postVo.regDate+"</span>";
		str += "</li>";	

		$(".blog-list").append(str);
	}
	
	function showPost(postVo){ 
		$(".title").text(postVo.postTitle);
		var content = postVo.postContent;
		$(".content").html(content);
		curPostNo = postVo.postNo;
	}
	
	function getPost(postNo){ 
		$.ajax({
			url : "${pageContext.request.contextPath}/{id}/blog/getPost",
			type : "post",
			data : {postNo : postNo},
			dataType : "json",
			success : function(postVo){
				if(postVo != null){
					showPost(postVo);
				}
				else{
					$(".title").text("등록된 글이 없습니다.");
					$(".content").text("");
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	}
	
</script>
</html>