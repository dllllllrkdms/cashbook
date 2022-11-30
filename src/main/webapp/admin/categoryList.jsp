<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 로그인, 관리자레벨 유효성검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>categoryList</title>
</head>
<body>
	<!-- 로그인 정보 -->
	<div>
		<jsp:include page="/inc/userMenu.jsp"></jsp:include>
	</div>
	<!-- 관리자 메뉴 -->
	<div> 
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<!-- categoryList contents -->
	<h1>카테고리 목록</h1>
	<a href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">추가</a>
	<div>
		<table border="1">
			<tr>
				<th>No</th>
				<th>종류</th>
				<th>이름</th>
				<th>최근수정일자</th>
				<th>생성일자</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
				<%
					for(Category c : categoryList){
				%>
						<tr>
							<td><%=c.getCategoryNo()%></td>
							<td><%=c.getCategoryKind()%></td>
							<td><%=c.getCategoryName()%></td>
							<td><%=c.getUpdatedate()%></td>
							<td><%=c.getCreatedate()%></td>
							<td><a href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a></td>
							<td><a href="<%=request.getContextPath()%>/admin/deleteCategory.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
						</tr>
				<%
					}
				%>	
		</table>
	</div>
</body>
</html>