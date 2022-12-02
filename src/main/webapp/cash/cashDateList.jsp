<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	if(session.getAttribute("loginMember")==null){ // session 유효성검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 파라메타값 유효성검사
	String cashDate = null;
	if(request.getParameter("cashDate")!=null||request.getParameter("cashDate").equals("")==false){ 
		cashDate = request.getParameter("cashDate");
	}else{ // 넘어온 값이 없으면 오늘날짜 설정 
		Calendar today = Calendar.getInstance(); // 오늘날짜 
		int year = today.get(Calendar.YEAR);
		int month = today.get(Calendar.MONTH); // 1월:0, 12월:11
		int date = today.get(Calendar.DATE);
		cashDate = year+"-"+(month+1)+"-"+date;
	}
	//System.out.println(cashDate+"<--cashDateList cashDate");
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> cashDateList = cashDao.selectCashListByDate(memberId, cashDate); // Model호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList(); // Model호출
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed " dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>cashDateList</title>
<meta name="description" content="Most Powerful &amp; Comprehensive Bootstrap 5 HTML Admin Dashboard Template built for developers!" />
<meta name="keywords" content="dashboard, bootstrap 5 dashboard, bootstrap 5 design, bootstrap 5">
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/img/favicon/favicon.ico" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
  href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
  rel="stylesheet">

<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/fonts/boxicons.css" />
    

<!-- Core CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/core.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/theme-default.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/demo.css" />

<!-- Vendors CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

<!-- Canonical SEO -->
   <link rel="canonical" href="https://themeselection.com/products/sneat-bootstrap-html-admin-template/">

<!-- Page CSS -->
<!-- Page -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/pages/page-auth.css">
<!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->
<script src="<%=request.getContextPath()%>/resources/vendor/libs/jquery/jquery.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/libs/popper/popper.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/js/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

<script src="<%=request.getContextPath()%>/resources/vendor/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->

<!-- Main JS -->
<script src="<%=request.getContextPath()%>/resources/js/main.js"></script>

<!-- Page JS -->

<!-- Helpers -->
<script src="<%=request.getContextPath()%>/resources/vendor/js/helpers.js"></script>

<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="<%=request.getContextPath()%>/resources/js/config.js"></script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async="async" src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
window.dataLayer = window.dataLayer || [];

function gtag() {
  dataLayer.push(arguments);
}
gtag('js', new Date());
gtag('config', 'GA_MEASUREMENT_ID');
</script>
<!-- Custom notification for demo -->
<!-- beautify ignore:end -->
</head>
<body>
	<!-- 로그인 정보 출력 -->
	<div>
		<jsp:include page="/inc/userMenu.jsp"></jsp:include>
	</div>
	<!-- insertCashDateListForm -->
	<form action="<%=request.getContextPath()%>/cash/insertCashListAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=memberId%>">
		<table>
			<tr>
				<td><input type="text" name="cashDate" value="<%=cashDate%>" readonly=readonly></td> <!-- 변경불가 -->
			</tr>
			<tr>
				<td>
					<select name="categoryNo">
					<%
						for(Category c : categoryList){
					%>
							<option value="<%=c.getCategoryNo()%>"><%=c.getCategoryKind()%><%=c.getCategoryName()%></option>
					<%
						}
					%>
					</select>
				</td>
			</tr>
			<tr>
				<td><input type="number" name="cashPrice">원</td>
			</tr>
			<tr>
				<td><textarea cols="50" rows="2" name="cashMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">등록</button>
	</form>
	<!-- cashDateList 출력 -->
	<table border="1">
		<%		
			for(HashMap<String, Object> m : cashDateList) {
				int cashNo = (int)m.get("cashNo");
		%>
				<tr>
					<td><%=(String)m.get("categoryKind")%></td>
					<td><%=(String)m.get("categoryName")%></td>
					<td><%=(Long)m.get("cashPrice")%>원</td>
					<td><%=(String)m.get("cashMemo")%></td>
					<td><a href="<%=request.getContextPath()%>/cash/updateCashListForm.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/cash/deleteCashListAction.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>">삭제</a></td>
				</tr>
		<%
			}
		%>
	</table>
	<a href="<%=request.getContextPath()%>/cash/cashList.jsp">이전</a> <!-- cashList.jsp로 돌아가기 -->
	<!-- footer -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>