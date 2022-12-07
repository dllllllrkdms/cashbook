<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	// 모든 고객센터 문의사항 목록 출력
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 로그인 관리자레벨검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int currentPage=1; // 페이징
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage=10;
	int beginRow=(currentPage-1)*rowPerPage;
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(beginRow, rowPerPage);
	int count = helpDao.totalCountHelpList();
	int lastPage=count/rowPerPage;
	if(count%rowPerPage!=0){ // 올림
		lastPage+=1;
	}
	if(currentPage<1){ // 임의로 현재페이지를 첫페이지보다 작게했을경우
		currentPage=1;
	}
	if(currentPage>lastPage){ // 임의로 현재페이지를 첫페이지보다 크게했을경우
		currentPage=lastPage;
	}
	// View
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed " dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>helpList</title>
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
					  <span class="text-muted fw-light">Admin /</span> help
					</h4>
					<!-- Content -->
					<div class="card">
		          		<div class="card-body">
										
							<table class="table">
								<thead>
									<tr>
										<th style="width: 100px">no</th>
										<th>문의내용</th>
										<th style="width: 200px">문의날짜</th>
										<th>답변내용</th>
										<th style="width: 200px">답변날짜</th>
										<th style="width: 150px">추가/수정/삭제</th>
									</tr>
								</thead>
								<tbody>
									<%
										for(HashMap<String, Object> m : helpList){
									%>
											<tr>
												<td><%=m.get("helpNo")%></td>
												<td><%=m.get("helpMemo")%></td>
												<td><%=m.get("helpCreatedate")%></td>
												<%
													if(m.get("commentMemo")==null){ // 답변이 달리지 않은 문의는 답변추가
												%>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td><a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">답변추가</a></td>
												<%
													}else{ // 답변이 달린 문의글은 수정/삭제
												%>
														<td><%=m.get("commentMemo")%></td>
														<td><%=m.get("commentCreatedate")%></td>
														<td>
															<div class="dropdown">
																<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown"><i class="bx bx-dots-vertical-rounded"></i></button>
																<div class="dropdown-menu">
																	<a class="dropdown-item" href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>"><i class="bx bx-edit-alt me-1"></i> 수정</a>
																	<a class="dropdown-item" href="<%=request.getContextPath()%>/admin/deleteComment.jsp?commentNo=<%=m.get("commentNo")%>"><i class="bx bx-trash me-1"></i> 삭제</a>
																</div>
														    </div>
														</td>
												<%
													}
												%>
											</tr>
									<%
										}
									%>
								</tbody>
							</table>
							
						</div>
						
						<div class="card-footer">
							<!-- helpList 페이징 -->
							<nav aria-label="Page navigation">
					            <ul class="pagination justify-content-center">
									<li class="page-item prev">
										<a class="page-link" href="<%=request.getContextPath()%>/admin/helpList.jsp?currentPage=1"><i class="tf-icon bx bx-chevrons-left"></i></a>
									</li>
									<%
										if(currentPage>1){
									%>
											<li class="page-item">
												<a class="page-link" href="<%=request.getContextPath()%>/admin/helpList.jsp?currentPage=<%=currentPage-1%>"><i class='bx bx-chevron-left'></i></a>
											</li>
									<% 
										}
									%>
									<li class="page-item active">
										<a class="page-link" href="<%=request.getContextPath()%>/admin/helpList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a>
									</li>
									<%
										if(currentPage<lastPage){
									%>
											<li class="page-item">
												<a class="page-link" href="<%=request.getContextPath()%>/admin/helpList.jsp?currentPage=<%=currentPage+1%>"><i class='bx bx-chevron-right' ></i></a>
											</li>
									<% 
										}
									%>
									
									<li class="page-item next">
										<a class="page-link" href="<%=request.getContextPath()%>/admin/helpList.jsp?currentPage=<%=lastPage%>"><i class="tf-icon bx bx-chevrons-right"></i></a>
									</li>
					            </ul>
					        </nav>
							<!-- /helpList 페이징 -->
						</div>
						
					</div>
					<!-- /Content -->
						
					<!-- Footer -->
					<div>
						<jsp:include page="/inc/footer.jsp"></jsp:include>
					</div>
					<!-- /Footer -->
				
				</div>	
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
</body>
</html>