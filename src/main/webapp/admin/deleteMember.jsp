<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%
	// Controller 
	String redirectUrl = "/admin/memberList.jsp";
	String memberId = request.getParameter("memberId");
	if(memberId==null){
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	MemberDao memberDao = new MemberDao();
	int row = memberDao.deleteMemberByAdmin(memberId);
	if(row==1){
		//System.out.println(row+"<--deleteMemberByAdmin row");
	}
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
%>