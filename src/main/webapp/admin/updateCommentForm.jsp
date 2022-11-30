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
	if(request.getParameter("commentNo")==null){
		response.sendRedirect(request.getContextPath()+"/admin/helpList.jsp");
		return;
	}
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	CommentDao commentDao = new CommentDao();
	Comment comment = commentDao.selectCommentOne(commentNo);
	HelpDao helpDao = new HelpDao();
	Help help = helpDao.selectHelpOne(comment.getHelpNo());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCommentForm</title>
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
	<div>
		<form action="<%=request.getContextPath()%>/admin/updateCommentAction.jsp" method="post">
			<input type="hidden" name="commentNo" value="<%=commentNo%>">
			<div>
				<!-- 문의 글 -->
				<div>문의내용 : <%=help.getHelpMemo()%></div>
				<div>작성자 : <%=help.getMemberId()%></div>
			</div>
			<hr>
			<div>
				답변작성자 :
				<input type="hidden" name="memberId" value="<%=loginMemberId%>"> <!-- 새로운 답변작성자 -->
				<%=comment.getMemberId()%> <!-- 이전 답변작성자 -->
			</div>
			<div>
				<div>답변내용</div>
				<textarea cols="50" rows="5" name="commentMemo"><%=comment.getCommentMemo()%></textarea>
			</div>
			<button type="submit">등록</button>
		</form>
	</div>
</body>
</html>