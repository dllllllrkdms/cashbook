/**
 * 
 */
// loginForm.jsp, insertMemberForm.jsp, updateMemberForm.jsp,  updateMemberPwForm.jsp
let submitBtn = window.document.querySelector('#submitBtn');
submitBtn.addEventListener('click', function(){ // 버튼 클릭시 함수 실행
	let username = document.querySelector('#username');
	if(username!=null && username.value==''){
		alert('이름을 입력해주세요');
		username.focus();
		return;
	}
	let id = document.querySelector('#id'); // #id 값 저장
	if(id!=null && id.value==''){ // id의 값이 공백이면 
		alert('아이디를 입력해주세요');
		id.focus(); // id로 마우스 커서 옮김
		return;
	}
	let pw = document.querySelector('#pw'); // 현재 비밀번호
	if(pw!=null && pw.value==''){
		alert('비밀번호를 입력해주세요');
		pw.focus();
		return;
	}
	let password = document.querySelector('#password'); // 비밀번호 
	if(password.value==''){
		alert('비밀번호를 입력해주세요');
		password.focus();
		return;
	}
	let checkPw = document.querySelector('#checkPw'); // 비밀번호 확인
	if(checkPw!=null && password.value != checkPw.value){
		alert('비밀번호를 확인해주세요');
		password.focus();
		return;
	}
	let loginForm = document.querySelector('#loginForm');
	if(loginForm!=null){
		loginForm.submit();
		return;
	}
	let insertMemberForm = document.querySelector('#insertMemberForm');
	if(insertMemberForm!=null){
		insertMemberForm.submit();
		return;
	}
	let updateMemberForm = document.querySelector('#updateMemberForm');
	if(updateMemberForm!=null){
		updateMemberForm.submit();
		return;
	}
	let updateMemberPwForm = document.querySelector('#updateMemberPwForm');
	if(updateMemberPwForm!=null){
		updateMemberPwForm.submit();
		return;
	}
	let deleteMemberForm = document.querySelector('#deleteMemberForm');
	if(deleteMemberForm!=null){
		deleteMemberForm.submit();
		return;
	}
});

