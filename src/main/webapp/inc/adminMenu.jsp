<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member" %>
<%
    Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember.getMemberLevel()>=1){ // 로그인, 관리자레벨 유효성검사
%>
<li class="menu-item">
   	<a href="javascript:void(0);" class="menu-link menu-toggle">
       	<div><i class='menu-icon tf-icons bx bxs-id-card'></i>관리자 페이지</div>
   	</a>		
   	<ul class="menu-sub">
   		<li class="menu-item">
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp" class="menu-link">
		    	<div>회원</div>
			</a>
		</li>
		<li class="menu-item">
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp" class="menu-link">
				<div>공지사항</div>
			</a>
		</li>
		<li class="menu-item">
			<a href="<%=request.getContextPath()%>/admin/helpList.jsp" class="menu-link">
		    	<div>문의 및 답변</div>
		  	</a>
		</li>
		<li class="menu-item">
			<a href="<%=request.getContextPath()%>/admin/categoryList.jsp" class="menu-link">
		    	<div>카테고리</div>
			</a>
		</li>
     </ul>
</li>
<%
	}
%>