<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteMemberForm</title>
</head>
<body>
	<div>
		탈퇴하면 모든 정보(가계부, 회원정보)는 다 삭제됩니다. 삭제된 데이터는 복구할 수 없습니다. 탈퇴하시겠습니까?
		<form action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp" method="post">
			<table>
				<tr>
					<td>ID</td>
					<td><%=loginMember.getMemberId()%></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name="memberPw"></td>
				</tr>
			</table>
			<button type="submit">네</button>
		</form>
	</div>
</body>
</html>