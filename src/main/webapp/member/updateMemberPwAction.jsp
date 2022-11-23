<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%
	// Controller
	String msg = URLEncoder.encode("다시 시도해주세요","UTF-8");
	String redirectUrl = "/updateMemberPwForm.jsp&msg="+msg;
	// 빈칸을 입력받았을때
	if(request.getParameter("memberPw")==null||request.getParameter("memberPw").equals("")||request.getParameter("newMemberPw")==null
		||request.getParameter("newMemberPw").equals("")||request.getParameter("checkPw")==null||request.getParameter("checkPw").equals("")){
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	if(!request.getParameter("newMemberPw").equals(request.getParameter("checkPw"))){ // 비밀번호확인이 다를때
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String newMemberPw = request.getParameter("newMemberPw");
	MemberDao memberDao = new MemberDao();
	boolean result = memberDao.updateMemberPw(memberId, memberPw, newMemberPw);
	if(result){
		redirectUrl = "/loginForm.jsp";
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
	//System.out.println(newMemberPw); // --> 번호가 그대로 나온다
%>