<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	request.setCharacterEncoding("UTF-8"); // 인코딩
	String msg = URLEncoder.encode("다시 입력해주세요","UTF-8");
	String redirectUrl = "/admin/updateCategoryForm.jsp";
	Category category = null; // updateCategoryName메서드의 매개변수 초기화
	String categoryNo = request.getParameter("categoryNo");
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	if(categoryNo==null||categoryNo.equals("")||categoryKind==null||categoryKind.equals("")||categoryName==null||categoryName.equals("")){ // 파라메타 값 유효성검사
		redirectUrl+="?msg"+msg;
		response.sendRedirect(request.getContextPath());
		return;
	}
	category = new Category(); 
	category.setCategoryNo(Integer.parseInt(categoryNo));
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.updateCategoryName(category); // Model 호출
	if(row==1){
		//System.out.println(row+"<--updateCategoryAction row");
		redirectUrl="/admin/categoryList.jsp";		
	}
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>