<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme" data-bg-class="bg-menu-theme">
	<div class="app-brand demo">
		<a href="#" class="app-brand-link">
			<span class="app-brand-text demo menu-text fw-semibold ms-2">goodee</span>
		</a>
		<a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
			<i class="bx bx-chevron-left bx-sm align-middle"></i>
		</a>
	</div>
	<div class="menu-inner-shadow"></div>
	
	<ul class="menu-inner py-1">
		<li class="menu-item">
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="menu-link">
				<div><i class="menu-icon tf-icons bx bx-calendar" ></i>가계부</div>
			</a>
		</li>
		<li class="menu-item">
	    	<a href="javascript:void(0);" class="menu-link menu-toggle">
	        	<div><i class='menu-icon tf-icons bx bxs-data'></i>결산</div>
	    	</a>		
	    	<ul class="menu-sub">
				<li class="menu-item">
					<a href="<%=request.getContextPath()%>/cash/statsByYear.jsp" class="menu-link">
						<div>연도별</div>
					</a>
				</li>
				<li class="menu-item">
					<a href="<%=request.getContextPath()%>/cash/statsByMonth.jsp" class="menu-link">
				    	<div>월별</div>
				  	</a>
				</li>
				<li class="menu-item">
					<a href="<%=request.getContextPath()%>/cash/statsByCategory.jsp" class="menu-link">
				    	<div>카테고리별</div>
					</a>
				</li>
	      	</ul>
	    </li>
	    
	    <!-- 회원정보 변경 -->
	    <li class="menu-item">
	    	<a href="javascript:void(0);" class="menu-link menu-toggle">
	        	<div><i class="menu-icon tf-icons bx bx-user"></i>마이페이지</div>
	    	</a>		
	    	<ul class="menu-sub">
				<li class="menu-item">
					<a href="<%=request.getContextPath()%>/member/memberOne.jsp" class="menu-link">
						<div>프로필</div>
					</a>
				</li>
				<li class="menu-item">
					<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp" class="menu-link">
				    	<div>회원 정보 수정</div>
				  	</a>
				</li>
				<li class="menu-item">
					<a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp" class="menu-link">
				    	<div>비밀번호 변경</div>
					</a>
				</li>
	      	</ul>
	    </li>
	    
	    <li class="menu-item">
			<a href="<%=request.getContextPath()%>/notice/noticeList.jsp" class="menu-link">
		    	<div><i class="menu-icon tf-icons bx bx-help-circle"></i>공지사항</div>
		  	</a>
		</li>
	    <li class="menu-item">
			<a href="<%=request.getContextPath()%>/help/helpList.jsp" class="menu-link">
		    	<div><i class='menu-icon tf-icons bx bx-user-voice'></i>고객센터</div>
		  	</a>
		</li>
	    <jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</ul>
</aside>