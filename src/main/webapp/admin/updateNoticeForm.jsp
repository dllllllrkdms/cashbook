<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 관리자 페이지 접근조건
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	if(request.getParameter("noticeNo")==null){ // 파라메타값 유효성 검사
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
		return;
	}
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = noticeDao.selectNoticeOne(noticeNo); // Model 호출
	
	// View
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeForm</title>
</head>
<body>
	<!-- 로그인 정보 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<div>
		<form action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp" method="post">
			<table>
				<tr>
					<th>No</th> <!-- 수정불가 -->
					<td><input type="text" name="noticeNo" value="<%=notice.getNoticeNo()%>" readonly=readonly></td>
				</tr>
				<tr>
					<th>공지내용</th>
					<td><input type="text" name="noticeMemo" value="<%=notice.getNoticeMemo()%>"></td>
				</tr>
				<tr>
					<th>생성일자</th>
					<td><%=notice.getCreatedate()%></td>
				</tr>
			</table>
			<button type="submit">등록</button>
		</form>
	</div>
</body>
</html>