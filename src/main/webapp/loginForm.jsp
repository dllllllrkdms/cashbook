<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// session(로그인) 유효성 검사
	if(session.getAttribute("loginMember")!=null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	String msg = "";
	if(request.getParameter("msg")!=null){
		msg = request.getParameter("msg");
	}
	int currentPage = 1; // 공지 페이징
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed " dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>loginForm</title>
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
<style>
	.authentication-wrapper {
		min-height: 70vh;
	}
</style>
<body>
	<!-- 공지(5개) 목록 페이징 --> <!-- 공지보기 누르면 공지가 나오게 -->
	<div>
		<table class="table table-sm">
			<thead>
				<tr>
					<th>No</th>
					<th>공지사항</th>
					<th>날짜</th>
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
	<!-- wrapper -->
	<div class="authentication-wrapper authentication-basic container-p-y">
		<div class="authentication-inner">
				
			<!-- Login form -->
		    <div class="card">
				<div class="card-body">
					<h2 class="card-header mb-2">sign in to cashbook</h2>
					<div class="card-body demo-vertical-spacing demo-only-element">
						<div><%=msg%></div>
						<form action="<%=request.getContextPath()%>/loginAction.jsp" class="mb-3" method="post">
							<div class="mb-3">
								<label class="form-label" for="id">ID</label>
								<input type="text" name="memberId" class="form-control" id="id" placeholder="email or username" aria-label="UserId" aria-describedby="memberId" autofocus/><!-- autofocus : 페이지가 로드될때 자동으로 포커스가 이동됨 -->
							</div>
							<div class="mb-3 form-password-toggle">
								<label class="form-label" for="password">Password</label>
								<div class="input-group input-group-merge">
									<input type="password" name="memberPw" class="form-control" id="password" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" aria-describedby="password">
									<!-- span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>	-->				
								</div>
							</div>
							<div class="mb-3 mt-3">
								<button type="submit" class="btn btn-primary d-grid w-100">로그인</button>
							</div>
						</form>
						<hr>
						<p class="text-center">		
							회원이 아니신가요?				
							<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
						</p>
					</div>
				</div>
			</div>
			<!-- /Login form -->
			
		</div>
	</div>
	<!-- /wrapper -->
	
	<!-- Footer -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
	<!-- /Footer -->
	
	<!-- Overlay -->
	<div class="layout-overlay layout-menu-toggle"></div>
</body>
</html>