<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	request.setCharacterEncoding("UTF-8");
	String helpNo = request.getParameter("helpNo");
	String helpMemo = request.getParameter("helpMemo");
	String memberId = request.getParameter("memberId");
	String msg = URLEncoder.encode("다시 입력해주세요","UTF-8"); // 실패시 전달메시지
	String redirectUrl = "/help/updateHelpForm.jsp?msg="+msg;
	if(helpNo==null||helpNo.equals("")||helpMemo==null||helpMemo.equals("")||memberId==null||memberId.equals("")){ // 파라메타값 유효성검사
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	Help help = new Help();
	help.setHelpNo(Integer.parseInt(helpNo));
	help.setHelpMemo(helpMemo);
	help.setMemberId(memberId);
	HelpDao helpDao = new HelpDao();
	int row = helpDao.updateHelp(help);
	if(row==1){
		System.out.println(row+"<--updateHelpAction row");
		redirectUrl = "/help/helpList.jsp";
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>