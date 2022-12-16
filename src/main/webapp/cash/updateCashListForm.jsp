<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	if(session.getAttribute("loginMember")==null){ // session(로그인) 유효성 검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String cashDate = null; 
	if(request.getParameter("cashDate")==null||request.getParameter("cashDate").equals("")){ 
		Calendar today = Calendar.getInstance(); // 오늘날짜 
		int year = today.get(Calendar.YEAR);
		int month = today.get(Calendar.MONTH); // 1월:0, 12월:11
		int date = today.get(Calendar.DATE);
		cashDate = year+"-"+(month+1)+"-"+date;
	}else{
		cashDate = request.getParameter("cashDate");
	}
	if(request.getParameter("cashNo")==null){
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?cashDate="+cashDate);
		return;
	}
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	//System.out.println(cashDate);
	Member loginMember = (Member)session.getAttribute("loginMember"); // 로그인한 세션 불러오기
	String memberId = loginMember.getMemberId();
	CashDao cashDao = new CashDao();
	HashMap<String, Object> cashOne = cashDao.selectCashOne(cashDate, cashNo);
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>updateCashForm</title>
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/img/favicon/favicon.ico" />
<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/fonts/boxicons.css" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">

<!-- Core CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/core.css" class="template-customizer-core-css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/css/theme-default.css" class="template-customizer-theme-css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
<link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />

<script src="<%=request.getContextPath()%>/resources/js/config.js"></script>

<!-- Helpers -->
<script src="<%=request.getContextPath()%>/resources/vendor/js/helpers.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID" async ></script>
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css"> <!-- Custom css -->
</head>
<body>
<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar ">
	<div class="layout-container">
  		<!-- Menu -->
  		<div>	
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		<!-- /Menu -->
		
		<!-- Layout container -->
   		<div class="layout-page">
   		 
			<!--User-->
			<div>
				<jsp:include page="/inc/userMenu.jsp"></jsp:include>
			</div>
			<!-- /User -->
			
			<!-- Content wrapper -->
			<div class="content-wrapper">
			
				<!-- Content -->
				<div class="container-xxl flex-grow-1 container-p-y">
					
					<div class="card mb-4">
						<div class="card-body mx-xxl-2 my-xxl-2">
							
							<div class="card-body">
								<form action="<%=request.getContextPath()%>/cash/updateCashListAction.jsp" id="form" method="post">
									<input type="hidden" name="cashNo" value="<%=cashNo%>">
									<input type="hidden" name="memberId" value="<%=memberId%>">
									<div class="mb-3 col-md-2">
										<input class="form-control" type="text" name="cashDate" value="<%=cashDate%>" readonly=readonly> <!-- 변경불가 -->
									</div>
									<div class="row mb-3">
										<div class="col-md-3">
											<select class="form-select" name="categoryNo" id="selectCategory">
												<option value="" selected="selected">카테고리 선택</option>
												<%
													for(Category c : categoryList){
												%>
														<option value="<%=c.getCategoryNo()%>"><%=c.getCategoryKind()%> <%=c.getCategoryName()%></option>								
												<%
													}
												%>
											</select>
										</div>
										<div class="col-md-3">
											<input class="form-control" id="cash" type="number" name="cashPrice" value="<%=cashOne.get("cashPrice")%>">
										</div>
										<span class="col-form-label col-sm-2">원</span>
									</div>
									<div class="col-sm-9">
										<textarea cols="50" rows="4" name="cashMemo" id="memo" class="form-control"><%=cashOne.get("cashMemo") %></textarea>
									</div>
									<div class="mt-3 mb-3">
										<button type="button" id="submitBtn" class="btn btn-primary">등록</button>
										<button type="reset" class="btn btn-outline-secondary">취소</button>
									</div>
								</form>
							</div>	
													
						</div>
					</div>		
				</div>
				<!-- /Content -->
					
					<!-- Footer -->
					<div>
						<jsp:include page="/inc/footer.jsp"></jsp:include>
					</div>
					<!-- /Footer -->
	
				</div>
			<!-- /Content wrapper -->
	
	    <!-- Overlay -->
	    <div class="layout-overlay layout-menu-toggle"></div>
	    
	    </div>
	    <!-- /Layout container -->
    </div>
</div>
<!-- /LayOut wrapper -->



<!-- build:js assets/vendor/js/core.js -->
<script src="<%=request.getContextPath()%>/resources/vendor/libs/jquery/jquery.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/libs/popper/popper.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/js/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/resources/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>


<script src="<%=request.getContextPath()%>/resources/vendor/js/menu.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->
 <script src="<%=request.getContextPath()%>/resources/vendor/libs/apex-charts/apexcharts.js"></script>
<!-- Main JS -->
<script type="module" src="<%=request.getContextPath()%>/resources/js/main.js"></script>

<!-- Page JS -->
 <script src="<%=request.getContextPath()%>/resources/js/dashboards-analytics.js"></script>
 
<!-- custom js -->
<script src="<%=request.getContextPath()%>/script/form.js"></script>
</body>
</html>