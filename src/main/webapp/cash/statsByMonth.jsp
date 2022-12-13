<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.*"%> <!-- DecimalFormat -->
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// C
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null){ // 로그인 유효성 검사
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String memberId = loginMember.getMemberId();
	int year = 0;
	if(request.getParameter("year")!=null){
		year = Integer.parseInt(request.getParameter("year"));
	} else{ // 파라메타 값이 없다면, 올해 연도를 보여줌
		Calendar c = Calendar.getInstance();
		year = c.get(Calendar.YEAR);
	}
	StatsDao statsDao = new StatsDao();
	ArrayList<HashMap<String, Object>> list = statsDao.selectStatsByMonth(memberId, year);
	HashMap<String, Integer> map = statsDao.selectMinMaxYear(memberId);
	int minYear = map.get("minYear");
	int maxYear = map.get("maxYear");
	
	DecimalFormat df = new DecimalFormat("###,###"); // 3자리마다 반점찍는 포맷설정
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>statsByMonth</title>
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
					<div class="card">
		          		<div class="card-body">
		          			<div class="card-body demo-vertical-spacing demo-only-element">
		          				<div class="card-header fs-3 fw-semibold mb-4">
		          					<%=year%> 년 월별 통계
		          				</div>
								<div>
									<%
										if(year>minYear){
									%>
											<span class="mx-3"><a href="<%=request.getContextPath()%>/cash/statsByMonth.jsp?year=<%=year-1%>"><i class='bx bx-chevron-left'></i><%=year-1%></a></span>
									<%
										}
									%>
									&nbsp;
									<%
										if(year<maxYear){
									%>
											<span class="mx-3"><a href="<%=request.getContextPath()%>/cash/statsByMonth.jsp?year=<%=year+1%>"><%=year+1%><i class='bx bx-chevron-right'></i></a></span>
									<%
										}
									%>
								</div>	
								<table class="table">
									<tr>
										<th>월</th>
										<th>수입합계</th>
										<th>수입평균</th>
										<th>지출합계</th>
										<th>지출평균</th>
									</tr>
									<%
										for(HashMap<String, Object> m : list){
									%>
											<tr>
												<td><%=m.get("month")%>월</td>
												<td><%=df.format((Long)m.get("sumImport"))%>원</td>
												<td><%=df.format((Long)m.get("avgImport"))%>원</td>
												<td><%=df.format((Long)m.get("sumExport"))%>원</td>
												<td><%=df.format((Long)m.get("avgExport"))%>원</td>
											</tr>
									<%
										}
									%>
								</table>
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
<script src="<%=request.getContextPath()%>/resources/js/main.js"></script>

<!-- Page JS -->
 <script src="<%=request.getContextPath()%>/resources/js/dashboards-analytics.js"></script>
</body>
</html>