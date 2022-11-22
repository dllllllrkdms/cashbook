<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// Controller 
	if(session.getAttribute("loginMember")!=null){ // 로그인 상태에선 이 페이지 접근불가
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
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
		<table>
			<tr>
				<td>ID</td>
				<td><input type="text" name="memberId"></td>
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
				<td>이름</td>
				<td><input type="text" name="memberName"></td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">회원가입</button></td>
			</tr>
		</table>
	</form>
</body>
</html>