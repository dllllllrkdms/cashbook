<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>memberOne</title>
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
			
			<!-- Content wrapper-->
			<div class="content-wrapper">
				<!-- Content -->
				<div class="container-xxl flex-grow-1 container-p-y">
				
					<h4 class="fw-bold py-3 mb-4">
					  <span class="text-muted fw-light">계정 관리 /</span> 내 프로필
					</h4>
					
					<!-- Navbar pills -->
					<div>
						<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
					</div>
					<!-- /Navbar pills -->
					
					<!-- User Profile -->
					<div class="card mb-4">
						<!-- Profile -->
						<div class="card-body">
							<div class="row">
   								<small class="text-muted text-uppercase">About</small>
								<ul class="list-unstyled mb-4 mt-3">
								  <li class="d-flex align-items-center mb-3"><i class="bx bx-user"></i><span class="fw-semibold mx-2">이름: </span><span><%=loginMember.getMemberName()%></span></li>
								  <li class="d-flex align-items-center mb-3"><i class='bx bx-at'></i><span class="fw-semibold mx-2">ID: </span><span><%=loginMember.getMemberId()%></span></li>
								</ul>
							</div>
						</div>
					</div>
					<a class="nav-link" href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp"><span class="fw-semibold mx-2">회원 탈퇴<i class='bx bx-chevron-right'></i></span></a>
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