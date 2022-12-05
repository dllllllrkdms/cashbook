<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 로그인, 관리자 레벨 검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	if(request.getParameter("categoryNo")==null){ // 파라메타값 유효성 겁사
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
		return;
	}
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	Category categoryOne = null;
	CategoryDao categoryDao = new CategoryDao();
	categoryOne = categoryDao.selectCategoryOne(categoryNo);
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed " dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>updateCategoryList</title>
<meta name="description" content="Most Powerful &amp; Comprehensive Bootstrap 5 HTML Admin Dashboard Template built for developers!" />
<meta name="keywords" content="dashboard, bootstrap 5 dashboard, bootstrap 5 design, bootstrap 5">
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="/cashbook/resources/img/favicon/favicon.ico" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
  href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
  rel="stylesheet">

<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet" href="/cashbook/resources/vendor/fonts/boxicons.css" />
    

<!-- Core CSS -->
<link rel="stylesheet" href="/cashbook/resources/vendor/css/core.css" />
<link rel="stylesheet" href="/cashbook/resources/vendor/css/theme-default.css" />
<link rel="stylesheet" href="/cashbook/resources/css/demo.css" />

<!-- Vendors CSS -->
    <link rel="stylesheet" href="/cashbook/resources/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

<!-- Canonical SEO -->
   <link rel="canonical" href="https://themeselection.com/products/sneat-bootstrap-html-admin-template/">

<!-- Page CSS -->
<!-- Page -->
<link rel="stylesheet" href="/cashbook/resources/vendor/css/pages/page-auth.css">
<!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->
<script src="/cashbook/resources/vendor/libs/jquery/jquery.js"></script>
<script src="/cashbook/resources/vendor/libs/popper/popper.js"></script>
<script src="/cashbook/resources/vendor/js/bootstrap.js"></script>
<script src="/cashbook/resources/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

<script src="/cashbook/resources/vendor/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->

<!-- Main JS -->
<script src="/cashbook/resources/js/main.js"></script>

<!-- Page JS -->

<!-- Helpers -->
<script src="/cashbook/resources/vendor/js/helpers.js"></script>

<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="/cashbook/resources/js/config.js"></script>

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
			
			<!-- Content wrapper-->
			<div class="content-wrapper">
			
				<!-- Content -->
				<div class="container-xxl flex-grow-1 container-p-y">
					<h4 class="fw-bold py-3 mb-4">
					  <span class="text-muted fw-light">Admin /</span> category
					</h4>
					<div class="card">
						<div class="card-body">
							<form action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp" method="post">
								<div class="row mb-3">
									<div class="col-md-3">
										no <!-- 수정불가 -->
										<input type="text" name="categoryNo" value="<%=categoryOne.getCategoryNo()%>" readonly=readonly>
									</div>
								</div>
								<div class="row mb-3">
									<div class="col-md-3">
										수입/지출 <!-- 수정불가 -->
										<input type="text" name="categoryKind" value="<%=categoryOne.getCategoryKind()%>" readonly=readonly>
									</div>
								</div>
								<div class="row mb-3">
									<div class="col-md-3">
										<label class="form-label" for="categoryName">카테고리 이름</label>
										<input type="text" name="categoryName" value="<%=categoryOne.getCategoryName()%>">
									</div>
								</div>
									
										
									
								<button type="submit">등록</button>
							</form>
				
						</div>
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