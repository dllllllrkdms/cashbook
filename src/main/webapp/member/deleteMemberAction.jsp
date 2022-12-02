<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String deleteAccount = request.getParameter("deleteAccount"); // 탈퇴 동의 checkbox : value값 : true 
	String redirectUrl="/member/deleteMemberForm.jsp";
	if(deleteAccount==null||!deleteAccount.equals("true")||memberId==null||memberId.equals("")||memberPw==null||memberPw.equals("")){
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	MemberDao memberDao = new MemberDao();
	int row = memberDao.deleteMember(member);
	if(row==1){
		//System.out.println(row+"<--deleteMemberAction");
		redirectUrl="/member/logout.jsp";
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>