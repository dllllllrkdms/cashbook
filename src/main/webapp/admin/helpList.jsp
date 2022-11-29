<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	// 모든 고객센터 문의사항 목록 출력
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 로그인 관리자레벨검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int currentPage=1; // 페이징
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage=10;
	int beginRow=(currentPage-1)*rowPerPage;
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(beginRow, rowPerPage);
	int count = helpDao.totalCountHelpList();
	int lastPage=count/rowPerPage;
	if(count%rowPerPage!=0){ // 올림
		lastPage+=1;
	}
	if(currentPage<1){ // 임의로 현재페이지를 첫페이지보다 작게했을경우
		currentPage=1;
	}
	if(currentPage>lastPage){ // 임의로 현재페이지를 첫페이지보다 크게했을경우
		currentPage=lastPage;
	}
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>helpList</title>
</head>
<body>
	<!-- header include -->
	<!-- 로그인 정보 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<!-- 관리자메뉴 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<!-- 고객센터 문의 목록 -->
	<div>
		<table>
			<tr>
				<th>문의번호</th>
				<th>문의내용</th>
				<th>문의날짜</th>
				<th>답변내용</th>
				<th>답변날짜</th>
				<th>답변 추가/수정/삭제</th>
			</tr>
	<%
		for(HashMap<String, Object> m : helpList){
	%>
			<tr>
				<td><%=m.get("helpNo")%></td>
				<td><%=m.get("helpMemo")%></td>
				<td><%=m.get("helpCreatedate")%></td>
				<%
					if(m.get("commentMemo")==null){
				%>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">답변추가</a></td>
				<%
					}else{
				%>
						<td><%=m.get("commentMemo")%></td>
						<td><%=m.get("commentCreatedate")%></td>
						<td>
							<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>">답변수정</a>
							<a href="<%=request.getContextPath()%>/admin/deleteComment.jsp?commentNo=<%=m.get("commentNo")%>">답변삭제</a>
						</td>
				<%
					}
				%>
			</tr>
	<%
		}
	%>
		</table>
	</div>
	<!-- 페이징 -->
	<a href="<%=request.getContextPath()%>/admin/helpList.jsp?currentPage=1">처음으로</a>
	<%
		if(currentPage>1){
	%>
			<a href="<%=request.getContextPath()%>/admin/helpList.jsp?currentPage=<%=currentPage-1%>">이전</a>
	<%
		}
	%>
	<%=currentPage%>
	<%
		if(currentPage<lastPage){
	%>
			<a href="<%=request.getContextPath()%>/admin/helpList.jsp?currentPage=<%=currentPage+1%>">다음</a>
	<%
		}
	%>
	<a href="<%=request.getContextPath()%>/admin/helpList.jsp?currentPage=<%=lastPage%>">마지막으로</a>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>