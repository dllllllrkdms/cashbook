<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.*"%>
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
	ArrayList<HashMap<String,Object>> cashList = cashDao.selectCashListByMonth(memberId, year, month+1);
	ArrayList<HashMap<String,Object>> cashDateList = null;
	// 총 수입/지출 
	DecimalFormat df = new DecimalFormat("###,###"); // 3자리마다 반점찍기
	long income = 0;
	long expense = 0;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashList</title>
</head>
<body>
	<!-- 로그인 정보 출력 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<div>
		<%=year%>년 <%=month+1%>월
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">이전 달</a>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>">다음 달</a>
		<table border="1">
			<tr>
				<th>일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th>토</th>
			</tr>
			<tr>
			<%
				for(int i=1; i<=totalTd; i++){
					int date = i-beginBlank;
			%>
					<td>
			<%
					if(date>0&&date<=lastDate){
						String cashDate = year+"-"+(month+1)+"-"+date;
						//System.out.println(cashDate+"<--cashList cashDate");
			%>
						<div>
							<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?cashDate=<%=cashDate%>"><%=date%></a>
						</div>
			<%			
						cashDateList = cashDao.selectCashListByDate(memberId, cashDate);
						for(HashMap<String, Object> m : cashDateList){
			%>
							<!-- 형변환하여 사용 -->
							<%=(String)m.get("categoryKind")%>
							<%=(String)m.get("categoryName")%>
							<%=(Long)m.get("cashPrice")%>원
							<br>
			<%
							// 총 수입/지출액 계산
							if(m.get("categoryKind").equals("수입")){
								income+=(long)m.get("cashPrice");
							} else{
								expense+=(long)m.get("cashPrice");
							}		
						}
					}
			%>
					</td>
			<%
					if(i%7==0&&i!=totalTd){
			%>
						</tr><tr>
			<%
					}
				}			
			%>
		</table>
		<div>수입 :<%out.print(df.format(income));%>원</div>
		<div>지출 :<%out.print(df.format(expense));%>원</div>
		<div>총 잔액: <%out.print(df.format(income-expense));%>원</div>
	</div>
</body>
</html>