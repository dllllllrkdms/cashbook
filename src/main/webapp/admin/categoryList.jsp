<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 로그인, 관리자레벨 유효성검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed " dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>categoryList</title>
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
			
			<!-- Content wrapper-->
			<div class="content-wrapper">
				<div class="container-xxl flex-grow-1 container-p-y">
					<h4 class="fw-bold py-3 mb-4">
					  <span class="text-muted fw-light">Admin /</span> category
					</h4>
					<!-- Content -->
					<div class="card">
						<div class="card-body">
						
							<div class="accordion accordion-without-arrow" id="accordionCategory">
								<div class="accordion-item">
										<div class="accordion-header col-xl-2 mb-3 m-4">
											<button type="button" class="collapsed btn btn-primary" data-bs-toggle="collapse" data-bs-target="#insertCategoryForm" aria-expanded="false" aria-controls="insertCategoryForm">
												<i class="bx bx-plus me-2"></i><span class="fs-5">add</span>
											</button>
										</div>
									<!-- insertCategoryForm -->
									<div id="insertCategoryForm" class="accordion-collapse collapse" data-bs-parent="#accordionCategory">
										<div class="accordion-body">
											<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post">
												<div class="row">
													<div class="col-mt-2 col-md-3">
														<label class="form-check-label form-label" for="categoryKind"> 카테고리 종류</label>
														<br>
														<div class="form-check form-check-inline">
															<input class="form-check-input" type="radio" name="categoryKind" value="수입" id="categoryKind">수입
														</div>
														<div class="form-check form-check-inline">
															<input class="form-check-input" type="radio" name="categoryKind" value="지출" id="categoryKind">지출
														</div>
													</div>
													<div class="col-mt-2 col-md-3">
														<label class="form-label" for="categoryName">카테고리 이름</label>
														<input class="form-control" type="text" name="categoryName" id="categoryName">
													</div>
												</div>
												<div class="mt-3 mb-3">
													<button type="submit" class="btn btn-primary">등록</button>
													<button type="reset" class="btn btn-outline-secondary">취소</button>
												</div>
											</form>
										</div>
									</div>	
								</div>
							</div>
			          		
							<!-- CategoryList -->
							<table class="table">
								<thead>
									<tr>
										<th style="width:70px">no</th>
										<th style="width:100px">종류</th>
										<th>이름</th>
										<th style="width:200px">최근수정일자</th>
										<th style="width:200px">생성일자</th>
										<th style="width:150px">수정/삭제</th>
									</tr>
								</thead>
								<tbody>
									<%
										for(Category c : categoryList){
									%>
											<tr>
												<td><%=c.getCategoryNo()%></td>
												<td><%=c.getCategoryKind()%></td>
												<td><%=c.getCategoryName()%></td>
												<td><%=c.getUpdatedate()%></td>
												<td><%=c.getCreatedate()%></td>
												<td>
													<div class="dropdown">
														<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown"><i class="bx bx-dots-vertical-rounded"></i></button>
														<div class="dropdown-menu">
															<a class="dropdown-item" href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>"><i class="bx bx-edit-alt me-1"></i> 수정</a>
															<a class="dropdown-item" href="<%=request.getContextPath()%>/admin/deleteCategory.jsp?categoryNo=<%=c.getCategoryNo()%>"><i class="bx bx-trash me-1"></i> 삭제</a>
														</div>
												    </div>
												</td>
											</tr>
									<%
										}
									%>	
								</tbody>
							</table>
						</div>
						<!-- /CategoryList -->
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