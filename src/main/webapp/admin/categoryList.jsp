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
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>categoryList</title>
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
							<div class="card-body">
								<div class="mx-3">
									<p class="demo-inline-spacing">
										<button class="btn btn-primary me-1" type="button" data-bs-toggle="collapse" data-bs-target="#insertCategoryForm" aria-expanded="false" aria-controls="insertCategoryForm">
								            <i class="bx bx-plus me-2"></i><span class="fs-5">add</span>
								        </button>
							        </p>
						        </div>
								<!-- insertCategoryForm -->
								<div id="insertCategoryForm" class="accordion-collapse collapse" data-bs-parent="#insertCategoryForm">
									<div class="accordion-body">
										<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" id="form" method="post">
											<div class="row">
												<div class="col-mt-2 col-md-3">
													<label class="form-check-label form-label" for="radioCategory"> 카테고리 종류</label>
													<br>
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="categoryKind" value="수입" id="radioCategory">수입
													</div>
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="categoryKind" value="지출" id="radioCategory">지출
													</div>
												</div>
												<div class="col-mt-2 col-md-3 mb-3">
													<label class="form-label" for="cash">카테고리 이름</label>
													<input class="form-control" type="text" name="categoryName" id="cash">
												</div>
											</div>
											<div class="mb-3">
												<button type="button" id="submitBtn" class="btn btn-primary">등록</button>
												<button type="reset" class="btn btn-outline-secondary">취소</button>
											</div>
										</form>
										<hr class="m-0">
									</div>
								</div>	
				          		<!-- /insertCategoryForm -->
				          		
								<!-- CategoryList -->
								<table class="table">
									<thead>
										<tr>
											<th>no</th>
											<th>종류</th>
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