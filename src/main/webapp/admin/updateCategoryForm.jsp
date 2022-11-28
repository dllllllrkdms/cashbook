<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 로그인, 관리자 레벨 검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	if(request.getParameter("categoryNo")==null){ // 파라메타값 유효성 겁사
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
		return;
	}
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	Category categoryOne = null;
	CategoryDao categoryDao = new CategoryDao();
	categoryOne = categoryDao.selectCategoryOne(categoryNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCategoryForm</title>
</head>
<body>
	<!-- 로그인 정보 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<!-- notice contents -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<div>
		<form action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp" method="post">
			<table>
				<tr>
					<th>NO</th> <!-- 수정불가 -->
					<td><input type="text" name="categoryNo" value="<%=categoryOne.getCategoryNo()%>" readonly=readonly></td>
				</tr>
				<tr>
					<th>수입/지출</th> <!-- 수정불가 -->
					<td><input type="text" name="categoryKind" value="<%=categoryOne.getCategoryKind()%>" readonly=readonly></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="categoryName" value="<%=categoryOne.getCategoryName()%>"></td>
				</tr>
			</table>
			<button type="submit">등록</button>
		</form>
	</div>
</body>
</html>