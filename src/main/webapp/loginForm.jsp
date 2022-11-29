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
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="resources/img/favicon/favicon.ico" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
  href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
  rel="stylesheet">

<!-- Core CSS -->
<link rel="stylesheet" href="resources/vendor/css/core.css" />
<link rel="stylesheet" href="resources/vendor/css/theme-default.css" />
<link rel="stylesheet" href="resources/css/demo.css" />

<!-- Page CSS -->

<!-- Helpers -->
<script src="../assets/vendor/js/helpers.js"></script>

<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="../assets/js/config.js"></script>

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
	<!-- 공지(5개) 목록 페이징 -->
	<div>
		<table class="table">
			<tr>
				<th>No</th>
				<th>공지사항</th>
				<th>날짜</th>
			</tr>
			<%
				for(Notice n : noticeList){
			%>
				<tr>
					<td><%=n.getNoticeNo()%></td>	
					<td><%=n.getNoticeMemo()%></td>	
					<td><%=n.getCreatedate().substring(0,10)%></td>	
			<%
				}
			%>
		</table>
	</div>
	<div class="row">
		<div class="col-xl">
			<div class="card mb-4">
				<div class="card-header d-flex justify-content-between align-items-center">
					<h1 class="mb-0">로그인</h1>
					<div class="card-body">
						<!-- 로그인 폼 -->
						<div><%=msg%></div>
						<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
							<table>
								<tr class="mb-3">
									<th>ID</th>
									<td><input type="text" name="memberId"></td>
								</tr>
								<tr class="mb-3">
									<th>PW</th>
									<td><input type="password" name="memberPw"></td>
								</tr>
								<tr class="mb-3">
									<td colspan="2"><button type="submit">로그인</button></td>
								</tr>
							</table>
						</form>
						<hr>
						<div>
							<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>