<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	request.setCharacterEncoding("UTF-8"); // 인코딩
	String msg = URLEncoder.encode("다시 입력해주세요","UTF-8");
	String redirectUrl = "/help/insertHelpForm.jsp";
	String helpMemo = request.getParameter("helpMemo");
	String memberId = request.getParameter("memberId");
	if(helpMemo==null||helpMemo.equals("")||memberId==null||memberId.equals("")){
		redirectUrl+="?msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	Help help = new Help();
	help.setHelpMemo(helpMemo);
	help.setMemberId(memberId);
	HelpDao helpDao = new HelpDao();
	int row = helpDao.insertHelp(help);
	if(row==1){
		//System.out.println(row+"insertHelpAction row");
		redirectUrl = "/help/helpList.jsp";
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>