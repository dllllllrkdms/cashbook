<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%
	// Controller
	String msg = URLEncoder.encode("다시 입력해주세요","UTF-8");
	String redirectUrl = "/help/helpList.jsp";
	if(request.getParameter("helpNo")==null||request.getParameter("helpNo").equals("")){ // 파라메타값유효성검사
		redirectUrl+="?msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo")); 
	HelpDao helpDao = new HelpDao();
	int row = helpDao.deleteHelp(helpNo);
	if(row==1){
		//System.out.println(row+"<--deleteHelp row");
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>