/**
 * 
 */
let submitBtn = window.document.querySelector('#submitBtn');
submitBtn.addEventListener('click', function(){
	let check = document.querySelectorAll('#check:checked');
	console.log(check.length);
	if(check.length!=1){
		alert('안내사항을 확인하세요');
		return;
	}
	let password = document.querySelector('#password');
	if(password.value==''){
		alert('비밀번호를 입력하세요');
		return;
	}
	let deleteMemberForm = document.querySelector('#deleteMemberForm');
	if(deleteMemberForm!=null){
		deleteMemberForm.submit();
		return;
	}
})