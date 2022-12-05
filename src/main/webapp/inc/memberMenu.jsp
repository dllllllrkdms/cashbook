<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Navbar pills -->
<div class="row">
	<div class="col-md-12">
		<ul class="nav nav-pills flex-column flex-md-row mb-3">
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/member/updateMemberForm.jsp"><i class='bx bx-user'></i> 프로필 수정</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp"><i class='bx bx-lock'></i> 보안설정</a></li>
		</ul>
	</div>
</div>
<!-- /Navbar pills -->