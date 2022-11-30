<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 로그인, 관리자레벨 검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCategoryForm</title>
</head>
<body>
	<!-- 로그인 정보 -->
	<div>
		<jsp:include page="/inc/userMenu.jsp"></jsp:include>
	</div>
	<!-- 관리자메뉴 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<h1>카테고리 추가</h1>
	<div>
		<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post">
			<table>
				<tr>
					<td>
						<input type="radio" name="categoryKind" value="수입">수입
						<input type="radio" name="categoryKind" value="지출">지출
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="categoryName">
					</td>
				</tr>
			</table>
			<button type="submit">등록</button>
		</form>
	</div>
</body>
</html>