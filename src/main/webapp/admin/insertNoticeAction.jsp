<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// Controller
	request.setCharacterEncoding("UTF-8"); // 인코딩
	String noticeMemo = request.getParameter("noticeMemo");
	String redirectUrl = "/admin/insertNoticeForm.jsp";
	if(noticeMemo==null||noticeMemo.equals("")){
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.insertNotice(noticeMemo); // 공지사항 추가 메서드 실행 
	//System.out.println(row+"<--insertNoticeAction row"); 
	if(row==1){ // row==1 -> 추가 성공
		redirectUrl = "/admin/noticeList.jsp";
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>