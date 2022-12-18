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
		<!-- 가계부 -->
		<li class="menu-item">
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="menu-link">
				<div><i class="menu-icon tf-icons bx bx-calendar" ></i>가계부</div>
			</a>
		</li>
		<li class="menu-item">
	    	<a href="javascript:void(0);" class="menu-link menu-toggle">
	        	<div><i class="menu-icon tf-icons bx bx-layout"></i>통계보기</div>
	    	</a>		
	    	<ul class="menu-sub">
				<li class="menu-item">
					<a href="<%=request.getContextPath()%>/cash/statsByYear.jsp" class="menu-link">
						<div>연도별 통계보기</div>
					</a>
				</li>
				<li class="menu-item">
					<a href="<%=request.getContextPath()%>/cash/statsByMonth.jsp" class="menu-link">
				    	<div>월별 통계보기</div>
				  	</a>
				</li>
				<li class="menu-item">
					<a href="<%=request.getContextPath()%>/help/helpList.jsp" class="menu-link">
				    	<div>카테고리별 통계보기</div>
					</a>
				</li>
	      	</ul>
	    </li>
	</ul>
</aside>