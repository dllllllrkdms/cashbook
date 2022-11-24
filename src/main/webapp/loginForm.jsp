<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// session(로그인) 유효성 검사
	if(session.getAttribute("returnMember")!=null){
		response.sendRedirect(request.getContextPath()+"/cashList.jsp");
		return;
	}
	String msg = "";
	if(request.getParameter("msg")!=null){
		msg = request.getParameter("msg");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
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