<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	String redirectUrl = "/admin/categoryList.jsp";
	if(request.getParameter("categoryNo")==null){ // 파라메타 값 유효성검사
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.deleteCategory(categoryNo);
	if(row==1){ // 디버깅
		//System.out.println(row+"<--deleteCategory row");
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>