<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	request.setCharacterEncoding("UTF-8");
	String redirectUrl = "/admin/noticeList.jsp";
	if(request.getParameter("noticeNo")==null||request.getParameter("noticeNo").equals("")){ // 파라메타값 유효성검사
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	if(request.getParameter("noticeMemo")==null||request.getParameter("noticeMemo").equals("")){
		redirectUrl = "/admin/updateNoticeForm.jsp?noticeNo="+Integer.parseInt(request.getParameter("noticeNo"));
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	Notice notice = new Notice();
	notice.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
	notice.setNoticeMemo(request.getParameter("noticeMemo")); 
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.updateNotice(notice); 
	if(row==1){
		//System.out.println(row+"<--updateNoticeAction row");
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>