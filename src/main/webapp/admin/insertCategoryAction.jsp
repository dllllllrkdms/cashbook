<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	request.setCharacterEncoding("UTF-8");
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	String msg=null;
	String redirectUrl = "/admin/insertCategoryForm.jsp";
	if(categoryKind==null||categoryName==null){
		msg=URLEncoder.encode("다시 입력해주세요","UTF-8");
		redirectUrl += "?msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	Category category = new Category();
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.insertCategory(category);
	if(row==1){
		//System.out.println(row+"<--insertCategoryAction row");
		redirectUrl="/admin/categoryList.jsp";
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
