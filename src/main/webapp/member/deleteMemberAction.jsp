<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	Member member = new Member();
	member.setMemberId(request.getParameter("memberId"));
	member.setMemberPw(request.getParameter("memberPw"));
	MemberDao memberDao = new MemberDao();
	int row = memberDao.deleteMember(member);
	if(row==1){
		//System.out.println(row+"<--deleteMemberAction");
		response.sendRedirect(request.getContextPath()+"/logout.jsp");
	}
%>