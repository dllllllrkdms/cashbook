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
<!-- Favicons -->
<link href="resources/img/favicon.png" rel="icon">
<link href="resources/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="resources/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
<link href="resources/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="resources/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="resources/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="resources/vendor/simple-datatables/style.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="resources/css/sb-admin-2.css" rel="stylesheet">
<link href="resources/css/style.css" rel="stylesheet">
</head>
<body class="bg-gradient-primary">
	<!-- 공지(5개) 목록 페이징 -->
	<div class="container">
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
		<div class="row justify-content-center">
			<div class="text-center">
				<h1 class="h4 text-gray-900 mb-4">로그인</h1>
			</div>
			<div>
				<!-- 로그인 폼 -->
				<div><%=msg%></div>
				<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post" class="user">
					<table>
						<tr class="form-group">
							<th>ID</th>
							<td><input type="text" name="memberId" class="form-control form-control-user"></td>
						</tr>
						<tr class="form-group">
							<th>PW</th>
							<td><input type="password" name="memberPw" class="form-control form-control-user"></td>
						</tr>
						<tr class="form-group">
							<td colspan="2"><button type="submit" class="btn btn-primary btn-user btn-block">로그인</button></td>
						</tr>
					</table>
				</form>
				<hr>
				<div class="text-center">
					<a href="<%=request.getContextPath()%>/insertMemberForm.jsp" class="small">회원가입</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>