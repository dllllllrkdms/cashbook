<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<% 
	// Controller
	if(request.getParameter("noticeNo")==null){
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
		return;
	}
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.deleteNotice(noticeNo);
	if(row==1){
		//System.out.println(row+"<--deleteNotice row");
	}
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
%>