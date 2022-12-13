<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// Controller 
	if(session.getAttribute("loginMember")!=null){ // 로그인(session) 유효성 검사
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	String msg = ""; 
	if(request.getParameter("msg")!=null){
		msg = request.getParameter("msg");
	}
	String idDupMsg = ""; // 아이디 중복확인 메세지
	if(request.getParameter("idDupMsg")!=null){
		idDupMsg = request.getParameter("idDupMsg");
	}
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed " dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>insertMemberForm</title>
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/img/favicon/favicon.ico" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
  href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
  rel="stylesheet">

<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/fonts/boxicons.css" />
    

<!-- Core CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/core.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/theme-default.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

<!-- Canonical SEO -->
<link rel="canonical" href="https://themeselection.com/products/sneat-bootstrap-html-admin-template/">

<!-- Page CSS -->
<!-- Page -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/pages/page-auth.css">

<!-- Helpers -->
<script src="<%=request.getContextPath()%>/resources/vendor/js/helpers.js"></script>

<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="<%=request.getContextPath()%>/resources/js/config.js"></script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async="async" src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
window.dataLayer = window.dataLayer || [];

function gtag() {
  dataLayer.push(arguments);
}
gtag('js', new Date());
gtag('config', 'GA_MEASUREMENT_ID');
</script>
<!-- Custom notification for demo -->
<!-- beautify ignore:end -->
</head>
<body>
<div class="authentication-wrapper authentication-basic container-p-y">
	<div class="authentication-inner">
		
		<!-- login form -->
	    <div class="card">
			<div class="card-body">
				<h2 class="card-header mb-2">sign in to cashbook</h2>
					<div class="card-body demo-vertical-spacing demo-only-element">
						<div><%=msg%></div>
						<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" class="mb-3" method="post">
							<div class="mb-3">
								<label class="form-label" for="username">USERNAME</label>
								<input type="text" name="memberName" class="form-control" id="username" placeholder="이름을 입력하세요" aria-label="username" aria-describedby="memberName" autofocus/><!-- autofocus : 페이지가 로드될때 자동으로 포커스가 이동됨 -->
							</div>
							<div class="mb-3">
								<label class="form-label" for="id">ID</label> <!-- 중복검사 -->
								<input type="text" name="memberId" class="form-control" id="id" placeholder="ID를 입력하세요" aria-label="userId" aria-describedby="memberId" autofocus/><!-- autofocus : 페이지가 로드될때 자동으로 포커스가 이동됨 -->
							</div>
							<div class="mb-3 form-password-toggle"> <!-- form-password-toggle X -->
								<label class="form-label" for="password">Password</label>
								<div class="input-group input-group-merge">
									<input type="password" name="memberPw" class="form-control" id="password" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" aria-describedby="password">
									<!-- span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>	-->				
								</div>
							</div>
							<div class="mb-3 form-password-toggle"> <!-- form-password-toggle X -->
								<label class="form-label" for="checkPw">Password</label>
								<div class="input-group input-group-merge">
									<input type="password" name="checkPw" class="form-control" id="checkPw" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" aria-describedby="password">
									<!-- span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>	-->				
								</div>
							</div>
							<div class="mb-3 mt-3">
								<button type="submit" class="btn btn-primary d-grid w-100">회원가입</button>
							</div>
						</form>
						<hr>
						<p class="text-center">	
							이미 회원이신가요?					
							<a href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a>
						</p>
					</div>
				</div>
			</div>
			<!-- /Login form -->
		</div>
	</div>
	
<!-- build:js assets/vendor/js/core.js -->
<script src="<%=request.getContextPath()%>/resources/vendor/libs/jquery/jquery.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/libs/popper/popper.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/js/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>


<script src="<%=request.getContextPath()%>/resources/vendor/js/menu.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->
<script src="<%=request.getContextPath()%>/resources/vendor/libs/apex-charts/apexcharts.js"></script>
<!-- Main JS -->
<script src="<%=request.getContextPath()%>/resources/js/main.js"></script>

<!-- Page JS -->
<script src="<%=request.getContextPath()%>/resources/js/dashboards-analytics.js"></script>
	
	
</body>
</html>