<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	if(session.getAttribute("loginMember")==null){ // session(로그인) 유효성 검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String cashDate = null; 
	if(request.getParameter("cashDate")==null){ 
		Calendar today = Calendar.getInstance(); // 오늘날짜 
		int year = today.get(Calendar.YEAR);
		int month = today.get(Calendar.MONTH); // 1월:0, 12월:11
		int date = today.get(Calendar.DATE);
		cashDate = year+"-"+(month+1)+"-"+date;
	}else{
		cashDate = request.getParameter("cashDate");
	}
	if(request.getParameter("cashNo")==null){
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?cashDate="+cashDate);
		return;
	}
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	//System.out.println(cashDate);
	Member loginMember = (Member)session.getAttribute("loginMember"); // 로그인한 세션 불러오기
	String memberId = loginMember.getMemberId();
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCashListForm</title>
</head>
<body>
	<!-- 로그인 정보 출력 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<div>
		<form action="<%=request.getContextPath()%>/cash/updateCashListAction.jsp" method="post">
			<input type="hidden" name="cashNo" value="<%=cashNo%>">
			<input type="hidden" name="memberId" value="<%=memberId%>">
			<table border="1">
				<tr>
					<td><input type="text" name="cashDate" value="<%=cashDate%>" readonly=readonly></td>
				</tr>
				<tr>
					<td>
						<select name="categoryNo">
							<%
								for(Category c : categoryList){
							%>
									<option value="<%=c.getCategoryNo()%>"><%=c.getCategoryKind()%> <%=c.getCategoryName()%></option>								
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td><input type="number" name="cashPrice">원</td>
				</tr>
				<tr>
					<td><textarea cols="50" rows="2" name="cashMemo"></textarea></td>
				</tr>
			</table>
			<button type="submit">등록</button>
		</form>
		<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?cashDate=<%=cashDate%>">이전</a>
	</div>
</body>
</html>