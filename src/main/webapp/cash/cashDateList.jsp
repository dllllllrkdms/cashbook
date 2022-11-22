<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	if(session.getAttribute("loginMember")==null){ // 비로그인 시 접근불가
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int year = 0;
	int month = 0;
	int date = 0;
	if(request.getParameter("year")==null||request.getParameter("year").equals("")||request.getParameter("month")==null
			||request.getParameter("month").equals("")||request.getParameter("date")==null||request.getParameter("date").equals("")){ 
		Calendar today = Calendar.getInstance(); // 오늘날짜 
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH)+1; // 1월:0, 12월:11
		date = today.get(Calendar.DATE);
	}else{
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month")); // 1월:1, ... 12월:12
		date = Integer.parseInt(request.getParameter("date"));
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> cashDateList = cashDao.selectCashListByDate(memberId, year, month, date);
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashDateList</title>
</head>
<body>
	<!-- cashDateList 추가 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashListAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=memberId%>">
		<table>
			<tr>
				<td>
				<select name="categoryNo">
				<%
					for(Category c : categoryList){
				%>
						<option value="<%=c.getCategoryNo()%>"><%=c.getCategoryKind()%><%=c.getCategoryName()%></option>
				<%
					}
				%>
				</select>
				</td>
			</tr>
			<tr>
				<td><input type="date" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>"></td>
			</tr>
			<tr>
				<td><textarea cols="50" rows="2" name="cashMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">등록</button>
	</form>
	<!-- cashDateList 출력 -->
	<table border="1">
		<%
			for(HashMap<String, Object> m : cashDateList) {
		%>
				<tr>
					<td><%=(String)m.get("categoryKind")%></td>
					<td><%=(String)m.get("categoryName")%></td>
					<td><%=(Long)m.get("cashPrice")%>원</td>
					<td><%=(String)m.get("cashMemo")%></td>
					<td><a href="<%=request.getContextPath()%>/cash/updateCashListForm.jsp">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/cash/deleteCashListForm.jsp">삭제</a></td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>