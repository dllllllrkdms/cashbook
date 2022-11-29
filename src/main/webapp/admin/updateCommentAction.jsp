<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	request.setCharacterEncoding("UTF-8");
	String commentNo = request.getParameter("commentNo");
	String commentMemo = request.getParameter("commentMemo");
	String memberId = request.getParameter("memberId"); // 답변 작성자 
	String msg = URLEncoder.encode("다시 입력해주세요","UTF-8");
	String redirectUrl = "/admin/updateCommentForm.jsp?msg="+msg;
	if(commentNo==null||commentNo.equals("")||commentMemo==null||commentMemo.equals("")||memberId==null||memberId.equals("")){ // 파라메타값 유효성검사
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	Comment comment = new Comment();
	comment.setCommentNo(Integer.parseInt(commentNo));
	comment.setCommentMemo(commentMemo);
	comment.setMemberId(memberId);
	CommentDao commentDao = new CommentDao();
	int row = commentDao.updateComment(comment);
	if(row==1){
		//System.out.println(row+"<--updateCommentAction row");
		redirectUrl = "/admin/helpList.jsp";
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>