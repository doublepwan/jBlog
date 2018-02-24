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
		      	<table class="admin-cat">
			      	<tr id="bar">
						<th>번호</th>
						<th>카테고리명</th>
						<th>포스트 수</th>
						<th>설명</th>
						<th>삭제</th>
					</tr>
				</table>
      			<h4 class="n-c">새로운 카테고리 추가</h4>
		      	<table id="admin-cat-add">
		      		<tr>
		      			<td class="t">카테고리명</td>
		      			<td><input type="text" name="name"></td>
		      		</tr>
		      		<tr>
		      			<td class="t">설명</td>
		      			<td><input type="text" name="desc"></td>
		      		</tr>
		      		<tr>
		      			<td class="s">&nbsp;</td>
		      			<td><input type="submit" value="카테고리 추가"></td>
		      		</tr>      		      		
		      	</table> 
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
		fetchList(userNo);
	});
	
	function fetchList(userNo){ 
		$.ajax({
			url : "${pageContext.request.contextPath}/{sessionUser.id}/blog/cate/list",
			type : "post",
			data : {userNo : userNo},
			dataType : "json",
			success : function(cateList){
				for(var i = 0; i < cateList.length; i++) {
					render(cateList[i], "up");
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	}
	
	function render(categoryVo, updown){
		var str="";
		str += "<tr id='tr-" + categoryVo.cateNo + "'>";
		str += "	<th>[" + categoryVo.cateNo + "]</th>";
		str += "	<th>" + categoryVo.cateName + "</th>";
		str += "	<th>"+ categoryVo.postCount +"</th>";
		str += "	<th>"+categoryVo.description+"</th>";
		str += "	<th><img class ='delete-cate'  data-no='"+categoryVo.cateNo+"'src='${pageContext.request.contextPath}/assets/images/delete.jpg'></th>"
		str += "</tr>";
		
		if(updown == "up")
			$(".admin-cat").append(str);
		else if(updown == "down")
			$(".admin-cat").prepend(str);
		else
			console.log("updown 오류");
	}
	
	$("input[type=submit]").on("click", function(){ 
		var categoryVo = {
				'userNo' : ${sessionUser.userNo},
				'cateName' : $("[name=name]").val(),
				'description' : $("[name=desc]").val()
		}
		
		$.ajax({
			url : "${pageContext.request.contextPath}/{sessionUser.id}/blog/cate/insertApi",
			type : "post",
			data : JSON.stringify(categoryVo),
			contentType : "application/json; charset=UTF-8",

			dataType : "json",
			success : function(categoryVo){
				render(categoryVo, "up");
				$("[name=name]").val("");
				$("[name=desc]").val("");
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});
	
	$(".admin-cat").on("click", ".delete-cate", function(){
		var cateNo =$(this).data("no") 
		
		$.ajax({
			url : "${pageContext.request.contextPath}/{sessionUser.id}/blog/cate/deleteApi",
			type : "post",
			data : {cateNo : cateNo},
			//contentType : "application/json; charset=UTF-8",

			dataType : "json",
			success : function(result){
				if(result==1){
					$("#tr-"+cateNo).remove();
				};
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});	
	
</script>

</html>