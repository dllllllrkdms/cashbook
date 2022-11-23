<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// C
	if(session.getAttribute("loginMember")==null){ // 로그인 된 사람만 접근 가능
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemberPwForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=memberId%>">
		<table border="1">
			<tr>
				<td>현재비밀번호</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
			<tr>
				<td>새 비밀번호</td>
				<td><input type="password" name="newMemberPw"></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="checkPw"></td>
			</tr>
		</table>
		<button type="submit">비밀번호 변경</button>
	</form>
</body>
</html>