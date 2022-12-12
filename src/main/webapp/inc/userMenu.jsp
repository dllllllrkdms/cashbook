<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member login = (Member)session.getAttribute("loginMember");
	String memberName = login.getMemberName();
	int memberLevel = login.getMemberLevel();
	String levelStr = "";
	if(memberLevel>0){
		levelStr="관리자";
	}
%>
<!-- Navbar -->
<nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
	<div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none ">
        <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)"> 
          <i class="bx bx-menu bx-sm"></i> <!-- 작은화면에서 메뉴보이기 -->
        </a>
    </div>
			    
	<div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
		<!-- User -->
		<ul class="navbar-nav flex-row align-items-center ms-auto">
			<li class="nav-item navbar-dropdown dropdown-user dropdown">
	            <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
	              	<i class="bx bx-user me-2 "></i>
					<%=memberName%><span>님 반갑습니다.</span>
	            </a>
				<ul class="dropdown-menu dropdown-menu-end">
					<li>
						<a class="dropdown-item" href="<%=request.getContextPath()%>/member/updateMemberForm.jsp"> <!-- href="#" : 클릭이벤트 발생시에 페이지전환을 하지 않음  -->
							<div class="d-flex">
								<div class="flex-grow-1">
									<span class="fw-semibold d-block"><%=memberName%></span>
									<small class="text-muted"><%=levelStr%></small>
								</div>
							</div>
						</a>	
					</li>
					<li><div class="dropdown-divider"></div>
					<li>
						<a class="dropdown-item" href="<%=request.getContextPath()%>/member/memberOne.jsp">
							<span class="align-middle">내 정보</span>
						</a>
					</li>
					<li>
						<a class="dropdown-item" href="<%=request.getContextPath()%>/cash/cashList.jsp">
							<span class="align-middle">가계부</span>
						</a>
					</li>
					<%
						if(memberLevel>0){
					%>
						<li>
							<a class="dropdown-item" href="<%=request.getContextPath()%>/admin/adminMain.jsp">
								<span class="align-middle">관리자페이지</span>
							</a>
						</li>
					<%		
					}
					%>
					<li><div class="dropdown-divider"></div></li>
					<li>
						<a class="dropdown-item" href="<%=request.getContextPath()%>/member/logout.jsp">
							<span class="align-middle">로그아웃</span>
						</a>
					</li>
					
				</ul>
			</li>
			<!-- /User -->
		</ul>
	</div>
</nav>
<!-- /Navbar -->
			