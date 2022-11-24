<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// Controller 
	if(session.getAttribute("loginMember")!=null){ // 로그인(session) 유효성 검사
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	String msg = ""; 
	if(request.getParameter("msg")!=null){
		msg = request.getParameter("msg");
	}
	String idDupMsg = ""; // 아이디 중복확인 메세지
	if(request.getParameter("idDupMsg")!=null){
		idDupMsg = request.getParameter("idDupMsg");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertMemberForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
		<%=msg%>
		<table>
			<tr>
				<td>이름</td>
				<td><input type="text" name="memberName"></td>
			</tr>
			<tr>
				<td>ID</td>
				<td><input type="text" name="memberId"><%=idDupMsg%></td>
			</tr>
			<tr>
				<td>PW</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="checkPw"></td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">회원가입</button></td>
			</tr>
		</table>
	</form>
</body>
</html>