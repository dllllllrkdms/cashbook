<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 	
	String redirectUrl = "/admin/memberList.jsp";
	if(request.getParameter("memberId")==null||request.getParameter("memberId").equals("")||request.getParameter("newMemberLevel")==null||request.getParameter("newMemberLevel").equals("")){
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	Member paramMember = new Member();	
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberLevel(Integer.parseInt(request.getParameter("newMemberLevel")));
	MemberDao memberDao = new MemberDao();
	int row = memberDao.updateMemberLevel(paramMember);
	if(row==1){
		//System.out.println(row+"<--updateMemberLevel row");
		loginMember.setMemberLevel(paramMember.getMemberLevel());
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
