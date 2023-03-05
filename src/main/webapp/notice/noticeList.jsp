<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null){ // 로그인 유효성검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 공지 출력
	int currentPage = 1; // 공지 페이징
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	int totalCount = noticeDao.totalCount(); // 공지 전체 수
	int lastPage = totalCount/rowPerPage;
	if(totalCount%rowPerPage!=0){ // 남은 글이 있으면 페이지+1
		lastPage+=1;
	}
	if(currentPage<1){ // 강제로 페이지를 첫페이지보다 작게 했을경우
		currentPage=1;
	}
	if(currentPage>lastPage){ // 강제로 페이지를 마지막페이지보다 크게 했을경우
		currentPage=lastPage;
	}
	
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>공지사항</title>
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/libs/apex-charts/apex-charts.css" />

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
   		 
			<!--User-->
			<div>
				<jsp:include page="/inc/userMenu.jsp"></jsp:include>
			</div>
			<!-- /User -->
			
			<!-- Content wrapper -->
			<div class="content-wrapper">
			
				<!-- Content -->
				<div class="container-xxl flex-grow-1 container-p-y">
					<h4 class="fw-bold py-3 mb-4">
					  <span class="text-muted fw-light">고객센터 /</span> 내 문의내역
					</h4>
					<div class="card">
						<div class="card-header">
							<span class="float-end"><a class="btn-sm btn-primary me-3" href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의하기</a></span>
						</div>
							<div class="card-body">
								<div class="card-body">
								
									<!-- 공지 출력 -->
									<table class="table">
										<thead>
											<tr>
												<th style="width: 8%">No</th>
												<th style="width: 75%">공지사항</th>
												<th style="width: 17%">등록일</th>
											</tr>
										</thead>
										<tbody >
										<%
											for(Notice n : noticeList){
										%>
											<tr>
												<td><%=n.getNoticeNo()%></td>	
												<td><%=n.getNoticeMemo()%></td>	
												<td><%=n.getCreatedate().substring(0,10)%></td>	
											</tr>
										<%
											}
										%>
										</tbody>
									</table>
									
								</div>
							</div>
							
							<div class="card-footer">
							<!-- noticeList 페이징 -->
							<nav aria-label="Page navigation">
					            <ul class="pagination justify-content-center">
									<li class="page-item prev">
										<a class="page-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1"><i class="tf-icon bx bx-chevrons-left"></i></a>
									</li>
									<%
										if(currentPage>1){
									%>
											<li class="page-item">
												<a class="page-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>"><i class='bx bx-chevron-left'></i></a>
											</li>
									<% 
										}
									%>
									<li class="page-item active">
										<a class="page-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a>
									</li>
									<%
										if(currentPage<lastPage){
									%>
											<li class="page-item">
												<a class="page-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>"><i class='bx bx-chevron-right' ></i></a>
											</li>
									<% 
										}
									%>
									<li class="page-item next">
										<a class="page-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>"><i class="tf-icon bx bx-chevrons-right"></i></a>
									</li>
					            </ul>
					        </nav>
							<!-- /noticeList 페이징 -->
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