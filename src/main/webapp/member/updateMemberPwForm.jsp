<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// C
	if(session.getAttribute("loginMember")==null){ // 로그인 된 사람만 접근 가능
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>updateMemberPwForm</title>
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/img/favicon/favicon.ico" />
<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/fonts/boxicons.css" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">

<!-- Core CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/core.css" class="template-customizer-core-css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/theme-default.css" class="template-customizer-theme-css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
<link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />

<script src="<%=request.getContextPath()%>/resources/js/config.js"></script>

<!-- Helpers -->
<script src="<%=request.getContextPath()%>/resources/vendor/js/helpers.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID" async ></script>
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css"> <!-- Custom css -->
</head>
<body>
<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar ">
	<div class="layout-container">
	
		<!-- Menu -->
  		<div>	
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		<!-- /Menu -->
		
		<!-- Layout container -->
   		<div class="layout-page">
		
			<!-- User -->
			<div>
				<jsp:include page="/inc/userMenu.jsp"></jsp:include>
			</div>
			<!-- /User -->
			
			<!-- Content wrapper -->
			<div class="content-wrapper">
				<!-- Content -->
				<div class="container-xxl flex-grow-1 container-p-y">
					
					<h4 class="fw-bold py-3 mb-4">
					  <span class="text-muted fw-light">계정 관리 /</span> 비밀번호 변경
					</h4>
				
					<!-- Navbar pills -->
					<div>
						<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
					</div>
					<!-- /Navbar pills -->
					
		          	<!-- Form -->
		          	<div class="card mb-4">
		          		<div class="card-body">
		          			<h5 class="card-header">비밀번호 변경</h5>
	          				<div class="card-body">
								<form action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp" id="updateMemberPwForm" method="post">
									<input type="hidden" name="memberId" value="<%=memberId%>">
									<div class="row">
										<div class="mb-3 col-md-6 form-password-toggle"> <!-- form-password-toggle X -->
											<label class="form-label" for="memberPw">현재 비밀번호</label>
											<div class="input-group input-group-merge">
												<input type="password" class="form-control" id="pw" name="memberPw" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" />
												<!-- <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span> -->
											</div>
										</div>
									</div>
									<div class="row">
										<div class="mb-3 col-md-6 form-password-toggle"> <!-- form-password-toggle X -->
											<label class="form-label" for="newMemberPw">새 비밀번호</label>
											<div class="input-group input-group-merge">
												<input type="password" class="form-control" id="password" name="newMemberPw" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" />
												<!-- <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span> -->
											</div>
										</div>
										<div class="mb-3 col-md-6 form-password-toggle"> <!-- form-password-toggle X -->
											<label class="form-label" for="checkPw">비밀번호 확인</label>
											<div class="input-group input-group-merge">
												<input type="password" class="form-control" id="checkPw" name="checkPw" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" />
												<!-- <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span> -->
											</div>
										</div>
									</div>
									<div class="col-12 mb-3 mt-4">
										<button type="button" id="submitBtn" class="btn btn-primary me-2">비밀번호 변경</button>
										<button type="reset" class="btn btn-outline-secondary me-2">취소</button>
									</div>
								</form>
							</div>
						</div>
					</div>
					<!-- /Form -->
												
				</div>
				<!-- /Content -->
				
				<!-- Footer -->
				<div>
					<jsp:include page="/inc/footer.jsp"></jsp:include>
				</div>
				<!-- /Footer -->
				
			</div>
			<!-- /Content wrapper -->
		</div>
		<!-- /Layout container -->
		
		<!-- Overlay -->
    	<div class="layout-overlay layout-menu-toggle"></div>
		
	</div>
</div>
<!-- /Layout wrapper -->


<!-- custom js -->
<script src="<%=request.getContextPath()%>/script/account.js"></script>
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