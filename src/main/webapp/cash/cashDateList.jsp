<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	if(session.getAttribute("loginMember")==null){ // session 유효성검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 파라메타값 유효성검사
	String cashDate = null;
	if(request.getParameter("cashDate")!=null||request.getParameter("cashDate").equals("")==false){ 
		cashDate = request.getParameter("cashDate");
	}else{ // 넘어온 값이 없으면 오늘날짜 설정 
		Calendar today = Calendar.getInstance(); // 오늘날짜 
		int year = today.get(Calendar.YEAR);
		int month = today.get(Calendar.MONTH); // 1월:0, 12월:11
		int date = today.get(Calendar.DATE);
		cashDate = year+"-"+(month+1)+"-"+date;
	}
	//System.out.println(cashDate+"<--cashDateList cashDate");
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> cashDateList = cashDao.selectCashListByDate(memberId, cashDate); // Model호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList(); // Model호출
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashDateList</title>
</head>
<body>
	<!-- 로그인 정보 출력 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<!-- insertCashDateListForm -->
	<form action="<%=request.getContextPath()%>/cash/insertCashListAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=memberId%>">
		<table>
			<tr>
				<td><input type="text" name="cashDate" value="<%=cashDate%>" readonly=readonly></td> <!-- 변경불가 -->
			</tr>
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
				<td><textarea cols="50" rows="2" name="cashMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">등록</button>
	</form>
	<!-- cashDateList 출력 -->
	<table border="1">
		<%		
			for(HashMap<String, Object> m : cashDateList) {
				int cashNo = (int)m.get("cashNo");
		%>
				<tr>
					<td><%=(String)m.get("categoryKind")%></td>
					<td><%=(String)m.get("categoryName")%></td>
					<td><%=(Long)m.get("cashPrice")%>원</td>
					<td><%=(String)m.get("cashMemo")%></td>
					<td><a href="<%=request.getContextPath()%>/cash/updateCashListForm.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/cash/deleteCashListAction.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>">삭제</a></td>
				</tr>
		<%
			}
		%>
	</table>
	<a href="<%=request.getContextPath()%>/cash/cashList.jsp">이전</a> <!-- cashList.jsp로 돌아가기 -->
	<!-- footer -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>