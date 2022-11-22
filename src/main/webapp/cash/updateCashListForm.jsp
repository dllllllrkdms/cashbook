<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// Controller
	if(session.getAttribute("loginMember")==null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCashListForm</title>
</head>
<body>
	<div>
		<form action="<%=request.getContextPath()%>/cash/updateCashListAction.jsp" method="post">
			<table border="1">
				<tr>
					<td>
					
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>