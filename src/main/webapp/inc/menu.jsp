<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberName = loginMember.getMemberName();
%>
	<%=memberName%>님 반갑습니다.
	<a href="<%=request.getContextPath()%>/member/memberOne.jsp">내 정보</a>
	<a href="<%=request.getContextPath()%>/cash/cashList.jsp">가계부</a>
	<a href="<%=request.getContextPath()%>/member/logout.jsp">로그아웃</a>
<%
	if(loginMember.getMemberLevel()>0){
%>
		<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자페이지</a>
<%		
	}
%>
