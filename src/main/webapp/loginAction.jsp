<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 1. Controller
	// 입력값이 넘어오지 않았을경우
	String msg = URLEncoder.encode("로그인 실패","UTF-8");
	String redirectUrl = "/loginForm.jsp?msg="+msg; // 기본값 -> 로그인 실패
	if(request.getParameter("memberId")==null||request.getParameter("memberId").equals("")||request.getParameter("memberPw")==null||request.getParameter("memberPw").equals("")){	
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	Member paramMember = new Member(); // loginForm에서 전달받은 값 저장
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	// 분리된 Model 호출
	MemberDao memberDao = new MemberDao(); // non-static메서드(login메서드)는 객체 생성 후에 사용
	Member resultMember = memberDao.login(paramMember); // login 메서드 실행
	if(resultMember!=null){ // 로그인 성공 시
		session.setAttribute("loginMember", resultMember); // session에 로그인한 아이디와 이름 저장
		redirectUrl = "/cash/cashList.jsp";
	}
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>