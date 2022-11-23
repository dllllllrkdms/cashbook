<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	if(session.getAttribute("loginMember")==null){ // 로그인 상태가 아니면 이 페이지 접근불가
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String cashDate = null; 
	int year = 0;
	int month = 0;
	int date = 0;
	if(request.getParameter("cashDate")==null){ 
		Calendar today = Calendar.getInstance(); // 오늘날짜 
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH)+1; // 1월:0, 12월:11
		date = today.get(Calendar.DATE);
	}else{
		cashDate = request.getParameter("cashDate");
		year = Integer.parseInt(cashDate.substring(0, 4));
		month = Integer.parseInt(cashDate.substring(5, 7));
		date = Integer.parseInt(cashDate.substring(8));
	}
	System.out.println(year);
	System.out.println(month);
	System.out.println(date);
	Member loginMember = (Member)session.getAttribute("loginMember"); // 로그인된 세션 불러오기
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
	<div>
		<form action="<%=request.getContextPath()%>/cash/updateCashListAction.jsp" method="post">
			<input type="hidden" name="cashNo" value="<%=cashNo%>">
			<input type="hidden" name="memberId" value="<%=memberId%>">
			<table border="1">
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
					<td><input type="date" name="cashDate" value="<%=cashDate%>" readonly=readonly></td>
				</tr>
				<tr>
					<td><textarea cols="50" rows="2" name="cashMemo"></textarea></td>
				</tr>
			</table>
			<button type="submit">등록</button>
		</form>
	</div>
</body>
</html>