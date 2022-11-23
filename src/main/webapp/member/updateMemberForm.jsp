<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// Controller
	if(session.getAttribute("loginMember")==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = "";
	if(request.getParameter("msg")!=null){
		msg = request.getParameter("msg");
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String memberName = loginMember.getMemberName();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemberForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post">
		<%=msg%>
		<table>
			<tr>
				<td>이름</td>
				<td><input type="text" name="memberName" value="<%=memberName%>"></td>
			</tr>
			<tr>
				<td>ID</td> <!-- id는 수정불가 -->
				<td><input type="text" name="memberId" value="<%=memberId%>" readonly=readonly></td> 
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>