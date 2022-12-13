<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller 
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 관리자 페이지 접근조건
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String search = ""; // 검색단어
	if(request.getParameter("search")!=null&&request.getParameter("search").equals("")==false){
		search = request.getParameter("search");
	}
	int currentPage=1; // 페이징
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage")); 
	}
	int rowPerPage=10;
	int beginRow=(currentPage-1)*rowPerPage;
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage, search); // Model 호출
	int count = memberDao.totalCount();
	int lastPage = count/rowPerPage;
	if(count%rowPerPage!=0){ // 남은 목록이 있다면 페이지+1
		lastPage+=1;
	}
	if(currentPage<1){ // 임의로 currentPage를 첫페이지보다 낮췄을 경우
		currentPage=1;
	}
	if(currentPage>lastPage){ // 임의로 currentPage를 마지막페이지보다 크게 했을 경우
		currentPage=lastPage;
	}
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="<%=request.getContextPath()%>/resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>memberList</title>
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
   		
			<!-- User -->
			<div>
				<jsp:include page="/inc/userMenu.jsp"></jsp:include>
			</div>
			<!-- /User -->
			
			<!-- Content wrapper-->
			<div class="content-wrapper">
				<div class="container-xxl flex-grow-1 container-p-y">
					<h4 class="fw-bold py-3 mb-4">
					  <span class="text-muted fw-light">Admin /</span> member
					</h4>
					<!-- Content -->
					<div class="card">
		          		<div class="card-body">
			
							<div class="row mx-2 mb-3">
								<form action="" method="post">
									<div class="col-12 col-md-6 d-flex align-items-center justify-content-center justify-content-md-start gap-2">
										<div class="col-md-4">
											<input type="search" class="form-control" name="search" placeholder="검색어를 입력하세요" value="<%=search%>">
										</div>
										<button class="btn btn-primary" type="submit">검색</button>
									</div>
								</form>
							</div>
							<div>
								<table class="table">
									<tr>
										<th>멤버번호</th>
										<th>아이디</th>
										<th>레벨</th>
										<th>이름</th>
										<th>생성일자</th>
										<th>레벨수정</th>
										<th>강제탈퇴</th>
									</tr>
									<%
										for(Member m : memberList){
									%>
											<tr>
												<td><%=m.getMemberNo()%></td>
												<td><%=m.getMemberId()%></td>
												<td><%=m.getMemberLevel()%></td>
												<td><%=m.getMemberName()%></td>
												<td><%=m.getCreatedate()%></td>
												<% // 본인의 레벨 수정은 불가하게
													if(loginMember.getMemberId().equals(m.getMemberId())){
												%>
														<td>-</td>
												<%
													} else{
												%>
														<td>
         													<div class="btn-group">
																<button type="button" class="btn btn-icon btn-outline-primary hide-arrow dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
													            	<i class='bx bx-check'></i>
													            </button>
																 <div class="dropdown-menu dropdown-menu-end w-px-300">
																	<form class="p-4" action="<%=request.getContextPath()%>/admin/updateMemberLevel.jsp" method="post">
																		<input type="hidden" name="memberNo" value="<%=m.getMemberNo()%>">
																		<input type="hidden" name="memberId" value="<%=m.getMemberId()%>">
																		<div class="mb-3">
																			<select name="newMemberLevel" class="form-select">
																				<option value="0">0. 일반회원</option>
																				<option value="1">1. 관리자</option>
																			</select>
																		</div>
																		<button type="submit" class="btn btn-primary">변경</button>
																	</form>
																</div>
															</div>
														</td>
												<%
													}
												%>
												<td><a href="<%=request.getContextPath()%>/admin/deleteMember.jsp?memberId=<%=m.getMemberId()%>">탈퇴</a></td>
											</tr>
									<%
										}
									%>
								</table>
							</div>
						</div>
					
						<div class="card-footer">
							<!-- memberList 페이징 -->
							<nav aria-label="Page navigation">
					            <ul class="pagination justify-content-center">
									<li class="page-item prev">
										<a class="page-link" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1&search=<%=search%>"><i class="tf-icon bx bx-chevrons-left"></i></a>
									</li>
									<%
										if(currentPage>1){
									%>
											<li class="page-item">
												<a class="page-link" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>&search=<%=search%>"><i class='bx bx-chevron-left'></i></a>
											</li>
									<% 
										}
									%>
									<li class="page-item active">
										<a class="page-link" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage%>&search=<%=search%>"><%=currentPage%></a>
									</li>
									<%
										if(currentPage<lastPage){
									%>
											<li class="page-item">
												<a class="page-link" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>&search=<%=search%>"><i class='bx bx-chevron-right' ></i></a>
											</li>
									<% 
										}
									%>
									
									<li class="page-item next">
										<a class="page-link" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>&search=<%=search%>"><i class="tf-icon bx bx-chevrons-right"></i></a>
									</li>
					            </ul>
					        </nav>
							<!-- /memberList 페이징 -->
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
		</div>
		<!-- /Layout container -->
		
		<!-- Overlay -->
    	<div class="layout-overlay layout-menu-toggle"></div>
		
	</div>
</div>
<!-- /Layout wrapper -->

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