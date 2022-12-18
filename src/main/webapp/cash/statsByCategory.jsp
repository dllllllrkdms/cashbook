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
	int month = 0;
	if(request.getParameter("year")!=null&&request.getParameter("month")!=null){
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		if(month>12){
			year+=1;
			month=1;
		}
		if(month<1){
			year-=1;
			month=12;
		}
	} else{ // 파라메타 값이 없다면, 올해 연도를 보여줌
		Calendar c = Calendar.getInstance();
		year = c.get(Calendar.YEAR);
		month = c.get(Calendar.MONTH)+1; // 1월:0, 2월:1,...,12월:11 -> +1
	}
	
	
	String categoryName = "급여";
	StatsDao statsDao = new StatsDao();
	ArrayList<HashMap<String, Object>> list = statsDao.selectStatsByCategory(memberId, year, month);
	HashMap<String, Integer> map = statsDao.selectMinMaxDate(memberId);
	int minMonth = map.get("minMonth");
	int maxMonth = map.get("maxMonth");
	int minYear = map.get("minYear");
	int maxYear = map.get("maxYear");
	
	DecimalFormat df = new DecimalFormat("###,###"); // 3자리마다 반점찍는 포맷설정
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>statsByCategory</title>
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
		          					<%=year%>년 <%=month%>월 통계
		          				</div>
		          				<!-- 페이징 -->
								<div>
									<%
										if(year>minYear||(year==minYear&&month>minMonth)){
											String prevMonth = String.valueOf(month-1); // int->String 형변환은 할 수 없음. String.valueOf(int) 사용
											if(prevMonth.equals("0")){
												prevMonth = (year-1)+"년 12";
											}
									%>
											<span class="mx-3"><a href="<%=request.getContextPath()%>/cash/statsByCategory.jsp?year=<%=year%>&month=<%=month-1%>"><i class='bx bx-chevron-left'></i><%=prevMonth%>월</a></span>
									<%
										}
									%>
									&nbsp;
									<%
										if(year<maxYear||(year==maxYear&&month<maxMonth)){
											String nextMonth = String.valueOf(month+1);
											if(nextMonth.equals("13")){
												nextMonth = (year+1)+"년 01";
											}
									%>
											<span class="mx-3"><a href="<%=request.getContextPath()%>/cash/statsByCategory.jsp?year=<%=year%>&month=<%=month+1%>"><%=nextMonth%>월<i class='bx bx-chevron-right'></i></a></span>
									<%
										}
									%>
								</div>	
								
								<table class="table">
									<tr>
										<th>종류</th>
										<th>카테고리 이름</th>
										<th>합계</th>
										<th>평균</th>
									</tr>
									<%
										for(HashMap<String, Object> m : list){
									%>
											<tr>
												<td><%=m.get("categoryKind")%></td>
												<td><%=m.get("categoryName")%></td>
												<td><%=df.format((Long)m.get("sumCashPrice"))%>원</td>
												<td><%=df.format((Long)m.get("avgCashPrice"))%>원</td>
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