<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberOne</title>
</head>
<body>
	<!-- 로그인 정보 -->
	<div>
		<jsp:include page="/inc/userMenu.jsp"></jsp:include>
	</div>
	<table>
		<tr>
			<td>ID</td>
			<td><%=loginMember.getMemberId()%></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%=loginMember.getMemberName()%></td>
		</tr>
	</table>
	<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">회원정보수정</a>
	<a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp">비밀번호 변경</a>
	<a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">회원 탈퇴</a>
</body>
</html>