<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	Member loginMember=(Member)session.getAttribute("loginMember");
	String redirectUrl = "/help/helpList.jsp";
	if(loginMember==null){ // 로그인 유효성검사
		redirectUrl="/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	if(request.getParameter("helpNo")==null){ // 파라메타값 유효성검사
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	HelpDao helpDao = new HelpDao();
	Help help = helpDao.selectHelpOne(helpNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateHelpListForm</title>
</head>
<body>
	<!-- 로그인 정보 출력 -->
	<div>
		<jsp:include page="/inc/userMenu.jsp"></jsp:include>
	</div>
	<h1>고객센터</h1>
	<div>
		<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post">
			<input type="hidden" name="helpNo" value="<%=helpNo%>">
			<input type="hidden" name="memberId" value="<%=help.getMemberId()%>">
			<div>
				문의내용 : 
				<textarea cols="50" rows="5" name="helpMemo"><%=help.getHelpMemo()%></textarea>
			</div>
			<div>
				작성일자 : 
				<%=help.getCreatedate()%>
			</div>
			<button type="submit">등록</button>
		</form>
	</div>
	<!-- footer -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>