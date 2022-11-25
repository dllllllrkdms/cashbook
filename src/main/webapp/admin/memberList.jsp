<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 관리자 페이지 조건
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int currentPage=1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage")); 
	}
	int rowPerPage=10;
	int beginRow=(currentPage-1)*rowPerPage;
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	int count = memberDao.totalCount();
	int lastPage = count/rowPerPage;
	if(count%rowPerPage!=0){ // 남은 목록이 있다면 페이지+1
		lastPage+=1;
	}
	if(currentPage<1){ // 임의로 currentPage를 첫페이지보다 낮췄을 경우
		currentPage=1;
	}
	if(currentPage>lastPage){ // 임의로 currentPage를 마지막페이지보다 크게 했을 경우
		currentPage=lastPage;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList</title>
</head>
<body>
	<!-- 로그인 정보 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<!-- memberList contents -->
	<h1>멤버 목록</h1>
	<div>
		<table>
			<tr>
				<th>멤버번호</th>
				<th>아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>마지막 수정일자</th>
				<th>생성일자</th>
				<th>레벨수정</th>
				<th>강제탈퇴</th>
			</tr>
			<%
				for(Member m : memberList){
			%>
					<tr>
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getMemberId()%></td>
						<td><%=m.getMemberLevel()%></td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getUpdatedate()%></td>
						<td><%=m.getCreatedate()%></td>
						<td>
							<input type="number" name="newMemberLevel">
							<a href="<%=request.getContextPath()%>/admin/updateMemberLevel.jsp?member=<%=m%>">변경</a>
						</td>
						<td><a href="<%=request.getContextPath()%>/admin/deleteMember.jsp?memberId=<%=m.getMemberId()%>">강제탈퇴</a></td>
					</tr>
			<%
				}
			%>
		</table>
	</div>
	<!-- memberList 페이징 -->
	<div>
		<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1">처음</a>
		<%
			if(currentPage>1){
		%>
				<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<% 
			}
		%>
		<%=currentPage%>
		<%
			if(currentPage<lastPage){
		%>
				<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<% 
			}
		%>
		<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">마지막</a>
	</div>
</body>
</html>