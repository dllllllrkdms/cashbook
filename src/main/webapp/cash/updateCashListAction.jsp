<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	request.setCharacterEncoding("UTF-8");
	Cash cash = new Cash();
	cash.setMemberId(request.getParameter("memberId"));
	cash.setCashNo(Integer.parseInt(request.getParameter("cashNo")));
	cash.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	cash.setCashPrice(Long.parseLong(request.getParameter("cashPrice")));
	cash.setCashDate(request.getParameter("cashDate"));
	cash.setCashMemo(request.getParameter("cashMemo"));
	CashDao cashDao = new CashDao();
	boolean result = cashDao.updateCashList(cash);
	String msg = URLEncoder.encode("다시 입력해주세요","UTF-8");
	String redirectUrl = "/cash/cashDateList.jsp?cashDate="+cash.getCashDate()+"&msg="+msg;
	if(result){
		//System.out.println("수정 성공");
		redirectUrl = "/cash/cashDateList.jsp?cashDate="+cash.getCashDate();
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>