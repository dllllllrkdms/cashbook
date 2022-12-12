<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// C
	//Member loginMember = (Member)session.getAttribute("loginMember");
	Member loginMember = new Member();
	loginMember.setMemberId("goodee");
	loginMember.setMemberName("구원이");
	loginMember.setMemberLevel(0);
	String memberId = loginMember.getMemberId();
	/*
	if(loginMember==null){ // 로그인 유효성 검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = loginMember.getMemberId();
	*/
	String categoryKind = request.getParameter("categoryKind"); // 파라메타 값 유효성 검사
	categoryKind = "지출";
	int year = 0;
	if(request.getParameter("year")!=null){
		year = Integer.parseInt(request.getParameter("year"));
	} else{ 
		Calendar c = Calendar.getInstance(); // 파라메타 값이 null 이면 오늘 연도를 보여줌
		year = c.get(Calendar.YEAR);
	}
	//System.out.println(year+"<--year");
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashSumByYear(memberId, categoryKind);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashSumByYear</title>
</head>
<body> 
	<div>
		<%=categoryKind%>
		<br>
		<%
			for(HashMap<String, Object> m : list){
		%>
				<%=m.get("price")%>
				<%=m.get("year")%>
				<br>
		<%
			}
		%>
	</div>
</body>
</html>