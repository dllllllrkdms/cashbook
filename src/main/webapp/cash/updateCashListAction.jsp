<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	request.setCharacterEncoding("UTF-8"); // 인코딩
	// 파라메타 값유효성검사
	if(request.getParameter("cashNo")==null||request.getParameter("cashNo").equals("")||request.getParameter("cashDate")==null||request.getParameter("cashDate").equals("")){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	if(request.getParameter("categoryNo")==null||request.getParameter("categoryNo").equals("")||request.getParameter("cashPrice")==null
			||request.getParameter("cashPrice").equals("")||request.getParameter("cashMemo")==null||request.getParameter("cashMemo").equals("")){
		response.sendRedirect(request.getContextPath()+"/cash/updateCashListForm.jsp?cashNo="+request.getParameter("cashNo")+"&cashDate"+request.getParameter("cashDate"));
		return;
	}
	Cash cash = new Cash();
	cash.setMemberId(request.getParameter("memberId"));
	cash.setCashNo(Integer.parseInt(request.getParameter("cashNo")));
	cash.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	cash.setCashPrice(Long.parseLong(request.getParameter("cashPrice")));
	cash.setCashDate(request.getParameter("cashDate"));
	cash.setCashMemo(request.getParameter("cashMemo"));
	CashDao cashDao = new CashDao();
	int row = cashDao.updateCashList(cash);
	String msg = URLEncoder.encode("다시 입력해주세요","UTF-8");
	String redirectUrl = "/cash/updateCashListForm.jsp?cashDate="+cash.getCashDate()+"&cashNo="+cash.getCashNo()+"&msg="+msg;
	if(row==1){
		//System.out.println(row+"<--updateCashListAction row");
		redirectUrl = "/cash/cashDateList.jsp?cashDate="+cash.getCashDate();
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>