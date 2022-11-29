<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	Member loginMember=(Member)session.getAttribute("loginMember");
	if(loginMember==null){ // 로그인 유효성검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String memberId = loginMember.getMemberId();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertHelpForm</title>
</head>
<body>
	<!-- 로그인 정보 출력 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<h1>고객센터</h1>
	<div>
		<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
			<input type="hidden" name="memberId" value="<%=memberId%>">
			<table>
				<tr>
					<th>문의내용</th>
					<td><textarea cols="50" rows="4" name="helpMemo"></textarea></td>
				</tr>
			</table>
			<button type="submit">등록</button>
		</form>
	</div>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>