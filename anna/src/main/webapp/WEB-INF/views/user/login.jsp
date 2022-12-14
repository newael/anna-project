<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>안녕? 나야!</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
<script>
		
	
	if("${uidx}" != ""){
		alert("이미 로그인되어있습니다.");
		location.href="<%=request.getContextPath()%>/main.do";
	}
	
	console.log("${uidx}");


	function kakaoLogin(){
		$.ajax({
			url : "getKakaoAuthUrl.do",
			data : "keepLogin="+$("#keepLogin").prop("checked"),
			type : "get",
			success : function(Url){
				location.href = Url;
			},
			error : function(){
				console.log("실패");
			}
		});
	}
	
	console.log('${ userInfo }')
</script>
<style>
	html, body, .wrapper {
		width:100%;
		height:100%;
		padding:0px;
		margin:0px;
	}
	
	.row {
		margin:0px;
		padding:0px;
	}
	
	.vcenter-item{
	    display: flex;
	    align-items: center;
	}
		
	.loginBtn button, .kakaoLoginBtn button{
		width:100%;
		margin-top:12px;
	}
	
	.text-align-right {
		text-align:right;
		padding:0 3px;
	}
	
	.text-align-left {
		text-align:left;
		padding:0 5px;
	}
	

	
	h2 {
		font-size:1.5rem;
	}
	
	div {
		font-size:1rem;
	}
	
	.btn{
		font-size:1.2rem;
	}
	
	div input{
		hieght:1.2rem;
	}
	
	.box {
		
		margin:auto;
		border-radius:10px;
		padding:20px;
		color:white;
		background:#555;
	}
	
	.form-control {
		height:2rem;
		font-size:1rem;
	}
	
	@media all and (max-width:576px){
		.box, .container {
			width:95vw;
		}
		
		.container {
			padding:0;
		}
	}
	
	@media all and (min-width:577px){
		.box {
			width:350px;
		}
	}
</style>
</head>
<body>
	<div class="wrapper vcenter-item">
		<div class="container">
			<form id="loginFrm" action="login.do" method="post">
				<div>
					<div class="box">
						<h2 class="form-signin-heading">로그인</h2>
						<label for="inputEmail" class="sr-only">이메일</label> 
						<input type="email" id="inputEmail" class="form-control" name="user_email" placeholder="이메일" required autofocus>
						<label for="inputPassword" class="sr-only">비밀번호</label> 
						<input type="password" id="inputPassword" class="form-control" name="user_pwd" placeholder="비밀번호" required>
						<div style="padding:12px 5px;">
							<input type="checkbox" id="keepLogin" name="keepLogin" value="true"><label for="keepLogin" style="margin-left:10px; cursor:pointer;">로그인 유지</label>
						</div>
						<div class="find-join row">
							<div class="text-align-left col-8" ><span onclick="location.href='findPwd.do'" style="cursor:pointer;">비밀번호 찾기</span></div>
							<div class="text-align-right col-4"><span onclick="location.href='join.do'" style="cursor:pointer;">회원가입</span></div>
						</div>
						<div class="loginBtn">
							<button class="btn btn-lg btn-primary btn-block" type="submit" style="cursor:pointer;">로그인</button>
						</div>
						<div class="kakaoLoginBtn">
							<button class="btn btn-lg btn-primary btn-block" onclick="kakaoLogin()" type="button" style="cursor:pointer;">카카오로그인</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
