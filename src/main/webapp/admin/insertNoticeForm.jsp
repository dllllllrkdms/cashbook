<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	//Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 관리자 페이지 접근조건
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertNoticeForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method="post">
		<div>문의내용</div>
		<div><textarea rows="4" name="noticeMemo"></textarea></div>
		<button type="submit">등록</button>
	</form>
</body>
</html>