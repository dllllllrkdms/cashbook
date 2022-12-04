<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// Controller
	if(session.getAttribute("loginMember")==null){ // 로그인(session) 유효성검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = "";
	if(request.getParameter("msg")!=null){
		msg = request.getParameter("msg");
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String memberName = loginMember.getMemberName();
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed " dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>updateMemberForm</title>
<meta name="description" content="Most Powerful &amp; Comprehensive Bootstrap 5 HTML Admin Dashboard Template built for developers!" />
<meta name="keywords" content="dashboard, bootstrap 5 dashboard, bootstrap 5 design, bootstrap 5">
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
<!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->
<script src="<%=request.getContextPath()%>/resources/vendor/libs/jquery/jquery.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/libs/popper/popper.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/js/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

<script src="<%=request.getContextPath()%>/resources/vendor/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->

<!-- Main JS -->
<script src="<%=request.getContextPath()%>/resources/js/main.js"></script>

<!-- Page JS -->

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
		
					<!-- Navbar pills -->
					<div class="row">
					  <div class="col-md-12">
					    <ul class="nav nav-pills flex-column flex-sm-row mb-4">
					      <li class="nav-item"><a class="nav-link active" href="javascript:void(0);"><i class='bx bx-user'></i> Profile</a></li>
					      <li class="nav-item"><a class="nav-link" href=""><i class='bx bx-group'></i> Teams</a></li>
					      <li class="nav-item"><a class="nav-link" href=""><i class='bx bx-grid-alt'></i> Projects</a></li>
					      <li class="nav-item"><a class="nav-link" href=""><i class='bx bx-link-alt'></i> Connections</a></li>
					    </ul>
					  </div>
					</div>
					<!--/ Navbar pills -->
					
					<!-- Account -->
					<div class="card mb-4">
						<div class="card-body">
							<form action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post">
								<%=msg%>
								<div class="row">
									<div class="mb-3 col-md-6">
										<label for="name" class="form-label">이름</label>
										<input class="form-control" id="name" type="text" name="memberName" value="<%=memberName%>" autofocus />
									</div>
									<div class="mb-3 col-md-6">
										<label for="id" class="form-label">ID</label> <!-- 수정불가 -->
										<input class="form-control" id="id" type="text" name="memberId" value="<%=memberId%>" readonly=readonly/>
									</div>
									<div class="mb-3 col-md-6">
										<label for="password" class="form-label">비밀번호 확인</label>
										<input class="form-control" id="password" type="password" name="memberPw" />
									</div>
								</div>
								<div class="mt-2">
									<button type="submit" class="btn btn-primary me-2">수정</button>
									<button type="reset" class="btn btn-outline-secondary">취소</button> <!-- button type="reset" : form 입력 내용을 초기화 시킴 -->
								</div>
							</form>
						</div>		
					</div>
					<!-- /Account -->
					
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
</body>
</html>