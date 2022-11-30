<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 로그인, 레벨(접근) 유효성 검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage); // Model 호출 (공지목록)
	int totalCount = noticeDao.totalCount(); // 페이징
	int lastPage = totalCount/rowPerPage;
	if(totalCount%rowPerPage!=0){ // 남은 글이 있으면 페이지+1
		lastPage+=1;
	}
	if(currentPage<1){ // 강제로 페이지를 첫페이지보다 작게 했을경우
		currentPage=1;
	}
	if(currentPage>lastPage){ // 강제로 페이지를 마지막페이지보다 크게 했을경우
		currentPage=lastPage;
	}
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeList</title>
</head>
<body>
	<!-- 로그인 정보 -->
	<div>
		<jsp:include page="/inc/userMenu.jsp"></jsp:include>
	</div>
	<!-- 관리자메뉴 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<!-- notice contents -->
	<div>
		<!-- notice 추가 폼 -->
		<table>
			<tr>
				<th>NO</th>
				<th>공지내용</th>
				<th>공지날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(Notice n : noticeList){
			%>
					<tr>
						<td><%=n.getNoticeNo()%></td>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
						<td><a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=(int)n.getNoticeNo()%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/admin/deleteNotice.jsp?noticeNo=<%=(int)n.getNoticeNo()%>">삭제</a></td>
					</tr>
			<%
				}
			%>
		</table>
		<!-- 페이징 -->
		<div>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음으로</a>
			<%
				if(currentPage>1){
			%>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
			<%=currentPage%>
			<%
				if(currentPage<lastPage){
			%>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%	
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
	</div>
</body>
</html>