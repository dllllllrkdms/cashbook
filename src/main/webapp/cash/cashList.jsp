<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.*"%> <!-- DecimalFormat -->
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%> <!-- Calendar, ArrayList -->
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>
<%
	// 1. Controller : session, request
	String msg = URLEncoder.encode("다시 입력해주세요","UTF-8");
	String redirectUrl = "/loginForm.jsp";
	if(session.getAttribute("loginMember")==null){ // session 유효성검사
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	// 날짜 출력
	int year = 0;
	int month = 0;	
	// 파라메타값 유효성검사 입력날짜값이 없으면 오늘날짜 보여주기
	if(request.getParameter("year")==null||request.getParameter("year").equals("")||request.getParameter("month")==null||request.getParameter("month").equals("")){ 
		Calendar today = Calendar.getInstance(); // 오늘날짜 
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH); // 1월:0, 12월:11
	} else{
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month == -1 -> 작년 12월, month == 12 -> 내년 1월
		if(month == -1){
			year -= 1;
			month = 11;
		}
		if(month == 12){
			year += 1;
			month = 0;
		}
	}
	// 출력하고자 하는 연도,월의 1일의 요일(일:1, 월:2, 화:3,...)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1); // 1일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // firstDay는 1일의 요일
	// 마지막 날짜 
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	//System.out.println(lastDate+"");
	// 달력 시작 공백칸과 마지막공백칸의 갯수
	int beginBlank = firstDay - 1;
	int endBlank = 0; // 7로 나누어떨어진다 
	if((beginBlank + lastDate)%7!=0){
		endBlank = 7-(beginBlank + lastDate)%7;
	}
	// 전체 td의 개수 
	int totalTd = beginBlank + lastDate + endBlank;
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String,Object>> cashDateList = null;
	
	// 이달의 지출 분석
	StatsDao statsDao = new StatsDao();
	HashMap<String, Object> map = statsDao.selectIncrementByMonth(memberId, year, month+1); // 전월 비교 증감액
	HashMap<String, Object> map2 = statsDao.selectMaxPriceByCategory(memberId, year, month+1); // 이번 달 가장 많이 지출한 카테고리와 금액
	
	DecimalFormat df = new DecimalFormat("###,###"); // 3자리마다 반점찍는 포맷설정
%>
<!DOCTYPE html>
<html class="light-style layout-menu-fixed">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>가계부</title>
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendor/libs/apex-charts/apex-charts.css" />

<!-- Helpers -->
<script src="<%=request.getContextPath()%>/resources/vendor/js/helpers.js"></script>

<script src="<%=request.getContextPath()%>/resources/js/config.js"></script>
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
<style>
	.cellCalendar{
		display: table-cell;
		white-space: nowrap; /*칸을 넘어가는 내용은 보이지 않음(짤려서 출력)*/
		overflow: hidden auto;
		height: 100px;
		vertical-align:top;
	}
	.table:not(.table-dark) .sat, .dateCell > td:nth-last-child(1) a{ /* 토요일, 마지막 td에서 1번째 */
	 	color: #0060FF;
	}
	.table:not(.table-dark) .sun, .dateCell > td:nth-child(1) a{ /* 일요일, 첫 번째 td */
		color: #E3242B;
	}
	.income{
		background-color: #73C5FF;
	}
	.spending{
		background-color: #FF6666;
	}
	.income-c{
		color: #73C5FF;
	}
	.spending-c{
		color: #FF6666;
	}
	td a {
		color: #566a7f;
	}
</style>
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
					<div class="row mb-4">
			  			<div class="col-4">
			 	 			<div class="card">
			 	 				<div class="card-body">
			 	 					지난 달에 비해 <span class="income-c">수입이</span> <br> <h4 class="mb-0 income-c"><%=df.format(map.get("importIncrement"))%>원</h4> 늘었습니다.
			 	 				</div>
			 	 			</div>
			  			</div>
			  			
			  			<div class="col-4">
			 	 			<div class="card">
			 	 				<div class="card-body">
			 	 					지난 달에 비해 <span class="spending-c">지출이</span> <br> <h4 class="mb-0 spending-c"><%=df.format(map.get("exportIncrement"))%>원</h4> 늘었습니다.
			 	 				</div>
			 	 			</div>
			  			</div>
			  			
			  			<div class="col-4">
			 	 			<div class="card">
			 	 				<div class="card-body">
			 	 					이번 달은 <br> <h4 class="mb-0 spending-c"><%=map2.get("categoryName")%></h4> 에 가장 많이 지출하였습니다.
			 	 				</div>
			 	 			</div>
			  			</div>
			  			
				  	</div>
				
		          <div class="card">
		          	<div class="card-body">
		          		<div class="card-body demo-vertical-spacing demo-only-element">
							<div class="card-header fs-3 fw-semibold mb-4">
							
								<!-- nav -->
								<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>" class="btn">
									<i class='bx bxs-chevron-left' ></i>
								</a>
								<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>" class="btn">
									<i class='bx bxs-chevron-right' ></i>
								</a>
								<%=year%>년 <%=month+1%>월
							</div>
							
							<div>
								<table class="table table-bordered">
									<thead class="text-center">
									<tr>
										<th class="sun">일</th>
										<th>월</th>
										<th>화</th>
										<th>수</th>
										<th>목</th>
										<th>금</th>
										<th class="sat">토</th>
									</tr>
									</thead>
									
									<!-- 날짜 출력 -->
									<tbody>
										<tr class="dateCell">
										<%
											for(int i=1; i<=totalTd; i++){
												int date = i-beginBlank;
										%>
												<td class="col-4 cellCalendar">
										<%
												if(date>0&&date<=lastDate){
													// 0보다 작은 월,일 두자리수 포맷 설정
													String dateFormat = date < 10 ? "0"+date : String.valueOf(date);
													String monthFormat = (month+1) < 10 ? "0"+ (month+1) : String.valueOf(month+1);
													
													String cashDate = year+"-"+monthFormat+"-"+dateFormat;
													//System.out.println(cashDate+"<-- cashList cashDate");
										%>
													<div><a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?cashDate=<%=cashDate%>"><%=date%></a></div>
										<%			
													cashDateList = cashDao.selectCashListByDate(memberId, cashDate); // 날짜별 데이터 가져오기
													
													// 날짜별 데이터 출력
													for(HashMap<String, Object> m : cashDateList){
										%>
														<!-- Object타입을 형변환하여 사용 -->
														<%
															if(((String)m.get("categoryKind")).equals("수입")){
														%>
																<button type="button" class="btn btn-xs income">
														<%
															} else {
														%>	
																<button type="button" class="btn btn-xs spending">
														<%
															}
														%>
														<a style="color: white;" href="<%=request.getContextPath()%>/cash/cashDateList.jsp?cashDate=<%=cashDate%>"><%=(String)m.get("categoryName")%>&nbsp;<%=df.format((Long)m.get("cashPrice"))%>원</a>
													</button>
													<br>
										<%
													}
												}
										%>
												</td>
										<%
												if(i%7==0 && i!=totalTd){
										%>
													</tr><tr class="dateCell">
										<%
												}
											}			
										%>
									</tbody>
									
								</table>
							</div>
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


<!-- Core JS -->
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