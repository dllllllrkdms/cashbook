<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	String msg = URLEncoder.encode("다시 입력해주세요","UTF-8");
	String redirectUrl = "/insertMemberForm.jsp?msg="+msg;
	
	if(session.getAttribute("loginMember")!=null){ // 로그인이 되어있다면 접근 불가
		redirectUrl = "/cash/cashList.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	// 빈칸을 입력했을 땐 return;
	if(request.getParameter("memberId")==null||request.getParameter("memberId").equals("")||request.getParameter("memberPw")==null||request.getParameter("memberPw").equals("")
			||request.getParameter("memberName")==null||request.getParameter("memberName").equals("")||request.getParameter("checkPw")==null||request.getParameter("checkPw").equals("")){
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	if(!request.getParameter("memberPw").equals(request.getParameter("checkPw"))){ // 비밀번호와 비밀번호확인이 같지 않으면 
		msg = URLEncoder.encode("비밀번호가 일치하지 않습니다","UTF-8");
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	MemberDao memberDao = new MemberDao();
	Member paramMember = new Member();
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	paramMember.setMemberName(request.getParameter("memberName"));
	int row = memberDao.insertMember(paramMember);
	if(row==1){
		redirectUrl = "/loginForm.jsp";
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
	
%>