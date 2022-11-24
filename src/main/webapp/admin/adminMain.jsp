<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// Model 호출
	// 최근공지 5개, 최근추가된멤버5명
	// View
	// 카테고리 CRUD

	//전체 member 목록 가능, 강퇴, 레벨수정

	//공지 게시판 CRUD (일반사용자는 readonly : loginForm.jsp에 공지목록 뛰우기)

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminMain</title>
</head>
<body>
	<ul>
		<li><a href="">공지관리</a></li>
		<li><a href="">카테고리관리</a></li>
		<li><a href="">멤버관리(목록보기, 레벨수정, 강제탈퇴)</a></li>
	</ul>
</body>
</html>