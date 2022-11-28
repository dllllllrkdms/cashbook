<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 관리자 페이지 조건
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// Model 호출
	// 최근공지 5개, 최근추가된멤버5명
	// View
	// admin 기능  
	//1)카테고리 CRUD
	//2)전체 member 목록 가능, 강퇴, 레벨수정
	//3)공지 게시판 CRUD (일반사용자는 readonly : loginForm.jsp에 공지목록 띄우기)

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminMain</title>
</head>
<body>
	<!-- 로그인 정보 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<!-- 관리자메뉴 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<div>
		<!-- adminMain contents -->
		
	</div>
</body>
</html>