<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember==null||loginMember.getMemberLevel()<1){ // 관리자 페이지 조건
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// Model 호출
	// 최근 추가된 공지 5개
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(0,5);
	// 최근 추가된 고객센터 문의글 5개 
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(0, 5);
	// 최근 추가된 멤버 5명
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(0, 5, null);
	// 최근 추가된 카테고리 5개
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList(0,5);
	// View
	// admin 기능  
	//1)카테고리 CRUD
	//2)전체 member 목록 가능, 강퇴, 레벨수정
	//3)공지 게시판 CRUD (일반사용자는 readonly : loginForm.jsp에 공지목록 띄우기)

%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed " dir="ltr" data-theme="theme-default" data-assets-path="./resources/" data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>adminMain</title>
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css"> <!-- Custom css -->
</head>
<style>
	a:link:not(i){
		color:#566a7f;
	}
	a:hover{
		text-decoration: underline;
	}
	a:visited{
		color:#566a7f;
	}
</style>
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
					<div class="row">
					
						<!-- Content -->
						<!-- 최근공지5개 -->
						<div class="col-md-6">
							<div class="card mb-4">
								<div class="card-header">
									<h5 class="d-inline-block">notice</h5>
									<span class="float-end">
										<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">
											<i class='bx bx-plus'></i> 더보기
										</a>
									</span>
								</div>
								<div class="card-body demo-vertical-spacing demo-only-element">
									<%
										for(Notice n : noticeList){
									%>
											<div style="width:inherit">
												<div class="multiline-ellipsis">
													•
													<a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeMemo()%></a>
													<br>
												</div>
											</div>
									<%
										}
									%>
								</div>
							</div>
						</div>
						<!-- 최근고객센터글 5개 -->
						<div class="col-md-6">
							<div class="card mb-4">
								<div class="card-header">
									<h5 class="d-inline-block">help</h5>
									<span class="float-end">
										<a href="<%=request.getContextPath()%>/admin/helpList.jsp">
											<i class='bx bx-plus'></i> 더보기
										</a>
									</span>
								</div>
								<div class="card-body demo-vertical-spacing demo-only-element">
									<%
										for(HashMap<String, Object> h : helpList){
											//System.out.println(h.get("commentNo")+"<--admin");
									%>
											<div style="width:inherit">
												<div class="multiline-ellipsis">
													•
													<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?helpNo=<%=h.get("helpNo")%>&commentNo=<%=h.get("commentNo")%>"><%=h.get("helpMemo")%></a>
													<br>
												</div>
											</div>
									<%
										}
									%>
								</div>
							</div>
						</div>
						<!-- 최근 가입멤버 5명 -->
						<div class="col-md-6">
							<div class="card mb-4">
								<div class="card-header">
									<h5 class="d-inline-block">member</h5>
									<span class="float-end">
										<a href="<%=request.getContextPath()%>/admin/memberList.jsp">
											<i class='bx bx-plus'></i> 더보기
										</a>
									</span>
								</div>
								<div class="card-body demo-vertical-spacing demo-only-element">
									<%
										for(Member m : memberList){
									%>
											<div style="width:inherit">
												<div class="multiline-ellipsis">
													•
													<%=m.getMemberId()%>
													<%=m.getMemberName()%>
													<br>
												</div>
											</div>
									<%
										}
									%>
								</div>
							</div>
						</div>
						<!-- 최근생성카테고리 5개 -->
						<div class="col-md-6">
							<div class="card mb-4">
								<div class="card-header">
									<h5 class="d-inline-block">category</h5>
									<span class="float-end">
										<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">
												<i class='bx bx-plus'></i> 더보기
										</a>
									</span>
								</div>
								<div class="card-body demo-vertical-spacing demo-only-element">
									<%
										for(Category c : categoryList){
									%>
											<div style="width:inherit">
												<div class="multiline-ellipsis">
													•
													<a href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">
														<%=c.getCategoryKind()%> <%=c.getCategoryName()%>
													</a>
													<br>
												</div>
											</div>
									<%
										}
									%>
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
			<!-- /Container wrapper -->
		</div>
		<!-- /Layout container -->
		
		<!-- Overlay -->
    	<div class="layout-overlay layout-menu-toggle"></div>
		
	</div>
</div>
<!-- /Layout wrapper -->
</body>
</html>