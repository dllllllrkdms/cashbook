<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	String msg = URLEncoder.encode("다시 입력해주세요","UTF-8");
	String redirectUrl = "/admin/helpList.jsp";
	if(request.getParameter("commentNo")==null){
		redirectUrl+="?msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	CommentDao commentDao = new CommentDao();
	int row = commentDao.deleteCommemt(commentNo);
	if(row==1){
		//System.out.println(row+"<--deleteComment row");
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>