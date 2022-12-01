<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
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
					<i class="menu-icon tf-icons bx bx-calendar" ></i>
					<div>가계부</div>
				</a>
			</li>
			<!-- 고객센터 -->
			<li class="menu-item">
				<a href="<%=request.getContextPath()%>/help/helpList.jsp" class="menu-link">
					<i class="menu-icon tf-icons bx bxs-user-voice" ></i>
					<div>고객센터</div>
				</a>
			</li>
		</ul>
	</aside>