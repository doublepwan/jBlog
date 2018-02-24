<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<title>JBlog</title>
<link rel="stylesheet" href="/jblog/assets/css/jblog.css">
</head>
<body>
	<div class="center-content">
		
		<!-- 메인해더 -->
			<c:import url="/WEB-INF/views/includes/mainheader.jsp"></c:import>
 		<!-- /메인해더 -->
 		
		<form class="join-form" id="join-form" method="post" action="${pageContext.request.contextPath}/users/join">
			<label class="block-label" for="name">이름</label>
			<input type="text" name="userName"  value="" />
			
			<label class="block-label" for="id">아이디</label>
			<input type="text" id="idck" name="id"  value="" />
			<input id="btn-checkid" type="button" value="id 중복체크">
			<img id="img-checkid" style="display: none;" src="${pageContext.request.contextPath}/assets/images/check.png">
			<p class="form-error">
			</p>

			<label class="block-label" for="password">패스워드</label>
			<input type="password" name="password"  value="" />

			<fieldset>
				<legend>약관동의</legend>
				<input id="agree-prov" type="checkbox" name="agreeProv" value="y">
				<label class="l-float">서비스 약관에 동의합니다.</label>
			</fieldset>

			<input type="submit" value="가입하기">

		</form>
	</div>

</body>

<script type="text/javascript">
	$("#btn-checkid").on("click", function(){
		var id = $("#idck").val();
		console.log(id);
		
		var usersVo = {id: id};
		
		$.ajax({
			url : "${pageContext.request.contextPath }/users/idCheck",		
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(usersVo),
			dataType : "json",
			success : function(result){
				/*성공시 처리해야될 코드 작성*/
				console.log(result);
				if(result == true){
					$(".form-error").html("<strong>사용 가능한 아이디 입니다.</strong>").css("color","blue");
				}
				else{
					$(".form-error").html("<strong>사용 불가능한 아이디 입니다.</strong>").css("color","red");
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
		
	});
</script>
</html>