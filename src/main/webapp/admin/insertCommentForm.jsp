<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	Member loginMember= (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 로그인 유효성검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String loginMemberId = loginMember.getMemberId();
	if(request.getParameter("helpNo")==null){
		response.sendRedirect(request.getContextPath()+"/admin/helpList.jsp");
		return;
	}
	int helpNo=Integer.parseInt(request.getParameter("helpNo"));
	HelpDao helpDao = new HelpDao();
	Help help = helpDao.selectHelpOne(helpNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCommentForm</title>
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
		<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
			<div>
				<!-- 문의 글 -->
				<div>문의내용 : <%=help.getHelpMemo()%></div>
				<div>작성자 : <%=help.getMemberId()%></div>
				<hr>
				<!-- 답변 창 --> 
				<div>
					답변 : 
					<textarea cols="50" rows="2" name="commentMemo"></textarea>
				</div>
				<input type="hidden" name="memberId" value="<%=loginMemberId%>">
				<input type="hidden" name="helpNo" value="<%=helpNo%>">
				<button type="submit">등록</button>
			</div>
		</form>
	</div>
</body>
</html>