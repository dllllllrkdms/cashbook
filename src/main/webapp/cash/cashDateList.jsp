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
	if(request.getParameter("cashDate")==null||request.getParameter("cashDate").equals("")){ 
		Calendar today = Calendar.getInstance(); // 오늘날짜 
		int year = today.get(Calendar.YEAR);
		int month = today.get(Calendar.MONTH); // 1월:0, 12월:11
		int date = today.get(Calendar.DATE);
		cashDate = year+"-"+(month+1)+"-"+date;
	}else{ // 넘어온 값이 없으면 오늘날짜 설정 
		cashDate = request.getParameter("cashDate");
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
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>cashDateList</title>
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
						<div class="card-body">
							<div class="card-body">
							
								<div class="col-md-2">
									<h4 class="card-header">
										<%=cashDate%>
									</h4>
								</div>
								<div class="mx-3">
									<p class="demo-inline-spacing">
										<button class="btn btn-primary me-1" type="button" data-bs-toggle="collapse" data-bs-target="#insertCashForm" aria-expanded="false" aria-controls="insertCashForm">
								            <i class="bx bx-plus me-2"></i><span class="fs-5">add</span>
								        </button>
							        </p>
						        </div>
							        
						        <div id="insertCashForm" class="accordion-collapse collapse" data-bs-parent="#accordionCash">
						        	<div class="accordion-body">
						           		<!-- insertCashForm -->
										<form id="form" action="<%=request.getContextPath()%>/cash/insertCashListAction.jsp" method="post">
											<input type="hidden" name="memberId" value="<%=memberId%>">
											<input type="hidden" name="cashDate" value="<%=cashDate%>">
											<div class="row mb-3">
												<div class="col-md-3">
													<select class="form-select" name="categoryNo" id="category">
														<option value="">카테고리 선택</option>
														<%
															for(Category c : categoryList){
														%>
																<option value="<%=c.getCategoryNo()%>"><%=c.getCategoryKind()%><%=c.getCategoryName()%></option>
														<%
															}
														%>
													</select>
												</div> 
												<div class="col-md-3">
													<input class="form-control" id="cash" type="number" name="cashPrice">
												</div>
												<span class="col-form-label col-sm-2">원</span>
											</div>	
											<div class="col-sm-9">
												<textarea cols="50" rows="5" id="memo" name="cashMemo" class="form-control"></textarea>
											</div>
											<div class="mt-3 mb-3">
												<button type="button" id="submitBtn" class="btn btn-primary">등록</button>
												<button type="reset" class="btn btn-outline-secondary">취소</button>
											</div>
										</form>
										<!-- /insertCashForm -->
										<hr class="m-0">
									</div>
						        </div>
						
						
								<!-- cashDateList 출력 -->
								<table class="table table-sm">
									<tbody class="table-border-bottom-0">		
									<%	
										for(HashMap<String, Object> m : cashDateList) {
											int cashNo = (int)m.get("cashNo");
									%>
											<tr>
												<td style="width:50px"><%=(String)m.get("categoryKind")%></td>
												<td style="width:100px"><%=(String)m.get("categoryName")%></td>
												<td style="width:100px"><%=(Long)m.get("cashPrice")%>원</td>
												<td><%=(String)m.get("cashMemo")%></td>
												<td style="width:150px">
													<div class="btn-group">
														<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown"><i class="bx bx-dots-vertical-rounded"></i></button>
														<div class="dropdown-menu">
															<a class="dropdown-item" href="<%=request.getContextPath()%>/cash/updateCashListForm.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>"><i class="bx bx-edit-alt me-1"></i> 수정</a>
															<a class="dropdown-item" href="<%=request.getContextPath()%>/cash/deleteCashListAction.jsp?cashNo=<%=cashNo%>&cashDate=<%=cashDate%>"><i class="bx bx-trash me-1"></i> 삭제</a>
														</div>
													</div>
												</td>
											</tr>
									<%
										}
									%>
									</tbody>
								</table>
								<!-- /cashDateList -->
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

<!-- custom js -->
<script src="<%=request.getContextPath()%>/script/form.js"></script>
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
<script src="<%=request.getContextPath()%>/resources/js/main.js"></script>

<!-- Page JS -->
 <script src="<%=request.getContextPath()%>/resources/js/dashboards-analytics.js"></script>
</body>
</html>