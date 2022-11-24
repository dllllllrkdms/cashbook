<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	request.setCharacterEncoding("UTF-8"); // 인코딩
	String msg = URLEncoder.encode("다시 입력해주세요","UTF-8");
	String redirectUrl = "/insertMemberForm.jsp?msg="+msg;
	// 파라메타값 유효성검사
	if(request.getParameter("memberId")==null||request.getParameter("memberId").equals("")||request.getParameter("memberPw")==null||request.getParameter("memberPw").equals("")
			||request.getParameter("memberName")==null||request.getParameter("memberName").equals("")||request.getParameter("checkPw")==null||request.getParameter("checkPw").equals("")){
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	// 아이디 중복확인 --> insertMemberForm
	MemberDao memberDao = new MemberDao();
	boolean idDupResult = memberDao.idDup(request.getParameter("memberId"));
	String idDupMsg = URLEncoder.encode("사용가능한 아이디입니다.","UTF-8");
	if(idDupResult) { // true이면 중복-> 사용불가
		idDupMsg = URLEncoder.encode("사용할 수 없는 아이디입니다.","UTF-8");
		redirectUrl = "/insertMemberForm.jsp?idDupMsg="+idDupMsg;
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	if(!request.getParameter("memberPw").equals(request.getParameter("checkPw"))){ // 비밀번호와 비밀번호확인이 같지 않으면 
		msg = URLEncoder.encode("비밀번호가 일치하지 않습니다","UTF-8");
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	Member paramMember = new Member();
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	paramMember.setMemberName(request.getParameter("memberName"));
	int insertMemberRow = memberDao.insertMember(paramMember);
	if(insertMemberRow==1){
		//System.out.println("회원가입 성공");
		redirectUrl = "/loginForm.jsp";
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>