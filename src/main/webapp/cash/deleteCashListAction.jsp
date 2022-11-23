<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String cashDate = request.getParameter("cashDate");
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	CashDao cashDao = new CashDao();	
	boolean result = cashDao.deleteCashList(memberId, cashNo);
	String msg = URLEncoder.encode("다시 시도해주세요","UTF-8");
	String redirectUrl = "/cash/cashDateList.jsp"+msg;
	if(result){
		redirectUrl = "/cash/cashDateList.jsp?cashDate="+cashDate;
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>