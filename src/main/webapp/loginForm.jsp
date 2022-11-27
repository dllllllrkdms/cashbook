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
</head>
<body>
	<!-- 공지(5개) 목록 페이징 -->
	<div>
		<h4>공지사항</h4> <a href="">더보기</a>
		<table>
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
					<td><%=n.getCreatedate()%></td>	
			<%
				}
			%>
		</table>
		<div>
			
		</div>
	</div>
	<div>
		<!-- 로그인 폼 -->
		<div><%=msg%></div>
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<table>
			<tr>
				<th>ID</th>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<th>PW</th>
				<td><input type="password" name="memberPw"></td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">로그인</button></td>
			</tr>
		</table>
		<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
		</form>
	</div>
</body>
</html>