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
	System.out.println(cashDate);
	/*
	System.out.println(year);
	System.out.println(month);
	System.out.println(date);
	*/
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> cashDateList = cashDao.selectCashListByDate(memberId, cashDate);
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
				<td><input type="number" name="cashPrice">원</td>
			</tr>
			<tr>
				<td><input type="date" name="cashDate" value="<%=cashDate%>"></td>
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
					<td><a href="<%=request.getContextPath()%>/cash/updateCashListForm.jsp?cashNo=<%=(int)m.get("cashNo")%>&cashDate=<%=cashDate%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/cash/deleteCashListAction.jsp?cashNo=<%=(int)m.get("cashNo")%>&cashDate=<%=cashDate%>">삭제</a></td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>