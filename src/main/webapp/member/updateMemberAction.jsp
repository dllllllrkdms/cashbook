<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	request.setCharacterEncoding("UTF-8"); // 인코딩
	String msg = URLEncoder.encode("다시 시도해주세요","UTF-8");
	String redirectUrl = "/member/updateMemberForm.jsp?msg="+msg;
	// 파라메타값 유효성검사
	if(request.getParameter("memberId")==null||request.getParameter("memberId").equals("")||request.getParameter("memberName")==null
			||request.getParameter("memberName").equals("")||request.getParameter("memberPw")==null||request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	Member paramMember = new Member();
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberName(request.getParameter("memberName"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.updateMember(paramMember); // 회원정보수정 메서드실행 
	if(resultMember!=null){
		session.setAttribute("loginMember", resultMember); // 수정된 정보를 session에 다시 저장
		redirectUrl = "/member/memberOne.jsp";
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
