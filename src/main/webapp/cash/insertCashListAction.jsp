<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	request.setCharacterEncoding("UTF-8");
	Cash cash = new Cash();
	cash.setCashDate(request.getParameter("cashDate"));
	cash.setMemberId(request.getParameter("memberId"));
	cash.setCashMemo(request.getParameter("cashMemo"));
	cash.setCashPrice(Long.parseLong(request.getParameter("cashPrice")));
	cash.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	CashDao cashDao = new CashDao();
	int row = cashDao.insertCashList(cash);
	String msg = URLEncoder.encode("다시 시도해주세요","UTF-8");
	String redirectUrl = "/cash/insertCashListForm.jsp?=msg"+msg;
	if(row==1){
		//System.out.println(row+"<--insertCashListAction row");
		redirectUrl = "/cash/cashDateList.jsp?cashDate="+cash.getCashDate();
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>