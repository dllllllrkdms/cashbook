/**
 * 
 */
let submitBtn = window.document.querySelector('#submitBtn');
submitBtn.addEventListener('click', function(){
	let radioCategory = document.querySelectorAll('#radioCategory:checked');
	if(document.querySelector('#radioCategory')!=null&&radioCategory.length!=1){
		alert('카테고리를 선택하세요');
		return;
	}
	let selectCategory = document.querySelector('#selectCategory');
	if(selectCategory!=null&&selectCategory.value==''){
		alert('카테고리를 선택하세요');
		return;
	}
	let cash = document.querySelector('#cash');
	if(cash!=null && cash.value==''){
		alert('내용을 입력해주세요');
		cash.focus();
		return;
	}
	let memo = document.querySelector('#memo');
	if(memo!=null && memo.value==''){
		alert('내용을 입력해주세요');
		memo.focus();
		return;
	}
	
	let form = document.querySelector('#form');
	if(form!=null){
		form.submit();
		return;
	}

})